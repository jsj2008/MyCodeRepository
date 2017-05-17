//
//  IP_TRADESERV5026.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5026.h"

static NSString * jsonId = @"IP_TRADESERV5026";

static NSString * aeid = @"1";
static NSString * conditionType = @"2";
static NSString * dealerName = @"3";
static NSString * compareWay = @"4";
static NSString * priceType = @"5";
static NSString * isPriceReach = @"6";
static NSString * fromTime = @"7";
static NSString * endTime = @"8";
static NSString * isRead = @"9";
static NSString * isClientNeed = @"10";
static NSString * origin = @"11";
static NSString * isReport = @"12";

@implementation IP_TRADESERV5026

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
        // 设置默认值
        [self setPriceType:-1];
        [self setCompareWay:-1];
        [self setIsPriceReach:-2];
        [self setIsRead:-1];
    }
    return self;
}

jsonImplementionString  (Aeid,            aeid)
jsonImplementionInt     (ConditionType,   conditionType)
jsonImplementionString  (DealerName,      dealerName)
jsonImplementionInt     (CompareWay,      compareWay)
jsonImplementionInt     (PriceType,       priceType)
jsonImplementionInt     (IsPriceReach,    isPriceReach)
jsonImplementionDate    (FromTime,        fromTime)
jsonImplementionDate    (EndTime,         endTime)
jsonImplementionInt     (IsRead,          isRead)
jsonImplementionBoolean (IsClientNeed,    isClientNeed)
jsonImplementionInt     (Origin,          origin)
jsonImplementionBoolean (IsReport,        isReport)

@end
