//
//  MarginCall.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "MarginCall.h"
// private long long account;
// private String tradeDay;
// private int MarginCalllevel;
// private Date callTime;
// private double marginPerc;
// private int isUserConfirm;
// private String dealerConfirmStream;
// private int subLevel;

static NSString * jsonId = @"MarginCall";

static NSString * account = @"1";
static NSString * tradeDay = @"2";
static NSString * MarginCalllevel = @"3";
static NSString * callTime = @"4";
static NSString * marginPerc = @"5";
static NSString * isUserConfirm = @"6";
static NSString * dealerConfirmStream = @"7";
static NSString * subLevel = @"8";
@implementation MarginCall
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionLongLong(Account,               account)
jsonImplementionString(TradeDay,            tradeDay)
jsonImplementionInt(MarginCalllevel,        MarginCalllevel)
jsonImplementionDate(CallTime,              callTime)
jsonImplementionDouble(MarginPerc,          marginPerc)
jsonImplementionInt(IsUserConfirm,          isUserConfirm)
jsonImplementionString(DealerConfirmStream, dealerConfirmStream)
jsonImplementionInt(SubLevel,               subLevel)
@end
