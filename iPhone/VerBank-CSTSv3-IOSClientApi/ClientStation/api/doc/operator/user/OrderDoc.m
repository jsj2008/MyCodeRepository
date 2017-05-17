//
//  OrderDoc.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "OrderDoc.h"

@interface OrderDoc(){
    NSMutableDictionary* orderListMapByInstrument;
    NSMutableDictionary* orderListMapAccount;
    NSMutableDictionary* orderMap;
}

@end

@implementation OrderDoc

- (id)init{
    if (self = [super init]) {
        orderListMapByInstrument = [[NSMutableDictionary alloc] init];
        orderListMapAccount = [[NSMutableDictionary alloc] init];
        orderMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSMutableArray *)getTOrderByAccountList:(long long)account{
    NSMutableArray *array = [orderListMapAccount objectForKey:[@(account) stringValue]];
    if (array != nil) {
        return  array;
    }
    return [[NSMutableArray alloc] init];
}

- (NSMutableArray *)getTOrderByInstrumentList:(NSString *)instrumen{
    NSMutableArray *array = [orderListMapByInstrument objectForKey:instrumen];
    if (array != nil) {
        return array;
    }
    return  [[NSMutableArray alloc] init];
}

- (TOrder *)getTOrder:(long long)orderID{
    return [orderMap objectForKey:[@(orderID) stringValue]];
}

- (NSArray *)getTOrders{
    return [orderMap allValues];
}

- (void)removeOrder:(long long)orderID{
    NSString *key = [NSString stringWithFormat:@"%lld", orderID];
    TOrder *order = (TOrder *)[orderMap objectForKey:key];
    [orderMap removeObjectForKey:key];
    
    if (order != nil) {
        NSMutableArray * instrumentArray = [orderListMapByInstrument objectForKey:[order getInstrument]];
        for (TOrder *tempOrder in instrumentArray) {
            if ([tempOrder getOrderID] == [order getOrderID]) {
                [instrumentArray removeObject:tempOrder];
                break;
            }
        }
        NSMutableArray * accountArray = [orderListMapAccount objectForKey:[@([order getAccount]) stringValue]];
        for (TOrder *tempOrder in accountArray) {
            if ([tempOrder getOrderID] == [order getOrderID]) {
                [accountArray removeObject:tempOrder];
                break;
            }
        }
    }
}

- (void)addOrder:(TOrder *)order{
    long long orderID = [order getOrderID];
    NSString *key = [NSString stringWithFormat:@"%lld", orderID];
    [self removeOrder:orderID];
    [orderMap setObject:order forKey:key];
    
    NSMutableArray *instrumentArray = [orderListMapByInstrument objectForKey:[order getInstrument]];
    if (instrumentArray == nil) {
        instrumentArray = [[NSMutableArray alloc] init];
        [orderListMapByInstrument setObject:instrumentArray forKey:[order getInstrument]];
    }
    [instrumentArray addObject:order];
    
    NSMutableArray *accountArray = [orderListMapAccount objectForKey:[@([order getAccount]) stringValue]];
    if (accountArray == nil) {
        accountArray = [[NSMutableArray alloc] init];
        [orderListMapAccount setObject:accountArray forKey:[@([order getAccount]) stringValue]];
    }
    [accountArray addObject:order];
}

- (void)addOrders:(NSArray *)orders{
    for (TOrder* tempOrder in orders) {
        [self addOrder:tempOrder];
    }
}

- (void)clearOrder{
    [orderListMapAccount removeAllObjects];
    [orderListMapByInstrument removeAllObjects];
    [orderMap removeAllObjects];
}

@end
