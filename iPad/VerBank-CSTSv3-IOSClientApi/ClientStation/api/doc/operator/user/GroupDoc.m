//
//  GroupDoc.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "GroupDoc.h"

@interface GroupDoc(){
    NSMutableDictionary *accountStoreMap;
    TradeDoc *tradeDoc;
    OrderDoc *orderDoc;
}

@end

@implementation GroupDoc

@synthesize groupConfig;

- (id)initWithGroupConfig:(GroupConfig *)_groupConfig{
    if (self = [super init]) {
        groupConfig = _groupConfig;
        tradeDoc = [[TradeDoc alloc] init];
        orderDoc = [[OrderDoc alloc] init];
        accountStoreMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (CDS_AccountStore *)getAccountStore:(long long)account{
    return [accountStoreMap objectForKey:[@(account) stringValue]];
}

- (Boolean)containAccount:(long long)account{
    return [[accountStoreMap allKeys] containsObject:[@(account) stringValue]];
}

- (NSArray *)getAccountStoreVector{
    return [accountStoreMap allKeys];
}

- (void)removeAccountStore:(long long)accountID{
    [accountStoreMap removeObjectForKey:[@(accountID) stringValue]];
}

- (void)addAccountStore:(CDS_AccountStore *)as{
    [accountStoreMap setObject:as forKey:[@([as getAccountID]) stringValue]];
}

- (void)addAccountStores:(NSArray *)asv{
    for (CDS_AccountStore *tempAccountStore in asv) {
        [self addAccountStore:tempAccountStore];
    }
}

- (TradeDoc *)getTradeDoc{
    return tradeDoc;
}

- (void)removeTrade:(long long)ticket{
    [tradeDoc removeTrade:ticket];
}

- (void)addTrade:(TTrade *)trade{
    [tradeDoc addTrade:trade];
}

- (void)addTrades:(NSArray *)trades{
    [tradeDoc addTrades:trades];
}

- (void)clearTrade{
    [tradeDoc clearTrade];
}

- (OrderDoc *)getOrderDoc{
    return  orderDoc;
}

- (void)removeOrder:(long long)orderID{
    [orderDoc removeOrder:orderID];
}

- (void)addOrder:(TOrder *)order{
    [orderDoc addOrder:order];
}

- (void)addOrders:(NSArray *)orders{
    [orderDoc addOrders:orders];
}

- (void)clearOrder{
    [orderDoc clearOrder];
}

@end
