//
//  CDS_DealerRollover.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"

@interface CDS_DealerRollover : CommDocBasicStruct

@property NSString* ccy;
@property NSString* fromValueDay;
@property NSString* toValueDay;

@property double userRollover;
@property double dealerCost;
@property double dealerRolloverPL;

@property int rolloverTimes;
@property double dealerCostRate;

@property double dealerNetPosition;
@property double dealerCostInCCY;
@property double dealerCostExchangePrice;

@property double userRolloverInCcy;
@property double dealerLongPosition;
@property double dealerShortPosition;

- (id)initWithCcy:(NSString *)ccy  FromValueDay:(NSString *)fromValueDay  ToValueDay:(NSString *)toValueDay;

- (NSString *)__getKey;
+ (NSString *)formatKey:(NSString *)ccy :(NSString *)fromValueDay :(NSString *)toValueDay;

@end
