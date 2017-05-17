//
//  GroupDoc.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupConfig.h"
#import "TradeDoc.h"
#import "OrderDoc.h"
#import "CDS_AccountStore.h"

@interface GroupDoc : NSObject

@property GroupConfig *groupConfig;

- (id)initWithGroupConfig:(GroupConfig *)_groupConfig;

- (CDS_AccountStore *)getAccountStore:(long long)account;
- (Boolean)containAccount:(long long)account;
- (NSArray *)getAccountStoreVector;
- (void)removeAccountStore:(long long)accountID;
- (void)addAccountStore:(CDS_AccountStore *)as;
- (void)addAccountStores:(NSArray *)asv;

- (TradeDoc *)getTradeDoc;
- (void)removeTrade:(long long)ticket;
- (void)addTrade:(TTrade *)trade;
- (void)addTrades:(NSArray *)trades;
- (void)clearTrade;

- (OrderDoc *)getOrderDoc;
- (void)removeOrder:(long long)orderID;
- (void)addOrder:(TOrder *)order;
- (void)addOrders:(NSArray *)orders;
- (void)clearOrder;


@end
