//
//  Instrument.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "Instrument.h"

static NSString * jsonId = @"Instrument";

static NSString * instrument = @"1";
static NSString * Ccy1 = @"2";
static NSString * Ccy2 = @"3";
static NSString * digits = @"4";
static NSString * MinAmount = @"5";
static NSString * MaxAmount = @"6";
static NSString * spreadType = @"7";
static NSString * Spread = @"8";
static NSString * spike = @"9";
static NSString * safeGap4OpenOrder = @"10";
static NSString * moveStopMinGap = @"11";
static NSString * openMarginPercentage = @"12";
static NSString * marginCall1Percentage = @"13";
static NSString * marginCall2Percentage = @"14";
static NSString * UnLockMarginPercentage = @"15";
static NSString * liquidationMarginPercentage = @"16";
static NSString * tradeable = @"17";
static NSString * priceValidTimeGap = @"18";
static NSString * isVisable = @"19";
static NSString * foreceToUptrade = @"20";
static NSString * ExtraDigit = @"21";
static NSString * valueDayDelay = @"22";
static NSString * IsForward = @"23";
static NSString * ForwardDate = @"24";
static NSString * DealerOpenMarginPercentage = @"25";
static NSString * OrderTradeFeeRatio = @"26";
static NSString * OrderTradeFeeAdjust = @"27";

@implementation Instrument
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(Instrument,                  instrument)
jsonImplementionString(Ccy1,                        Ccy1)
jsonImplementionString(Ccy2,                        Ccy2)
jsonImplementionInt(Digits,                         digits)
jsonImplementionDouble(MinAmount,                   MinAmount)
jsonImplementionDouble(MaxAmount,                   MaxAmount)
jsonImplementionInt(SpreadType,                     spreadType)
jsonImplementionDouble(Spread,                      Spread)
jsonImplementionInt(Spike,                          spike)
jsonImplementionInt(SafeGap4OpenOrder,              safeGap4OpenOrder)
jsonImplementionInt(MoveStopMinGap,                 moveStopMinGap)
jsonImplementionDouble(OpenMarginPercentage,        openMarginPercentage)
jsonImplementionDouble(MarginCall1Percentage,       marginCall1Percentage)
jsonImplementionDouble(MarginCall2Percentage,       marginCall2Percentage)
jsonImplementionDouble(UnLockMarginPercentage,      UnLockMarginPercentage)
jsonImplementionDouble(LiquidationMarginPercentage, liquidationMarginPercentage)
jsonImplementionInt(Tradeable,                      tradeable)
jsonImplementionInt(PriceValidTimeGap,              priceValidTimeGap)
jsonImplementionInt(IsVisable,                      isVisable)
jsonImplementionInt(ForeceToUptrade,                foreceToUptrade)
jsonImplementionInt(ExtraDigit,                     ExtraDigit)
jsonImplementionInt(ValueDayDelay,                  valueDayDelay)
jsonImplementionInt(IsForward,                      IsForward)
jsonImplementionString(ForwardDate,                 ForwardDate)
jsonImplementionDouble(DealerOpenMarginPercentage,  DealerOpenMarginPercentage)
jsonImplementionInt(OrderTradeFeeRatio,             OrderTradeFeeRatio)
jsonImplementionInt(OrderTradeFeeAdjust,            OrderTradeFeeAdjust)
@end
