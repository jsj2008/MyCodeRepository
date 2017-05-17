//
//  BalanceRate.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "BalanceRate.h"

static NSString * jsonId = @"BalanceRate";

static NSString * instrument = @"1";
static NSString * tradeDay = @"2";
static NSString * Cur1 = @"3";
static NSString * Cur2 = @"4";
static NSString * Bid = @"5";
static NSString * Ask = @"6";

@implementation BalanceRate
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Instrument,  instrument)
jsonImplementionString(TradeDay,    tradeDay)
jsonImplementionString(Cur1,        Cur1)
jsonImplementionString(Cur2,        Cur2)
jsonImplementionDouble(Bid,         Bid)
jsonImplementionDouble(Ask,         Ask)

@end
