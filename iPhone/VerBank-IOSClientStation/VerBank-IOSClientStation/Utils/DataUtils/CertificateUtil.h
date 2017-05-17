//
//  CertificateUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/12.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPFather.h"
#import "TradeResult_CAQueryCert.h"

static Boolean isNeedResetTimer = false;
static Boolean isBackgroundResetTimer = false;
static Boolean isTouchTime = true;



@interface CertificateUtil : NSObject

+ (Boolean)isLoadedRsaKey;
+ (int)makeCSR:(NSString *)userPin;
//+ (Boolean)checkIsneedputPhonePin;
//+ (void)resetTimeTick;
//+ (void)resetTouched;

+ (NSString*)encodeString:(NSString*)unencodedString;

//URLDEcode
+ (NSString *)decodeString:(NSString*)encodedString;

//+ (void)resetLastRegisteTime;
//+ (Boolean)needInputPhonePin;
+ (void)setOriDate:(NSDate *)date;

+ (Boolean)checkIsneedputPhonePin;
+ (Boolean)checkPhonePinByValidate;
+ (void)resetTimeTickIsEnterBackground:(Boolean)isBackground;
+ (void)setDestroyTimeTick;

+ (Boolean)checkCertState;
+ (Boolean)checkTradeCertState;

+ (NSString *)getPkcs7sin:(IPFather *)ip;

+ (int)importCerticate:(NSString *)context;

+ (NSString *)getKeySet;
+ (void)resetIsLoadPrivate;

@end
