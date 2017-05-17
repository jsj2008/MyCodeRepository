//
//  FixUtil.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrder.h"
#import "TTrade.h"
#import "CDS_PriceSnapShot.h"
#import "CDS_AccountStore.h"

@interface FixUtil : NSObject

- (id)init;

- (void)fixOrder:(TOrder *)order  PriceSnapShot:(CDS_PriceSnapShot *)shot;
- (void)fixOrder:(TOrder *)order;

- (void)fixTrade:(TTrade *)trade  PriceSnapShot:(CDS_PriceSnapShot *)shot;
- (void)fixTrade:(TTrade *)trade;

- (void)fixAllAccounts;
- (Boolean)fixAccountWithAccountID:(long long)accountID;
- (Boolean)fixAccountWithAccountStore:(CDS_AccountStore *)accountStore;

- (Boolean)fixAccount:(CDS_AccountStore *)accountStore
    ForceToScanTrde:(Boolean)forceToScanTrde;

//- (Boolean)fixAccount:(CDS_AccountStore *)accountStore
//         TradeArray:(NSMutableArray *)tradeArray
//         OrderArray:(NSMutableArray *)orderArray
//   PriceSnapShotMap:(NSMutableDictionary *)priceSnapMap
//   ForceToScanTrade:(Boolean)forceToScanTrde;

- (double)fixTotalOpenPosition_4USDWithAccount:(long long)account
                                  TradeArray:(NSArray *)tradeArray;

@end
