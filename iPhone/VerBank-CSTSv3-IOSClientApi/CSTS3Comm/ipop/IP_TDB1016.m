//
//  IP_TDB1016.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TDB1016.h"

static NSString * jsonId        = @"IP_TDB1016";



static NSString * conditionType = @"1";
static NSString * timeRagType = @"2";
static NSString * timeFrom = @"3";
static NSString * timeTo = @"4";
static NSString * fromDay = @"5";
static NSString * endDay = @"6";
static NSString * groupVec = @"7";
static NSString * account = @"8";
static NSString * ticket = @"9";
static NSString * splitno = @"10";

@implementation IP_TDB1016

jsonImplementionInt     (ConditionType,   conditionType)
jsonImplementionInt     (TimeRagType,     timeRagType)
jsonImplementionDate    (TimeFrom,        timeFrom)
jsonImplementionDate    (TimeTo,          timeTo)
jsonImplementionString  (FromDay,         fromDay)
jsonImplementionString  (EndDay,          endDay)
jsonImplementionObjectVec(GroupVec,       groupVec)
jsonImplementionLongLong(Account,         account)
jsonImplementionLongLong(Ticket,          ticket)
jsonImplementionInt     (Splitno,         splitno)

@end
