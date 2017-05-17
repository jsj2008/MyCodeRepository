//
//  ClosePositionDetails.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//


#import "ClosePositionDetails.h"
#import "MTP4CommDataInterface.h"

static NSString * jsonId = @"ClosedPositionsDetails";

static NSString * aeid = @"1";
static NSString * openRuleType = @"2";
static NSString * openIpAddress = @"3";
static NSString * closeRuleType = @"4";
static NSString * closeName = @"5";
static NSString * closeIpAddress = @"6";

@implementation ClosePositionDetails

@synthesize sortTag;
@synthesize isSelected;

- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)
jsonImplementionInt(OpenRuleType, openRuleType)
jsonImplementionString(OpenIpAddress, openIpAddress)
jsonImplementionInt(CloseRuleType, closeRuleType)
jsonImplementionString(CloseName, closeName)
jsonImplementionString(CloseIpAddress, closeIpAddress)

- (double)getProfit {
    double buyPrice = ([self getClosePrice] - [self getOpenPrice])
				* [self getAmount];
    double sellPrice = ([self getOpenPrice] - [self getClosePrice])
				* [self getAmount];
    return [self getBuysell] == BUY ? buyPrice : sellPrice;
}

@end
