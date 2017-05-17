//
//  IP_TRADESERV5108.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5108.h"
static NSString * jsonId = @"IP_TRADESERV5108";

static NSString * account = @"1";
static NSString * orderID = @"2";
static NSString * stopMove = @"3";

@implementation IP_TRADESERV5108

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(OrderID, orderID)
jsonImplementionLongLong(AccountID, account)
jsonImplementionInt(StopMove, stopMove)

@end
