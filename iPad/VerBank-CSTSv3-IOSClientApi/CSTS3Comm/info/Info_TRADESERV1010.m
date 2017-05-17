//
//  Info_TRADESERV1010.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1010.h"

static NSString * jsonId        = @"Info_TRADESERV1010";

static NSString * accountID             = @"1";
static NSString * tradeOperatorID       = @"2";
static NSString * moneyAccount          = @"3";
static NSString * tradeVec              = @"4";
static NSString * orderVec              = @"5";
static NSString * orderHis              = @"6";
static NSString * description           = @"7";
static NSString * lastTradeTime         = @"8";
static NSString * tsettledVec           = @"9";

@implementation Info_TRADESERV1010

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID,         accountID)
jsonImplementionString(TradeOperatorID,     tradeOperatorID)
jsonImplementionObject(MoneyAccount,        moneyAccount)
jsonImplementionObjectVec(TradeVec,         tradeVec)
jsonImplementionObjectVec(OrderVec,         orderVec)
jsonImplementionObject(OrderHis,            orderHis)
jsonImplementionString(Description,         description)
jsonImplementionLongLong(LastTradeTime,     lastTradeTime)
jsonImplementionObjectVec(TsettledVec,      tsettledVec)

@end
