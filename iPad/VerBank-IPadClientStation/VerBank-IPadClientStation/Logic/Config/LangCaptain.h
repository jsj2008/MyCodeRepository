//
//  LangCaptain.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
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

- (NSString *)getOrderTradeErrMsgByErrCode:(NSString *)errorCode;
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
