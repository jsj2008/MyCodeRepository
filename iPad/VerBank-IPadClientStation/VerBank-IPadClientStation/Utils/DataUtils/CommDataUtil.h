//
//  CommDataUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instrument.h"

@interface CommDataUtil : NSObject
//+ (double)  getMaxLots:(NSString *) instrument accountID:(long long)accountID;
//+ (double)  getMinLots:(NSString *) instrument;
//+ (double)  getOpenMarginPercentage:(NSString *) instrument;
//+ (BOOL)    isVisableForInstrument:(Instrument *) instrument;
//+ (NSString *) showNameForInstrument:(NSString *) instrument;
//+ (BOOL )   isTradeable:(Instrument *)instrument;
//+ (BOOL)    isMKTTradeable:(Instrument *)instrument;
//+ (Boolean) isNumberString:(NSString *) str;
+ (double)  numberFromString:(NSString *) str;

#pragma lotsUtil
//+ (double)getMinLots:(NSString *)instrument accountID:(long long)accountID;

#pragma LimitStopPrice 
+ (double) getLimitPrice:(NSString *)instrument bunysell:(Boolean)buySell;
+ (double) getStopPrice:(NSString *)instrument bunysell:(Boolean)buySell;


+ (double) getDefaultCcy1Amount:(NSString *)instrument;

+ (NSString *)convertHiddenCode:(NSString *)text;
+ (NSString *)getHiddenString:(NSString *)text;

+ (NSString *)createGUID;
+ (NSString *)getDeviceID;

#pragma IsUptradeOrder
+ (Boolean)isUptradeOrder:(long long)orderID;
+ (Boolean)isPriceReached:(long long)orderID;

+ (Boolean)isFloatZero:(float)value;

@end
