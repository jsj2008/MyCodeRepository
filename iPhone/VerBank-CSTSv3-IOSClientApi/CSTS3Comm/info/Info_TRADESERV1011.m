//
//  Info_TRADESERV1011.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1011.h"

static NSString * jsonId        = @"Info_TRADESERV1011";

static NSString * accountID         = @"1";
static NSString * moneyAccount      = @"2";
static NSString * tradeVec          = @"3";
static NSString * orderVec          = @"4";
static NSString * tsettledVec       = @"5";

@implementation Info_TRADESERV1011

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID,         accountID)
jsonImplementionObject(MoneyAccount,        moneyAccount)
jsonImplementionObjectVec(TradeVec,         tradeVec)
jsonImplementionObjectVec(OrderVec,         orderVec)
jsonImplementionObjectVec(TsettledVec,      tsettledVec)

@end
