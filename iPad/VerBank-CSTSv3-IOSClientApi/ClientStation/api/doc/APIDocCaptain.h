//
//  APIDocCaptain.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtherClientConfig.h"
#import "Instrument.h"

@interface APIDocCaptain : NSObject

+ (NSMutableArray *)getSettleList;
+ (void)addSettle:(NSArray *)settles;
+ (NSTimeZone *)getTimeZone;
+ (void)setTimeZone:(NSTimeZone *)timeZone;
+ (void)addOtnerClientConfig:(NSArray *)otherClientCfgs;
+ (OtherClientConfig *)getOtherClientConfig:(NSString *)key;
+ (Boolean)isMarketOpen:(NSString *)instrument;
+ (void)setClosedInstruments:(NSArray *)instruments;
+ (Instrument *)getInstrumentWithcur1:(NSString *)cur1
                                 cur2:(NSString *)cur2;
+ (NSArray *)getPriceSnapShots:(long long)accountID;

@end
