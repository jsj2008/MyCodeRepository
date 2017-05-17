//
//  InstrumentsAccountCfg.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "InstrumentsAccountCfg.h"
static NSString * jsonId = @"InstrumentsAccountCfg";

static NSString * instrument = @"1";
static NSString * account = @"2";
static NSString * minAmount = @"3";
static NSString * maxAmount = @"4";
static NSString * Spread2Add = @"5";
static NSString * openMarginPercentage = @"6";
static NSString * marginCall1Percentage = @"7";
static NSString * marginCall2Percentage = @"8";
static NSString * unLockMarginPercentage = @"9";
static NSString * liquidationMarginPercentage = @"10";
static NSString * Tradeable = @"11";
static NSString * isVisable = @"12";

@implementation InstrumentsAccountCfg

- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Instrument,                  instrument)
jsonImplementionLongLong(Account,                       account)
jsonImplementionDouble(MinAmount,                   minAmount)
jsonImplementionDouble(MaxAmount,                   maxAmount)
jsonImplementionDouble(Spread2Add,                  Spread2Add)
jsonImplementionDouble(OpenMarginPercentage,        openMarginPercentage)
jsonImplementionDouble(MarginCall1Percentage,       marginCall1Percentage)
jsonImplementionDouble(MarginCall2Percentage,       marginCall2Percentage)
jsonImplementionDouble(UnLockMarginPercentage,      unLockMarginPercentage)
jsonImplementionDouble(LiquidationMarginPercentage, liquidationMarginPercentage)
jsonImplementionInt(Tradeable,                      Tradeable)
jsonImplementionInt(IsVisable,                      isVisable)
@end
