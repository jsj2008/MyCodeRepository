//
//  OP_TRADESERV5041.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5041.h"

static NSString *jsonId                         = @"OP_TRADESERV5041";

static NSString *moneyAccount                   = @"1";
static NSString *tradeArray                     = @"2";
static NSString *orderArray                     = @"3";
static NSString *margin2Array                   = @"4";
static NSString *moneyAccountFrozenArray        = @"5";

@implementation OP_TRADESERV5041

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(MoneyAccount, moneyAccount)
jsonImplementionObjectVec(TradeArray, tradeArray)
jsonImplementionObjectVec(OrderArray, orderArray)
jsonImplementionObjectVec(Margin2Array, margin2Array)
jsonImplementionObjectVec(MoneyAccountFrozenArray, moneyAccountFrozenArray)

@end
