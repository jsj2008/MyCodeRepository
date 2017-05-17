//
//  BasicCurrency.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "BasicCurrency.h"
static NSString * jsonId = @"BasicCurrency";

static NSString * CurrencyName = @"1";
static NSString * ShortName = @"2";
static NSString * CanBeAccountCurrency = @"3";
static NSString * Digit = @"4";
@implementation BasicCurrency
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(CurrencyName,            CurrencyName)
jsonImplementionString(ShortName,               ShortName)
jsonImplementionInt(CanBeAccountCurrency,    CanBeAccountCurrency)
jsonImplementionInt(Digit,                   Digit)
@end
