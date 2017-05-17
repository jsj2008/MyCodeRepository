//
//  AccountStrategy.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AccountStrategy.h"

static NSString *jsonId     = @"AccountStrategy";

static NSString * account   = @"1";
static NSString * aeid      = @"2";
static NSString * isDead    = @"3";
static NSString * groupName = @"4";
static NSString * isUptrade = @"5";
static NSString * isTradeable   = @"6";
static NSString * acName        = @"7";

static NSString * maxTradeAmount    = @"8";

static NSString * basicCurrency     = @"9";
static NSString * openTime          = @"10";
static NSString * firstTradeTime    = @"11";
static NSString * lastTradeTime     = @"12";

static NSString * interestAddType   = @"13";
static NSString * liquidationType   = @"14";
static NSString * branch            = @"15";
static NSString * realName          = @"16";
static NSString * branchReceive     = @"17";
static NSString * oneTradeLimit     = @"18";

@implementation AccountStrategy
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(Account,           account)
jsonImplementionString(Aeid,            aeid)
jsonImplementionInt(IsDead,             isDead)
jsonImplementionString(GroupName,       groupName)
jsonImplementionInt(IsUptrade,          isUptrade)
jsonImplementionInt(IsTradeable,        isTradeable)
jsonImplementionString(AcName,          acName)
jsonImplementionDouble(MaxTradeAmount,  maxTradeAmount)
jsonImplementionString(BasicCurrency,   basicCurrency)
jsonImplementionDate(OpenTime,          openTime)
jsonImplementionDate(FirstTradeTime,    firstTradeTime)
jsonImplementionDate(LastTradeTime,     lastTradeTime)
jsonImplementionString(InterestAddType, interestAddType)
jsonImplementionInt(LiquidationType,    liquidationType)
jsonImplementionString(Branch,          branch)
jsonImplementionString(RealName,        realName)
jsonImplementionString(BranchReceive,   branchReceive)
jsonImplementionDouble(OneTradeLimit,   oneTradeLimit)
@end
