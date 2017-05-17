//
//  FixUtil_4Account.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/3.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDS_AccountStore.h"
#import "TTrade.h"
#import "TOrder.h"

@interface _Margin4LockInfoNode : NSObject{
    double _unlockedMargin;
    double _lockedMargin;
}
- (id)initWithUnlockedMargin:(double)unlockedMargin
              LockedMargin:(double)lockedMargin;

- (double)getTotalMargin;

@end

@interface __AccountInstrumentTradeInfoNode : NSObject
@property NSString *instrument;
@property double C_openMarginUsed_buy;
@property double C_marginCall1Used_buy;
@property double C_marginCall2Used_buy;
@property double C_liquidationMarginUsed_buy;
@property double C_unlockMarginUsed_buy;
@property double C_openMarginUsed_sell;
@property double C_marginCall1Used_sell;
@property double C_marginCall2Used_sell;
@property double C_liquidationMarginUsed_sell;
@property double C_unlockMarginUsed_sell;
@property double C_amount_buy;
@property double C_amount_sell;
@property double c_amount_buy_order;
@property double c_amount_sell_order;
@property double C_openMarginUsed_buy_order;
@property double C_openMarginUsed_sell_order;
@end

@interface FixUtil_4Account : NSObject

- (Boolean)fixAccountByAccountID:(long long)accountID;

- (Boolean)fixAccountByAccountID:(long long)accountID
              ForceToScanTrade:(Boolean)forceToScanTrade;

- (Boolean)fixAccountByAccountStore:(CDS_AccountStore *)accountStore;
- (Boolean)fixAccountByAccountStore:(CDS_AccountStore *)accountStore
                 ForceToScanTrade:(Boolean)forceToScanTrade;

//- (Boolean)fixAccountByAccountStore:(CDS_AccountStore *)accountStore
//                       TradeArray:(NSMutableArray *)tradeArray
//                       OrderArray:(NSMutableArray *)orderArray
//                    PriceSnapShot:(NSMutableDictionary *)priceSnapShotMap
//                 ForceToScanTrade:(Boolean)forceScanTrade;

- (void)__fixTradeArray:(NSArray *)tradeArray
//        PriceSnapShot:(NSMutableDictionary *)priceSnapShotMap
     ForceToScanTrade:(Boolean)forceScanTrade;

- (void)__fixOrderArray:(NSArray *)orderArray
//        PriceSnapShot:(NSMutableDictionary *)priceSnapShotMap
     ForceToScanTrade:(Boolean)forceScanTrade;

- (void)__packTradeIntoAiti:(NSDictionary *)instrumentInfoMap
                    Trade:(TTrade *)trade;

- (void)__packOrderIntoAiti:(NSDictionary *)instrumentInfoMap
                     Orde:(TOrder *)order;

- (_Margin4LockInfoNode *)__caculateMarginInfoForOneInstrumentByLotsBuy:(double)lotsBuy
                                                             LotsSell:(double)lotsSell
                                                            MarginBuy:(double)marginBuy
                                                           MarginSell:(double)marginSell;

- (double)__caculateMarginForOneInstrumentByLotsBuy:(double)lotsBuy
                                         LotsSell:(double)lotsSell
                                        MarginBuy:(double)marginBuy
                                       MarginSell:(double)marginSell;

- (double)__calculateMaring2:(long long)accountID;

- (double)__calculateMoneyFrozen:(long long)accountID;

- (double)fixTotalOpenPosition_4USDByAccountID:(long long)accountID
                                  TradeArray:(NSArray *)tradeArray;

@end
