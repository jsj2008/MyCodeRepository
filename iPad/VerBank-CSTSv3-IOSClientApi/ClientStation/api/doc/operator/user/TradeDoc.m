//
//  TradeDoc.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "TradeDoc.h"

@interface TradeDoc(){
    NSMutableDictionary* tradeListMapAccount;
    NSMutableDictionary* tradeListMapByInstrument;
    NSMutableDictionary* tradeMap;
}

@end

@implementation TradeDoc

- (id)init{
    if (self = [super init]) {
        tradeListMapByInstrument = [[NSMutableDictionary alloc] init];
        tradeListMapAccount = [[NSMutableDictionary alloc] init];
        tradeMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSMutableArray *)getTTradeByAccountList:(long long)account{
    NSMutableArray *array = [tradeListMapAccount objectForKey:[@(account)stringValue]];
    if (array != nil) {
        return  array;
    }
    return [[NSMutableArray alloc] init];
}

- (NSMutableArray *)getTTradeByInstrumentList:(NSString *)instrumen{
    NSMutableArray *array = [tradeListMapByInstrument objectForKey:instrumen];
    if (array != nil) {
        return array;
    }
    return  [[NSMutableArray alloc] init];
}

- (TTrade *)getTTrade:(long long)ticket{
    return [tradeMap objectForKey:[@(ticket)stringValue]];
}

- (NSArray *)getTTrades{
    return [tradeMap allValues];
}

- (void)removeTrade:(long long)ticket{
    NSString *key = [NSString stringWithFormat:@"%lld", ticket];
    TTrade *trade = (TTrade *)[tradeMap objectForKey:key];
    [tradeMap removeObjectForKey:key];
    
    if (trade != nil) {
        NSMutableArray * instrumentArray = [tradeListMapByInstrument objectForKey:[trade getInstrument]];
        for (TTrade *temptrade in instrumentArray) {
            if ([temptrade getTicket] == [trade getTicket]) {
                [instrumentArray removeObject:temptrade];
                break;
            }
        }
    }
    
    if (trade != nil) {
        NSMutableArray * accountArray = [tradeListMapAccount objectForKey:[@([trade getAccount])stringValue]];
        for (TTrade *temptrade in accountArray) {
            if ([temptrade getTicket] == [trade getTicket]) {
                [accountArray removeObject:temptrade];
                break;
            }
        }
    }
}

- (void)addTrade:(TTrade *)trade{
    long long ticket = [trade getTicket];
    NSString *key = [NSString stringWithFormat:@"%lld", ticket];
    [self removeTrade:ticket];
    [tradeMap setObject:trade forKey:key];
    
    NSMutableArray *instrumentArray = [tradeListMapByInstrument objectForKey:[trade getInstrument]];
    if (instrumentArray == nil) {
        instrumentArray = [[NSMutableArray alloc] init];
        [tradeListMapByInstrument setObject:instrumentArray forKey:[trade getInstrument]];
    }
    [instrumentArray addObject:trade];
    
    NSMutableArray *accountArray = [tradeListMapAccount objectForKey:[@([trade getAccount]) stringValue]];
    if (accountArray == nil) {
        accountArray = [[NSMutableArray alloc] init];
        [tradeListMapAccount setObject:accountArray forKey:[@([trade getAccount]) stringValue]];
    }
    [accountArray addObject:trade];
}

- (void)addTrades:(NSArray *)trades{
    for (TTrade* temptrade in trades) {
        [self addTrade:temptrade];
    }
}

- (void)clearTrade{
    [tradeListMapAccount removeAllObjects];
    [tradeListMapByInstrument removeAllObjects];
    [tradeMap removeAllObjects];
}

@end
