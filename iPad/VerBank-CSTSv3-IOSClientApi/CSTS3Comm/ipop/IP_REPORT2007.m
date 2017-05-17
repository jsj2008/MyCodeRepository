//
//  IP_REPORT2007.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_REPORT2007.h"

static NSString * jsonId        = @"IP_REPORT2007";

static NSString * type          = @"1";
static NSString * account       = @"2";
static NSString * groupName     = @"3";
static NSString * fromTime      = @"4";
static NSString * endTime       = @"5";
static NSString * orderID       = @"6";

@implementation IP_REPORT2007

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt         (Type,        type)
jsonImplementionLongLong    (Account,     account)
jsonImplementionString      (GroupName,   groupName)
jsonImplementionDate        (FromTime,    fromTime)
jsonImplementionDate        (EndTime,     endTime)
jsonImplementionLongLong    (OrderID,     orderID)

@end
