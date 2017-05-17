//
//  Info_TRADESERV1012.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1012.h"

static NSString * jsonId        = @"Info_TRADESERV1012";

static NSString * accountID         = @"1";
static NSString * tradeOperateID    = @"2";
static NSString * toRemoveOrderID   = @"3";
static NSString * order             = @"4";

@implementation Info_TRADESERV1012

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID,         accountID)
jsonImplementionString(TradeOperateID,      tradeOperateID)
jsonImplementionLongLong(ToRemoveOrderID,   toRemoveOrderID)
jsonImplementionObject(Order,               order)

@end
