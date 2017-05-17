//
//  LangCaptain.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LangConfig_TW @"TW"//繁体
#define LangConfig_CN @"CN"//简体

@interface LangCaptain : NSObject

#pragma init
+ (LangCaptain *)getInstance;
- (id)init;
- (void)parse;

#pragma langConfig
- (void)            setLangConfig:(NSString *)config;
- (NSString *)      getLangConfig;

#pragma getLang
- (NSString *)getErrMessageByCode:(NSString *)code;
- (NSString *)getLangByCode:(NSString *)code;
- (NSString *)getResultByCode:(NSString *)code;
- (NSString *)getPaswordResultByCode:(NSString *)code;

//- (NSString *)getOrderTradeErrMsgByErrCode:(NSString *)errorCode;
- (NSString *)getTradeErrMsgByErrorCode:(NSString *)errorCode;

#pragma setLang
- (void)setLangTW;
- (void)setLangCN;

- (Boolean)isLangTW;

#pragma getMarginCallConfig
- (NSArray *)getMarginCallConfig;

- (NSString *)getMarginLangByCode:(NSString *)code;

#pragma closeReason expireType
- (NSString *)getOrderHisCloseReason:(int)reason;
- (NSString *)getExpireType:(int)expire;

@end
