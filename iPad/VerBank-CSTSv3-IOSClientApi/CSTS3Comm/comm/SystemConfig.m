//
//  SystemConfig.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "SystemConfig.h"
static NSString * jsonId = @"SystemConfig";

// private int closeStatus;
// private int closeTimeInMil;
// private int openTimeInMil;
// private int AutoClose;
// private String BatchCurrency;
// private String TradeDay;
// private int isTradeable;
// private double HedgedMarginScale;
// private int MarginType;
// private int nycCloseTimeInMil;
// private double webTradeMinAmount;
// private double webTradeMaxAmount;
// private double phoneOrderMinAmount;
// private double phoneOrderMaxAmount;
// private double dealerMarginPerc;

static NSString * CloseStatus = @"1";
static NSString * CloseTimeInMil = @"2";
static NSString * OpenTimeInMil = @"3";
static NSString * AutoClose = @"4";
static NSString * BatchCurrency = @"5";
static NSString * TradeDay = @"6";
static NSString * isTradeable = @"7";
static NSString * HedgedMarginScale = @"8";
static NSString * MarginType = @"9";
static NSString * NycCloseTimeInMil = @"10";
static NSString * WebTradeMinAmount = @"11";
static NSString * WebTradeMaxAmount = @"12";
static NSString * PhoneOrderMinAmount = @"13";
static NSString * PhoneOrderMaxAmount = @"14";
static NSString * DealerMarginPerc = @"15";
@implementation SystemConfig
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionInt(CloseStatus,            CloseStatus)
jsonImplementionInt(CloseTimeInMil,         CloseTimeInMil)
jsonImplementionInt(OpenTimeInMil,          OpenTimeInMil)
jsonImplementionInt(AutoClose,              AutoClose)
jsonImplementionString(BatchCurrency,       BatchCurrency)
jsonImplementionString(TradeDay,            TradeDay)
jsonImplementionInt(IsTradeable,            isTradeable)
jsonImplementionDouble(HedgedMarginScale,   HedgedMarginScale)
jsonImplementionInt(MarginType,             MarginType)
jsonImplementionInt(NycCloseTimeInMil,      NycCloseTimeInMil)
jsonImplementionDouble(WebTradeMinAmount,   WebTradeMinAmount)
jsonImplementionDouble(WebTradeMaxAmount,   WebTradeMaxAmount)
jsonImplementionDouble(PhoneOrderMinAmount ,PhoneOrderMinAmount)
jsonImplementionDouble(PhoneOrderMaxAmount ,PhoneOrderMaxAmount)
jsonImplementionDouble(DealerMarginPerc ,   DealerMarginPerc)
@end
