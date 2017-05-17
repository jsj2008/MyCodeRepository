//
//  CertificateContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "CertificateContentView.h"
#import "TradeApi.h"
#import "UserDefaultsSettingKey.h"
#import "ClientAPI.h"
#import "CertificateLoadView.h"
#import "IosLayoutDefine.h"
#import "CertificateUnloadView.h"
#import "CertificatePasswordInputView.h"
#import "AppConfig.h"
#import "CertificateUtil.h"
#import "ShowAlert.h"
#import "JEDIDateTime.h"
#import "MTP4CommDataInterface.h"
#import "DataCenter.h"
#import "LangCaptain.h"
#import "APIDoc.h"
#import "PWDCheckUtil.h"
#import "IosLogic.h"

@interface CertificateContentView() {
    CertificateUnloadView *unloadView;
    CertificateLoadView *loadView;
    CertificatePasswordInputView *certificatePasswordInputView;
    //    FnCertState *fnCertState;
}

@end

@implementation CertificateContentView

- (id)init {
    if (self = [super init]) {
        [self initPhoneOrderView];
        [self certificateTest];
    }
    return self;
}

- (void)initPhoneOrderView {
    if ([self checkIsLoaded]) {
        if ([CertificateUtil checkTradeCertState]) {
            [self initLoadView];
            return;
        } else {
            if ([[[DataCenter getInstance] fnCertResult] isEqualToString:@"Err_CATRADE_ServerNotConnection"]) {
                [self initUnconnectView];
                return;
            }
            if ([[[DataCenter getInstance] fnCertResult] isEqualToString:@"NetErr"]) {
                [self initUnconnectView];
                return;
            }
            [self initUnconnectView];
            return;
        }
    }
    
    [self initUnloadView];
}

- (void)initUnconnectView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view setBackgroundColor:[UIColor blackColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
    [label setText:[[LangCaptain getInstance] getLangByCode:[[LangCaptain getInstance] getLangByCode:[[DataCenter getInstance] fnCertResult]]]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    [self addSubview:view];
}

- (void)initUnloadView {
    unloadView = [CertificateUnloadView newInstance];
    [unloadView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [unloadView.nextButton addTarget:self action:@selector(unloadNextGap) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:unloadView];
}

- (void)initLoadView {
    loadView = [CertificateLoadView newInstance];
    [loadView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    FnCertState *certState = [[DataCenter getInstance] fnCertState];
    if (certState != nil) {
        NSString *stateLabel = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"CertificateStateCode"], [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"CA_%d", [certState getCaState]]]];
        //        NSDate *beginTime = [NSDate dateWithTimeIntervalSince1970:(long long)[certState getBeginValidTime] / 1000.0];
        //        NSString *beginDate = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"CertificateBeginDate"], [JEDIDateTime stringUIFromDate:beginTime]];
        
        //        NSDate *endTime = [NSDate dateWithTimeIntervalSince1970:(long long)[certState getEndValidTime] / 1000.0];
        //        NSString *endDate = [NSString stringWithFormat:@"%@:%@", [[LangCaptain getInstance] getLangByCode:@"CertificateEndDate"], [JEDIDateTime stringUIFromDate:endTime]];
        
        NSString *beginDate = [NSString stringWithFormat:@"%@：%@", [[LangCaptain getInstance] getLangByCode:@"CertificateBeginDate"],[JEDIDateTime getCertificateTimeString:[certState getBeginValidTime]]];
        NSString *endDate = [NSString stringWithFormat:@"%@：%@", [[LangCaptain getInstance] getLangByCode:@"CertificateEndDate"], [JEDIDateTime getCertificateTimeString:[certState getEndValidTime]]];
        
        [loadView.stateLabel setText:stateLabel];
        [loadView.startTimeLabel setText:beginDate];
        [loadView.endTimeLabel setText:endDate];
    }
    
    [self addSubview:loadView];
}

/**
 *  检查是否已经下载凭证
 *
 *  @return
 */
- (Boolean)checkIsLoaded {
    return [CertificateUtil isLoadedRsaKey];
}

//- (Boolean)checkCertState {
//    return [CertificateUtil checkCertState];
//}

- (Boolean)checkPhonePin {
    long long account = [[ClientAPI getInstance] getAccount];
    NSString *phonePin = unloadView.passwordField.text;
    int checkType = [[TradeApi getInstance] checkAccount:account
                                                phonePin:phonePin];
    if (checkType == CA_TRADE_SUCCEED) {
        [[DataCenter getInstance] resetPhonePinErr];
        return true;
    }
    return false;
}

#pragma action

- (void)unloadNextGap {
    
    NSString *phonePin = unloadView.passwordField.text;
    if (phonePin == nil || [phonePin isEqualToString:@""]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinIsNil"]];
        return;
    }
    // 检查下单密码是否正确
    if (![self checkPhonePin]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinErr"]];
        [[DataCenter getInstance] phonePinErr];
        
        return;
    }
    
    certificatePasswordInputView = [CertificatePasswordInputView newInstance];
    [certificatePasswordInputView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [certificatePasswordInputView.downloadButton addTarget:self
                                                    action:@selector(unloadCA)
                                          forControlEvents:UIControlEventTouchUpInside];
    dispatch_async(dispatch_get_main_queue(), ^{
        [unloadView.passwordField resignFirstResponder];
    });
    [self addSubview:certificatePasswordInputView];
}

- (void)unloadCA {
    
    NSString *userPingString = certificatePasswordInputView.passwordField.text;
    if (userPingString == nil || [userPingString isEqualToString:@""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateCanNotNull"]];
        });
        return;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [certificatePasswordInputView.passwordField resignFirstResponder];
    });
    //    Boolean PinIsRight = [PhonePinCheckUtil isPhonePinLegal:userPingString];
    Boolean PinIsRight = [PWDCheckUtil isPwdLegal:userPingString accountID:[@([[ClientAPI getInstance] accountID]) stringValue]];
    
    if (!PinIsRight) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]];
        });
        return;
    }
    
    if (![self checkCaDownloadTimer]) {
        return;
    }
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"CALoading"]
                                                   onView:[[[[IosLogic getInstance] getWindow] rootViewController] view]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 不成功， 不需要查询存在
        if ([self queryRight] == CA_TRADE_SUCCEED) {
            if ([self requestCA] == CA_TRADE_SUCCEED) {
                [self installComplete];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            
        });
    });
}

- (Boolean)checkCaDownloadTimer {
    UserLogin *userLogin = [[APIDoc getUserDocCaptain] getUserLogin:[[ClientAPI getInstance] aeid]];
    if (userLogin != nil && [userLogin getCaDownloadNumber] >= [userLogin getCaLimitNumber]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"CaDownloadTimeErr"]];
        });
        return false;
    }
    return true;
}

- (int)queryRight {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ShowAlert getInstance] hidenAlertWaitView];
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"RightQuery"]
                                                       onView:[[[[IosLogic getInstance] getWindow] rootViewController] view]];
    });
    
    TradeResult_CAFnStatus *result = [[TradeApi getInstance] getFnStatus2DeviceID:[[AppConfig getInstance] GUID]
                                                                         venderID:@"M"];
    int returnCode = -1;
    FnStatus *fnStatus = [result fnStatus];
    if (fnStatus != nil && fnStatus.getReturnCode == CA_TRADE_SUCCEED) {
        int message = [fnStatus getReturnMessage];
        NSString *returnMessage = [@(message) stringValue];
        int code1 = [[returnMessage substringWithRange:NSMakeRange(0,1)] intValue];
        
        switch (code1) {
            case CA_FNSTATUS_REQUEST_DONOT:
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"Requestdonot"]];
                });
                break;
            case CA_FNSTATUS_REQUEST_MAKECSR:
                returnCode = [self onRequestCert:true fnStatus:fnStatus];
                break;
            case CA_FNSTATUS_REQUEST_NOTCSR:
                returnCode = [self onRequestCert:false fnStatus:fnStatus];
                break;
            default:
                break;
        }
    } else {
        NSString *errMsg = [[LangCaptain getInstance] getLangByCode:@"CARightQueryFailed"];
        //        NSString *errMsg = [result errMessage];
        //        if (fnStatus == nil) {
        //            errMsg = @"fnState is null";
        //        } else {
        //            errMsg = [NSString stringWithFormat:@"return errCode is %d", [fnStatus getReturnCode]];
        //        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:errMsg];
        });
    }
    return returnCode;
}

- (int)onRequestCert:(Boolean)makeCSR fnStatus:(FnStatus *)fnStatus {
    
    NSString *userPingString = certificatePasswordInputView.passwordField.text;
    if (makeCSR) {
        int rstate = [CertificateUtil makeCSR:userPingString];
        if (rstate != CA_TRADE_SUCCEED) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"MakeCSRFailed"]];
            });
            return -1;
        }
    } else {
        NSString *csr = [fnStatus getPreviousCA];
        char *csrChar = (char *)[csr UTF8String];
        
        char *userPinChar = (char *)[userPingString UTF8String];
        
        NSString *cnString = [NSString stringWithFormat:@"CN=%@", [[ClientAPI getInstance]aeid]];
        char *cnChar = (char *)[cnString UTF8String];
        
        [[AppConfig getInstance] setUserPin:userPinChar];
//        [[AppConfig getInstance] setKeySet:(char *)[[CertificateUtil getKeySet] UTF8String]];
        [[AppConfig getInstance] setCsr:csrChar];
        [[AppConfig getInstance] setCN:cnChar];
        [[AppConfig getInstance] saveConfigData];
    }
    return CA_TRADE_SUCCEED;
}

- (int)requestCA {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ShowAlert getInstance] hidenAlertWaitView];
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"RequestCA"]
                                                       onView:[[[[IosLogic getInstance] getWindow] rootViewController] view]];
    });
    NSString *userPin = [NSString stringWithCString:[[AppConfig getInstance] getUserPin] encoding:NSUTF8StringEncoding];
    NSString *csr = [NSString stringWithCString:[[AppConfig getInstance] getCsr] encoding:NSUTF8StringEncoding];
    NSString *urlencodedString = [CertificateUtil encodeString:csr];
    TradeResult_CACert *result = [[TradeApi getInstance] requestApplyCertDeviceID:[[AppConfig getInstance] GUID]
                                                                         venderID:@"M"
                                                                         password:userPin
                                                                              csr:urlencodedString];
    
    int ret = -1;
    
    if (result != nil && [result succeed] && [result resultCode] == RESULT_SUCCEED) {
        // 成功
        ret = [CertificateUtil importCerticate:[result context]];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (ret == CA_TRADE_SUCCEED) {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateImportSuccess"]];
                [[AppConfig getInstance] setCertificateContext:[result context]];
                [[AppConfig getInstance] saveConfigData];
            } else {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"CertificateImportFailed"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"TWCA_ERROR_%d", ret]]];
            }
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"CertificateApplyFailed"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"MGW_RESULT_%d", [result resultCode]]]];
        });
    }
    
    return ret;
}

- (void)installComplete {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ShowAlert getInstance] hidenAlertWaitView];
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"InstallCA"]
                                                       onView:[[[[IosLogic getInstance] getWindow] rootViewController] view]];
    });
    TradeResult_CACert *result = [[TradeApi getInstance] certInstallCompleteDevice:[[AppConfig getInstance] GUID]
                                                                          venderID:@"M"];
    
    if (![result succeed]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"MGW_RESULT_%d", [result resultCode]]]];
        });
        
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initPhoneOrderView];
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[TradeApi getInstance] updateCADownloadTimer];
    });
}


- (void)certificateTest {
    //
    //    NSString *GUID = [[AppConfig getInstance] GUID];
    //
    //    TradeResult_CAFnStatus *result1 = [[TradeApi getInstance] getFnStatus2DeviceID:GUID
    //                                                                          venderID:@"FETP"];
    //
    //
    //    //
    //    TradeResult_CACert *result2 = [[TradeApi getInstance] requestApplyCertDeviceID:GUID
    //                                                                          venderID:@"FETP"
    //                                                                          password:@"password" // userPin
    //                                                                               csr:@"csr"]; // makeCsr
    //
    //
    //    //
    //    TradeResult_CACert *result3 = [[TradeApi getInstance] updateReNewCertDeviceID:GUID
    //                                                                         venderID:@"FETP"
    //                                                                         password:@"password"
    //                                                                              csr:@"csr"];
    //
    //
    //    //
    //    TradeResult_CACert * result4 = [[TradeApi getInstance] certInstallCompleteDevice:GUID
    //                                                                            venderID:@"FETP"];
    //
    //    //
    //    TradeResult_CACert *result5 = [[TradeApi getInstance] getCertDeviceID:GUID
    //                                                                 venderID:@"FETP"];
    //
    //
    //    //
    //    TradeResult_CACertState *result6 = [[TradeApi getInstance] getCertStateDeviceID:GUID
    //                                                                           venderID:@"FETP"];
    //
    //    //
    //    TradeResult_CAQueryCert *result7 = [[TradeApi getInstance] queryCertDeviceID:GUID
    //                                                                        venderID:@"FETP"
    //                                                                      certSerial:@"certSerial"];
    
    
}



@end
