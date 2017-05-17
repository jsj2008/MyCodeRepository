//
//  MoneyAccount.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "MoneyAccount.h"
static NSString * jsonId = @"MoneyAccount";

static NSString * account = @"1";
static NSString * currencyName = @"2";
static NSString * cashBalance = @"3";
static NSString * fixedDeposit = @"4";
static NSString * tbs = @"5";
static NSString * margin2 = @"6";

@implementation MoneyAccount
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(Account,           account)
jsonImplementionString(CurrencyName,    currencyName)
jsonImplementionDouble(CashBalance,     cashBalance)
jsonImplementionDouble(FixedDeposit ,   fixedDeposit)
jsonImplementionDouble(Tbs ,            tbs)
jsonImplementionDouble(Margin2 ,        margin2)

@end
