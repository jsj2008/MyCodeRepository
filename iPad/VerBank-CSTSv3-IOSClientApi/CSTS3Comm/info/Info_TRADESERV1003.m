//
//  Info_TRADESERV1003.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1003.h"

static NSString * jsonId        = @"Info_TRADESERV1003";

static NSString * accountID     = @"1";
static NSString * moneyAccount  = @"2";
static NSString * margin2Vec    = @"3";
static NSString * frozenVec     = @"4";

@implementation Info_TRADESERV1003

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID,     accountID)
jsonImplementionObject(MoneyAccount,    moneyAccount)
jsonImplementionObjectVec(Margin2Vec,   margin2Vec)
jsonImplementionObjectVec(FrozenVec,    frozenVec)


@end
