//
//  Margin2.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "Margin2.h"
static NSString * jsonId = @"Margin2";

// private long long account;
// private String currencyName;
// private double amount;
// private double shrinkRate;
// private double exRate;
// private double amountUSD;

static NSString * account = @"1";
static NSString * currencyName = @"2";
static NSString * amount = @"3";
static NSString * shrinkRate = @"4";
static NSString * exRate = @"5";
static NSString * amountUSD = @"6";
@implementation Margin2
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
jsonImplementionDouble(Amount,          amount)
jsonImplementionDouble(ShrinkRate,      shrinkRate)
jsonImplementionDouble(ExRate,          exRate)
jsonImplementionDouble(AmountUSD,       amountUSD)
@end
