//
//  CertificateUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/12.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "CertificateUtil.h"
//#import "libTWCAMobileCryptoV1090U20141110.h"
#import "libTWCAMobileCryptoV101111U20160715.h"
//#import "AppConfig.h"
#import "CertificateSaveData.h"
#import "ClientAPI.h"
//#import "DataCenter.h"
//#import "TradeResult_CAQueryCert.h"
#import "TradeApi.h"
#import "IosLogic.h"
//#import "LeftViewController.h"
#import "JumpDataCenter.h"
#import "LangCaptain.h"

#define Min30 30 * 60
//#define Min30 12
#define isCertificateNeedCheck true
#define isNeedCheckPhonePin true

#define CABufferSize  8192
#define CAKeySize     2048

static NSDate *oriDate = nil;

static Boolean isLoadPrivate = false;

@implementation CertificateUtil

+ (Boolean)isLoadedRsaKey {
    
    if (!isCertificateNeedCheck) {
        return true;
    }
    
    if (isLoadPrivate) {
        return true;
    }
    
    char *keySetData = [[CertificateSaveData getInstance] getKeySetData];
    char *userPin = [[CertificateSaveData getInstance] getUserPin];
    
    if (userPin == NULL) {
        return false;
    }
    
    if (keySetData == NULL) {
        TradeResult_CACert *reslut = [[TradeApi getInstance] getCertDeviceID:[[CertificateSaveData getInstance] GUID]
                                                                    venderID:@"M"];
        if ([reslut succeed]) {
            NSString *certificateConetxt = [reslut context];
            [self importCerticate:certificateConetxt];
        }
        else {
            return false;
        }
    }
    keySetData = [[CertificateSaveData getInstance] getKeySetData];
    if (keySetData == NULL) {
        return false;
    }
    
    int state = LoadRSAKey(keySetData, userPin);
    if (state == 0) {
        isLoadPrivate = true;
        return true;
    } else {
        return false;
    }
}

+ (Boolean)checkTradeCertState {
    //    return true;
    if (!isCertificateNeedCheck) {
        return true;
    }
    //    char serial[4096];
    char *serial = (char *)malloc(8192);
    memset(serial, 0, 8192);
    getSN(serial);
    NSString *serialString = [NSString stringWithCString:serial encoding:NSUTF8StringEncoding];
    free(serial);
    TradeResult_CAQueryCert *reslut = [[TradeApi getInstance] queryCertDeviceID:[[CertificateSaveData getInstance] GUID]
                                                                       venderID:@"M"
                                                                     certSerial:@""];
    
    FnCertState *fnCertState = [reslut fnCertState];
    [[JumpDataCenter getInstance] setFnCertResult:nil];
    
    if (![reslut succeed]) {
        [[JumpDataCenter getInstance] setFnCertState:nil];
        [[JumpDataCenter getInstance] setFnCertResult:@"NetErr"];
        return false;
    }
    
    if ([[reslut errCode] isEqualToString:@"Err_CATRADE_ServerNotConnection"]) {
        [[JumpDataCenter getInstance] setFnCertState:nil];
        [[JumpDataCenter getInstance] setFnCertResult:@"Err_CATRADE_ServerNotConnection"];
        return false;
    }
    
    if (fnCertState == nil) {
        [[JumpDataCenter getInstance] setFnCertState:nil];
        [[JumpDataCenter getInstance] setFnCertResult:@"CertificateErr"];
        return false;
    }
    
    if ([fnCertState getReturnCode] != 0) { 
        [[JumpDataCenter getInstance] setFnCertResult:@"CANotLoaded"];
        return false;
    }
    
    //    if (([fnCertState getReturnCode] == 0) &&
    //        // 31 即將過期 // 30 已過期
    //        ([fnCertState getCaState] == 0 || [fnCertState getCaState] == 31 || [fnCertState getCaState] == 30)) {
    if (([fnCertState getCaState] == 0 || [fnCertState getCaState] == 31)) {
        [[JumpDataCenter getInstance] setFnCertState:fnCertState];
        [[JumpDataCenter getInstance] setFnCertResult:nil];
        return true;
    }
    
    [[JumpDataCenter getInstance] setFnCertResult:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"CA_%d", [fnCertState getCaState]]]];
    
    return false;
}


+ (Boolean)checkCertState {
    //    return true;
    if (!isCertificateNeedCheck) {
        return true;
    }
    //    char serial[4096];
    char *serial = (char *)malloc(8192);
    memset(serial, 0, 8192);
    getSN(serial);
    NSString *serialString = [NSString stringWithCString:serial encoding:NSUTF8StringEncoding];
    free(serial);
    TradeResult_CAQueryCert *reslut = [[TradeApi getInstance] queryCertDeviceID:[[CertificateSaveData getInstance] GUID]
                                                                       venderID:@"M"
                                                                     certSerial:@""];
    
    FnCertState *fnCertState = [reslut fnCertState];
    [[JumpDataCenter getInstance] setFnCertResult:nil];
    
    if (![reslut succeed]) {
        [[JumpDataCenter getInstance] setFnCertState:nil];
        [[JumpDataCenter getInstance] setFnCertResult:@"NetErr"];
        return false;
    }
    
    if ([[reslut errCode] isEqualToString:@"Err_CATRADE_ServerNotConnection"]) {
        [[JumpDataCenter getInstance] setFnCertState:nil];
        [[JumpDataCenter getInstance] setFnCertResult:@"Err_CATRADE_ServerNotConnection"];
        return false;
    }
    
    if (fnCertState == nil) {
        [[JumpDataCenter getInstance] setFnCertState:nil];
        [[JumpDataCenter getInstance] setFnCertResult:@"CertificateErr"];
        return false;
    }
    
    //    if (([fnCertState getReturnCode] == 0) &&
    //        // 31 即將過期 // 30 已過期
    //        ([fnCertState getCaState] == 0 || [fnCertState getCaState] == 31 || [fnCertState getCaState] == 30)) {
    if ([fnCertState getReturnCode] == 0) {
        [[JumpDataCenter getInstance] setFnCertState:fnCertState];
        [[JumpDataCenter getInstance] setFnCertResult:nil];
        return true;
    } else {
        [[JumpDataCenter getInstance] setFnCertResult:@"CANotLoaded"];
    }
    return false;
}


// 是否需要输入凭证
//+ (Boolean)checkIsneedputPhonePin {
//    if (!isNeedCheckPhonePin) {
//        return false;
//    }
//    return isTouchTime;
//}

+ (Boolean)checkPhonePinByValidate {
    if (!isNeedCheckPhonePin) {
        return false;
    }
    
    long long account = [[ClientAPI getInstance] accountID];
    //    int checkType = [[TradeApi getInstance] checkAccount:account
    //                                                phonePin:[[DataCenter getInstance] phonePin]];
    int checkType = [[TradeApi getInstance] checkAccount:account
                                                phonePin:@"test"];
    if (checkType != CA_TRADE_SUCCEED) {
        isTouchTime = true;
    }
    return isTouchTime;
}

+ (int)makeCSR:(NSString *)userPin {
    int bufferSize = 8192;
    char retCSR[bufferSize], retKeySet[bufferSize];
    char *userPinChar = (char *)[userPin UTF8String];
    
    NSString *CN = [NSString stringWithFormat:@"CN=%@", [[ClientAPI getInstance] aeid]];
    char *CNChar = (char *)[CN UTF8String];
    
    int rState = MakeCSR(2048, CNChar, userPinChar, retCSR, retKeySet, bufferSize);
    if (rState == CA_TRADE_SUCCEED) {
        [[CertificateSaveData getInstance] setCN:CNChar];
        [[CertificateSaveData getInstance] setUserPin:userPinChar];
        [[CertificateSaveData getInstance] setCsr:retCSR];
        [[CertificateSaveData getInstance] setKeySet:retKeySet];
        [[CertificateSaveData getInstance] saveConfigData];
    }
    return rState;
}

+ (NSString *)getKeySet {
    //    char keySet[4096];
    char *keySet = (char *)malloc(4096);
    // 未定， keyset 获取方法， 待确定
    getTwcaPrivateKey(keySet);
    NSString * returnString = [NSString stringWithCString:keySet encoding:NSUTF8StringEncoding];
    free(keySet);
    return returnString;
}

//+ (void)setOriDate:(NSDate *)date {
//    oriDate = date;
//}

//+ (void)resetTimeTickIsEnterBackground:(Boolean)isBackground {
//
//    UIViewController *controller = [[[IosLogic getInstance] getWindow] rootViewController];
//    if ([controller isKindOfClass:[LeftViewController class]]) {
//        LeftViewController *leftViewController = (LeftViewController *)controller;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [leftViewController resetRightView];
//        });
//    }
//
//    if (!isBackground) {
//        isNeedResetTimer = true;
//        //    oriDate = [NSDate date];
//
//        if (isTouchTime) {
//            isTouchTime = false;
//            [self startTimeTick];
//        }
//    } else {
//        isBackgroundResetTimer = true;
//    }
//}

//+ (void)setDestroyTimeTick {
//    isTouchTime = true;
//}

//+ (void)startTimeTick {
//    __block int timeout = Min30; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout <= 0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            isTouchTime = true;
//            oriDate = nil;
//            UIViewController *controller = [[[IosLogic getInstance] getWindow] rootViewController];
//            if ([controller isKindOfClass:[LeftViewController class]]) {
//                LeftViewController *leftViewController = (LeftViewController *)controller;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [leftViewController resetRightView];
//                });
//            }
//        } else {
//            if (isTouchTime) {
//                timeout = 0;
//            }
//            NSLog(@"%d", timeout);
//            if (isNeedResetTimer) {
//                timeout = Min30;
//                isNeedResetTimer = false;
//                oriDate = [NSDate date];
//            } if (isBackgroundResetTimer) {
//                NSDate *currentTime = [NSDate date];
//                if (oriDate == nil) {
//                    oriDate = currentTime;
//                }
//                NSTimeInterval time = [currentTime timeIntervalSinceDate:oriDate];
//                long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
//                NSLog(@"crosse time is =========================%lld", dTime);
//                timeout -= (int)dTime;
//                oriDate = currentTime;
//                if (timeout <= 0) {
//                    oriDate = nil;
//                    UIViewController *controller = [[[IosLogic getInstance] getWindow] rootViewController];
//                    if ([controller isKindOfClass:[LeftViewController class]]) {
//                        LeftViewController *leftViewController = (LeftViewController *)controller;
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [leftViewController resetRightView];
//                        });
//                    }
//                }
//                //                else {
//                //                    oriDate = currentTime;
//                //                }
//
//                isBackgroundResetTimer = false;
//            } else {
//                timeout--;
//            }
//        }
//    });
//
//    dispatch_resume(_timer);
//}


//URLEncode
+ (NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
//
////URLDEcode
//+ (NSString *)decodeString:(NSString*)encodedString {
//    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
//
//    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                                     (__bridge CFStringRef)encodedString,
//                                                                                                                     CFSTR(""),
//                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    return decodedString;
//}
//

//

//

//
//+ (Boolean)isEarlerCurrentDate:(long long)valueDate {
//    long long currentDate = [[NSDate date] timeIntervalSince1970] * 1000;
//    if (currentDate > valueDate) {
//        return true;
//    }
//    return false;
//}
//
+ (NSString *)getPkcs7sin:(IPFather *)ip {
    if (!isCertificateNeedCheck) {
        return @"Sin";
    }
    int bufferSize = CABufferSize;
    NSString *strSource =[ip toString];
    //    NSString *strSource = @"a";
    //    unsigned char *source = (unsigned char *)[strSource UTF8String];    //簽章本文內容
    const char *source = [strSource UTF8String];
    int source_len = (int)strlen(source);                           //本文長度
    //    char signature[bufferSize];                                 //輸出簽章值內容
    char *signature = (char *)malloc(bufferSize);
    int detach = 0;                                                     //簽章值是否帶本文；0:帶本文
    
    int ret = 0;
    
    //PKCS7 sign.
    ret = PKCS7Sign((unsigned char *)source,     //the plaintext in binary format.
                    source_len, //the length of plaintext.
                    signature,  //the signature buffer for output.
                    bufferSize, //the signature buffer length.
                    detach);    //set 0 if source attached, set 1 if source detached.
    
    if (ret == 0) {
        NSString *returnString = [NSString stringWithCString:signature encoding:NSUTF8StringEncoding];
        free(signature);
        return returnString;
    }

    return nil;
}
//
+ (int)importCerticate:(NSString *)context {
    //    char retKeySet[8192];
    char *retKeySetData = (char *)malloc(8192);
    char *contextChar = (char *)[context UTF8String];
    int result = ImportCert([[CertificateSaveData getInstance] getKeySet],
                            [[CertificateSaveData getInstance] getUserPin],
                            contextChar,
                            retKeySetData,
                            8192);
    [[CertificateSaveData getInstance] setKeySetData:retKeySetData];
    [[CertificateSaveData getInstance] saveConfigData];
    free(retKeySetData);
    return result;
}

+ (void)resetIsLoadPrivate {
    isLoadPrivate = false;
}

@end
