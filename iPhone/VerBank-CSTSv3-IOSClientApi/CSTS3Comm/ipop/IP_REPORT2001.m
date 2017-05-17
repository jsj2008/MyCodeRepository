//
//  IP_REPORT2001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_REPORT2001.h"

/**
 ** 平仓单报表
**/

static NSString * jsonId        = @"IP_REPORT2001";

static NSString * type          = @"1";
static NSString * account       = @"2";
static NSString * groupName     = @"3";
static NSString * groupVec      = @"4";
static NSString * fromTime      = @"5";
static NSString * endTime       = @"6";

@implementation IP_REPORT2001

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt         (Type,        type)
jsonImplementionLongLong    (Account,     account)
jsonImplementionString      (GroupName,   groupName)
jsonImplementionObjectVec   (GroupVec,    groupVec)
jsonImplementionDate        (FromTime,    fromTime)
jsonImplementionDate        (EndTime,     endTime)

@end
