//
//  CDS_DealerRollover.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CDS_DealerRollover.h"

@implementation CDS_DealerRollover

@synthesize ccy = _ccy;
@synthesize fromValueDay = _fromValueDay;
@synthesize toValueDay = _toValueDay;

@synthesize userRollover;
@synthesize dealerCost;
@synthesize dealerRolloverPL;

@synthesize rolloverTimes;
@synthesize dealerCostRate;

@synthesize dealerNetPosition;
@synthesize dealerCostInCCY;
@synthesize dealerCostExchangePrice;

@synthesize userRolloverInCcy;
@synthesize dealerLongPosition;
@synthesize dealerShortPosition;

- (id)initWithCcy:(NSString *)ccy  FromValueDay:(NSString *)fromValueDay  ToValueDay:(NSString *)toValueDay{
    if (self = [super init]) {
        _ccy = ccy;
        _fromValueDay = fromValueDay;
        _toValueDay = toValueDay;
    }
    return self;
}

- (NSString *)__getKey{
    return [CDS_DealerRollover formatKey:_ccy :_fromValueDay :_toValueDay];
}

+ (NSString *)formatKey:(NSString *)ccy :(NSString *)fromValueDay :(NSString *)toValueDay{
    return [NSString stringWithFormat:@"%@_%@_%@", ccy, fromValueDay, toValueDay];
}

@end
