//
//  InterestRate.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "InterestRate.h"
static NSString * jsonId = @"InterestRate";

static NSString * CurrencyName = @"1";
static NSString * bankCostBid = @"2";
static NSString * bankCostOffer = @"3";
static NSString * CustomerCostBid = @"4";
static NSString * CustomerCostOffer = @"5";
static NSString * tradeDay = @"6";
@implementation InterestRate
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(CurrencyName,        CurrencyName)
jsonImplementionDouble(BankCostBid,         bankCostBid)
jsonImplementionDouble(BankCostOffer,       bankCostOffer)
jsonImplementionDouble(CustomerCostBid,     CustomerCostBid)
jsonImplementionDouble(CustomerCostOffer,   CustomerCostOffer)
jsonImplementionString(TradeDay ,           tradeDay)
@end
