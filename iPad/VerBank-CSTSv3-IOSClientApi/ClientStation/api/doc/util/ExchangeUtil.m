//
//  ExchangeUtil.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "ExchangeUtil.h"
#import "CommDocCaptain.h"
#import "CDS_AccountStore.h"
#import "KeyNotFundException.h"

static const NSString *CONNECTION = @"[and]";

@implementation ExchangeUtil

+ (NSString *)getExchangeUtilName:(NSString *)insCurr :(NSString *)balCurr{
    if ([insCurr compare:balCurr] == NSOrderedAscending) {
        return [[NSString stringWithFormat:@"%@%@%@", insCurr, CONNECTION, balCurr] copy];
    } else {
        return [[NSString stringWithFormat:@"%@%@%@", balCurr, CONNECTION, insCurr] copy];
    }
}

- (double)exchangeToSysBasicCcy:(NSString *)ccy :(double)amount{
    NSString *ccy2 = [[[CommDocCaptain getInstance] getSystemDocCaptain] getSystemBasicCurrency];
    return [self exchange:ccy  Amount:amount  Ccy2:ccy2];
}

- (ExchangeUtil_node *)createExchangeNodeToAccountBasicCcy:(long long)account  Ccy1:(NSString *)ccy1  Amount:(double)amount{
    CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:account];
    
    if (as == nil) {
        @throw [[KeyNotFundException alloc] initWithKeyName:@"account"
                                                   Object:[NSString stringWithFormat:@"%lld", account]];
    }
    return [self createExchangeNode:ccy1
                           Amount:amount
                             Ccy2:[as getBasicCurrency]];
}

- (double)exchangeToAccountBasicCcy:(long long)account  Ccy1:(NSString *)ccy1  Amount:(double)amount{
    CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:account];
    if (as == nil) {
        @throw [[KeyNotFundException alloc] initWithKeyName:@"account"
                                                   Object:[NSString stringWithFormat:@"%lld", account]];
    }
    return [self exchange:ccy1  Amount:amount  Ccy2:[as getBasicCurrency]];
}

- (double)exchange:(NSString *)ccy1  Amount:(double)amount  Ccy2:(NSString *)ccy2{
    ExchangeUtil_node *node = [self createExchangeNode:ccy1  Amount:amount  Ccy2:ccy2];
    return [node getExchangeMoney];
}

- (ExchangeUtil_node *)createExchangeNode:(NSString *)ccy1  Amount:(double)amount  Ccy2:(NSString *)ccy2{
    return [self createExchangeNode:ccy1  Amount:amount  Ccy2:ccy2  UseMidPrice:false];
}

- (ExchangeUtil_node *)createExchangeNode:(NSString *)ccy1
                                   Amount:(double)amount
                                     Ccy2:(NSString *)ccy2
                              UseMidPrice:(Boolean)userMidPrice{
    if ([[ccy1 uppercaseString] isEqualToString:[ccy2 uppercaseString]]) {
        return [[ExchangeUtil_node alloc] initWithCcy1:ccy1  Ccy2:ccy2  Amount:amount  Instrument:nil  Bid:1  Ask:1  UseMidPrice:userMidPrice];
    } else {
        NSString *exchanegName = [ExchangeUtil getExchangeUtilName:ccy1 :ccy2];
        NSString *instrumentName = [[[CommDocCaptain getInstance]getSystemDocCaptain] getInstrumentName4Exchange:exchanegName];
        if (instrumentName == nil) {
            @throw [[KeyNotFundException alloc] initWithKeyName:@"Instrument 4 exchange"  Object:exchanegName];
        }
        
        Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrumentName];
        if (inst == nil) {
            @throw [[KeyNotFundException alloc] initWithKeyName:@"Instrument"  Object:exchanegName];
        }
        exchanegName = nil;
        QuoteData *quoteData = [[[CommDocCaptain getInstance] getSystemDocCaptain] getQuote:instrumentName];
        if (quoteData == nil) {
            @throw [[KeyNotFundException alloc] initWithKeyName:@"quote"  Object:instrumentName];
        }
        ExchangeUtil_node *node = [[ExchangeUtil_node alloc] initWithCcy1:ccy1  Ccy2:ccy2  Amount:amount  Instrument:inst  Bid:[quoteData getBid]  Ask:[quoteData getAsk] UseMidPrice:userMidPrice];
        return node;
    }
}

- (ExchangeUtil_node *)createExchangeNode:(NSString *)ccy1
                                   Amount:(double)amount
                                     Ccy2:(NSString *)ccy2
                           PairInstrument:(NSString *)pairInstrument
                           SuggestedPrice:(double)suggestedPrice{
    if ([[ccy1 uppercaseString] isEqualToString:[ccy2 uppercaseString]]) {
        return [[ExchangeUtil_node alloc] initWithCcy1:ccy1  Ccy2:ccy2  Amount:amount  Instrument:nil  Bid:1  Ask:1];
    } else {
        NSString *exchanegName = [ExchangeUtil getExchangeUtilName:ccy1 :ccy2];
        NSString *instrumentName = [[[CommDocCaptain getInstance]getSystemDocCaptain] getInstrumentName4Exchange:exchanegName];
        if (instrumentName == nil) {
            @throw [[KeyNotFundException alloc] initWithKeyName:@"Instrument 4 exchange"  Object:exchanegName];
        }
        
        Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrumentName];
        if (inst == nil) {
            @throw [[KeyNotFundException alloc] initWithKeyName:@"Instrument"  Object:exchanegName];
        }
        exchanegName = nil;
        ExchangeUtil_node *node = nil;
        if (![instrumentName isEqualToString:pairInstrument]) {
            QuoteData *quote = [[[CommDocCaptain getInstance] getSystemDocCaptain] getQuote:instrumentName];
            if (quote == nil) {
                @throw [[KeyNotFundException alloc] initWithKeyName:@"quote"  Object:instrumentName];
            }
            node = [[ExchangeUtil_node alloc] initWithCcy1:ccy1  Ccy2:ccy2  Amount:amount  Instrument:inst  Bid:[quote getBid]  Ask:[quote getAsk]];
        } else {
            node = [[ExchangeUtil_node alloc] initWithCcy1:ccy1 Ccy2:ccy2 Amount:amount Instrument:inst Bid:suggestedPrice Ask:suggestedPrice];
        }
        return node;
    }
}

@end
