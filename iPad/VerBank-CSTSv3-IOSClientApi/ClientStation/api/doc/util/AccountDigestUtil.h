//
//  AccountDigestUtil.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDS_AccountStore.h"

@interface AccountDigestUtil : NSObject


- (Boolean)         isAccountDigestMatch:(long long)accountID  Digest:(NSString *)digest;

- (Boolean)         isUserDigestMatch:(NSString *)user  Digest:(NSString *)digest;

- (Boolean)         isDigestMatch:(NSData *)digestData digest:(NSString *)digest;

//- (NSData *)         getGroupDigest:(NSString *)group;
- (NSString *)      getUserDigest:(NSString *)aeid;
- (NSString *)      getUserDigest:(NSString *)aeid  Radix:(int)radix  Unsign:(Boolean)unsign;
- (NSString *)      getUserInfo:(NSString *)aeid;


//- (NSData *)        getAccountDigestBuf:(long long)acid;
- (NSString *)      getAccountDigest:(long long)acid;
- (NSString *)      getAccountDigest:(long long)acid  Radix:(int)radix  Unsign:(Boolean)unsign;

- (NSString *)      getAccountInfo:(long long)acid;

- (NSString *)      getAccountInfo:(CDS_AccountStore *)account
                         tradeList:(NSMutableArray *)tradeList
                         orderList:(NSMutableArray *)orderList;


- (NSData *)        getDigesBuff:(NSString *)str;

- (NSString *)      parseBuff2String:(NSData *)buf radix:(int)radix unsign:(Boolean)unsign;
- (NSString *)      formatDouble:(double)data;

@end
