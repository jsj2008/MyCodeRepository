//
//  IP_TRADESERV5117.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5117.h"
static NSString * jsonId = @"IP_TRADESERV5117";

static NSString * account = @"1";
static NSString * level = @"2";
static NSString * tradeDay = @"3";
static NSString * subLevel = @"4";

@implementation IP_TRADESERV5117

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(Account, account)
jsonImplementionInt(Level, level)
jsonImplementionString(TradeDay, tradeDay)
jsonImplementionInt(SubLevel, subLevel)

@end
