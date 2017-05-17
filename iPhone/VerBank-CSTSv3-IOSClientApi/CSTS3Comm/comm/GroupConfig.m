//
//  GroupConfig.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "GroupConfig.h"

static NSString * jsonId = @"GroupConfig";

static NSString * groupName = @"1";
static NSString * isTradeable = @"2";
static NSString * description = @"3";
static NSString * interestAddType = @"4";
static NSString * ForceToUptrade = @"5";
static NSString * orderTradeFee = @"6";

@implementation GroupConfig
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(GroupName,       groupName)
jsonImplementionInt(IsTradeable,        isTradeable)
jsonImplementionString(Description,     description)
jsonImplementionString(InterestAddType, interestAddType)
jsonImplementionInt(ForceToUptrade,     ForceToUptrade)
jsonImplementionInt(OrderTradeFee,      orderTradeFee)
@end
