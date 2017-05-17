//
//  IP_TRADESERV5101.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5101.h"
#import "ToCloseTradeNode.h"
#import "ToOpenTradeNode.h"
static NSString * jsonId        = @"IP_TRADESERV5101";

static NSString * aeid = @"1";
static NSString * accountID = @"2";
static NSString * instrumentName = @"3";
static NSString * buySell = @"4";
static NSString * amount = @"5";
static NSString * price = @"6";
static NSString * mktPriceGap = @"7";
static NSString * isToOpenNew = @"8";
static NSString * orderType = @"9";
static NSString * accountDigist = @"10";
static NSString * closeTradeVec = @"11";
static NSString * openTrade = @"12";
static NSString * orderID = @"13";

@implementation IP_TRADESERV5101

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)
jsonImplementionLongLong(AccountID, accountID)
jsonImplementionString(InstrumentName, instrumentName)
jsonImplementionInt(BuySell, buySell)
jsonImplementionDouble(Amount, amount)
jsonImplementionDouble(Price, price)
jsonImplementionInt(MktPriceGap, mktPriceGap)
jsonImplementionBoolean(IsToOpenNew, isToOpenNew)
jsonImplementionInt(OrderType, orderType)
jsonImplementionString(AccountDigist, accountDigist)
jsonImplementionObjectVec(CloseTradeVec, closeTradeVec)
jsonImplementionObject(OpenTrade, openTrade)
jsonImplementionLongLong(OrderID, orderID)

- (NSString *)toString {
    NSMutableString *string  = [[NSMutableString alloc] init];
    [string appendString:[NSString stringWithFormat:@"aeid=%@|", [self getAeid]]];
    [string appendString:[NSString stringWithFormat:@"accountID=%lld|", [self getAccountID]]];
    [string appendString:[NSString stringWithFormat:@"instrumentName=%@|", [self getInstrumentName]]];
    [string appendString:[NSString stringWithFormat:@"buySell=%d|", [self getBuySell]]];
    [string appendString:[NSString stringWithFormat:@"amount=%f|", [self getAmount]]];
    [string appendString:[NSString stringWithFormat:@"price=%f|", [self getPrice]]];
    [string appendString:[NSString stringWithFormat:@"mktPriceGap=%d|", [self getMktPriceGap]]];
    [string appendString:[NSString stringWithFormat:@"isToOpenNew=%hhu|", [self getIsToOpenNew]]];
    [string appendString:[NSString stringWithFormat:@"orderType=%d|", [self getOrderType]]];
    [string appendString:[NSString stringWithFormat:@"accountDigist=%@|", [self getAccountDigist]]];
    
    [string appendString:@" @ closeTradeVec: "];
    
    for (ToCloseTradeNode* tctn in [self getCloseTradeVec]) {
        [string appendString:[tctn toString]];
        [string appendString:@" : "];
    }
    
    [string appendString:@" @ openTrade: "];
    ToOpenTradeNode *node = (ToOpenTradeNode *)[self getOpenTrade];
    if (node != nil) {
        [string appendString:[node toString]];
    }
    
    return string;
}

@end
