//
//  FixUtil.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "FixUtil.h"
#import "CommDocCaptain.h"
#import "FixUtil_4Trade.h"
#import "FixUtil_4Order.h"
#import "FixUtil_4Account.h"

@interface FixUtil(){
    FixUtil_4Trade *_fixUtil_4Trade;
    FixUtil_4Order *_fixUitl_4Order;
    FixUtil_4Account *_fixUtil_4Account;
}

@end

@implementation FixUtil

- (id)init{
    if (self = [super init]) {
        _fixUtil_4Trade = [[FixUtil_4Trade alloc] init];
        _fixUitl_4Order = [[FixUtil_4Order alloc] init];
        _fixUtil_4Account = [[FixUtil_4Account alloc] init];
    }
    return self;
}

- (void)fixOrder:(TOrder *)order  PriceSnapShot:(CDS_PriceSnapShot *)shot{
    [_fixUitl_4Order fixOrder:order  PriceSnapShot:shot];
}

- (void)fixOrder:(TOrder *)order{
    [_fixUitl_4Order fixOrder:order];
}

- (void)fixTrade:(TTrade *)trade  PriceSnapShot:(CDS_PriceSnapShot *)shot{
    [_fixUtil_4Trade fixTrade:trade  PriceSnapShot:shot];
}

- (void)fixTrade:(TTrade *)trade{
    [_fixUtil_4Trade fixTrade:trade];
}

- (void)fixAllAccounts{
    NSArray *asArray = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStoreArray];
    for (CDS_AccountStore *as in asArray) {
        [_fixUtil_4Account fixAccountByAccountID:[as getAccountID]  ForceToScanTrade:true];
    }
}

- (Boolean)fixAccountWithAccountID:(long long)accountID{
    return [_fixUtil_4Account fixAccountByAccountID:accountID];
}

- (Boolean)fixAccountWithAccountStore:(CDS_AccountStore *)accountStore{
    return [_fixUtil_4Account fixAccountByAccountStore:accountStore];
}

- (Boolean)fixAccount:(CDS_AccountStore *)accountStore
    ForceToScanTrde:(Boolean)forceToScanTrde{
    return [_fixUtil_4Account fixAccountByAccountStore:accountStore  ForceToScanTrade:forceToScanTrde];
}

//- (Boolean)fixAccount:(CDS_AccountStore *)accountStore
//         TradeArray:(NSMutableArray *)tradeArray
//         OrderArray:(NSMutableArray *)orderArray
//   PriceSnapShotMap:(NSMutableDictionary *)priceSnapMap
//   ForceToScanTrade:(Boolean)forceToScanTrde{
//    return [_fixUtil_4Account fixAccountByAccountStore:accountStore
//                                          TradeArray:tradeArray
//                                          OrderArray:orderArray
//                                       PriceSnapShot:priceSnapMap
//                                    ForceToScanTrade:forceToScanTrde];
//}

- (double)fixTotalOpenPosition_4USDWithAccount:(long long)account
                                  TradeArray:(NSArray *)tradeArray{
    return [_fixUtil_4Account fixTotalOpenPosition_4USDByAccountID:account
                                                      TradeArray:tradeArray];
}

@end
