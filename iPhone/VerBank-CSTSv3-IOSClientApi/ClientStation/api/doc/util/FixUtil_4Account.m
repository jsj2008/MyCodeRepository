//
//  FixUtil_4Account.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/3.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "FixUtil_4Account.h"
#import "CommDocCaptain.h"
#import "CDS_PriceSnapShot.h"
#import "Margin2.h"
#import "MoneyAccountFrozen.h"
#import "MTP4CommDataInterface.h"
#import "APIDoc.h"

@implementation __AccountInstrumentTradeInfoNode
@synthesize instrument;
@synthesize C_openMarginUsed_buy;
@synthesize C_marginCall1Used_buy;
@synthesize C_marginCall2Used_buy;
@synthesize C_liquidationMarginUsed_buy;
@synthesize C_unlockMarginUsed_buy;
@synthesize C_openMarginUsed_sell;
@synthesize C_marginCall1Used_sell;
@synthesize C_marginCall2Used_sell;
@synthesize C_liquidationMarginUsed_sell;
@synthesize C_unlockMarginUsed_sell;
@synthesize C_amount_buy;
@synthesize C_amount_sell;
@synthesize c_amount_buy_order;
@synthesize c_amount_sell_order;
@synthesize C_openMarginUsed_buy_order;
@synthesize C_openMarginUsed_sell_order;
@end

@implementation _Margin4LockInfoNode

- (id)initWithUnlockedMargin:(double)unlockedMargin
                LockedMargin:(double)lockedMargin{
    if (self = [super init]) {
        _unlockedMargin = unlockedMargin;
        _lockedMargin = lockedMargin;
    }
    return self;
}

- (double)getTotalMargin{
    return _unlockedMargin + _lockedMargin;
}

@end

@implementation FixUtil_4Account

- (Boolean)fixAccountByAccountID:(long long)accountID{
    return [self fixAccountByAccountStore:[[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:accountID]];
}

- (Boolean)fixAccountByAccountID:(long long)accountID
                ForceToScanTrade:(Boolean)forceToScanTrade{
    return [self fixAccountByAccountStore:[[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:accountID]
                         ForceToScanTrade:forceToScanTrade];
}

- (Boolean)fixAccountByAccountStore:(CDS_AccountStore *)accountStore{
    return [self fixAccountByAccountStore:accountStore
                         ForceToScanTrade:false];
}

- (Boolean)fixAccountByAccountStore:(CDS_AccountStore *)accountStore
                   ForceToScanTrade:(Boolean)forceToScanTrade{
    if (accountStore == nil) {
        return false;
    }
    
    @try {
        GroupDoc *groupDoc = [[[CommDocCaptain getInstance] getUserDocCaptain] getGroupDoc:[accountStore getGroupName]];
        if (groupDoc == nil) {
            NSLog(@"Can not find group doc for %lld", [accountStore getAccountID]);
        }
        NSMutableArray *tradeList = [[groupDoc getTradeDoc] getTTradeByAccountList:[accountStore getAccountID]];
        NSMutableArray *orderList = [[groupDoc getOrderDoc] getTOrderByAccountList:[accountStore getAccountID]];
        return [self fixAccountByAccountStore:accountStore
                                   TradeArray:tradeList
                                   OrderArray:orderList
                //                                PriceSnapShot:[[NSMutableDictionary alloc] init]
                             ForceToScanTrade:forceToScanTrade];
    }
    @catch (NSException *exception) {
        NSLog(@"%@ %@", [exception name], [exception reason]);
        return false;
    }
}

- (Boolean)fixAccountByAccountStore:(CDS_AccountStore *)accountStore
                         TradeArray:(NSMutableArray *)tradeArray
                         OrderArray:(NSMutableArray *)orderArray
//                      PriceSnapShot:(NSMutableDictionary *)priceSnapShotMap
                   ForceToScanTrade:(Boolean)forceScanTrade{
    if (accountStore == nil) {
        return false;
    }
    //    if (priceSnapShotMap == nil) {
    //        priceSnapShotMap = [[NSMutableDictionary alloc] init];
    //    }
    
    @try {
        //        [self __fixTradeArray:tradeArray  PriceSnapShot:priceSnapShotMap  ForceToScanTrade:forceScanTrade];
        //        [self __fixOrderArray:orderArray  PriceSnapShot:priceSnapShotMap  ForceToScanTrade:forceScanTrade];
        [self __fixTradeArray:tradeArray ForceToScanTrade:forceScanTrade];
        [self __fixOrderArray:orderArray ForceToScanTrade:forceScanTrade];
        //        priceSnapShotMap = nil;
        NSMutableDictionary *instrumentInfoMap = [[NSMutableDictionary alloc] init];
        
        double totleAmunt = 0;
        double totalPL = 0;
        double total_margin_open = 0;
        double total_margin_open_with_order_buy = 0;
        double total_margin_open_with_order_sell = 0;
        double total_margin_open_with_order = 0;
        double total_margin_mc1 = 0;
        double total_margin_mc2 = 0;
        double total_margin_liq = 0;
        double total_margin_unlock = 0;
        double total_amount_in_USD_4trade = 0;
        Boolean hasUnlockedPosition = false;
        
        //        for (TTrade *trade in tradeArray) {
        for (int i = 0; i < [tradeArray  count]; i++) {
            TTrade *trade = [tradeArray objectAtIndex:i];
            [self __packTradeIntoAiti:instrumentInfoMap  Trade:trade];
            totleAmunt += [trade getAmount];
            totalPL += [trade floatPL];
        }
        
        //        for (TOrder *order in orderArray) {
        for (int i = 0; i < [orderArray count]; i++) {
            TOrder *order = [orderArray objectAtIndex:i];
            if ([order getType] == ORDERTYPE_NORMAL && [order getIsToOpenNew] == TRUE) {
                [self __packOrderIntoAiti:instrumentInfoMap  Orde:order];
            }
        }
        
        MoneyAccount *ma = [accountStore moneyAccount];
        for (__AccountInstrumentTradeInfoNode *aiti in [instrumentInfoMap allValues]) {
            Instrument *instrumentNode = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:[aiti instrument]];
            
            double tempmargin4open = [self __caculateMarginForOneInstrumentByLotsBuy:[aiti C_amount_buy]
                                                                            LotsSell:[aiti C_amount_sell]
                                                                           MarginBuy:[aiti C_openMarginUsed_buy]
                                                                          MarginSell:[aiti C_openMarginUsed_sell]];
            total_margin_open += tempmargin4open;
            total_amount_in_USD_4trade += tempmargin4open / [instrumentNode getOpenMarginPercentage];
            //            total_margin_mc1 += __caculateMarginForOneInstrument(aiti.C_amount_buy, aiti.C_amount_sell, aiti.C_marginCall1Used_buy, aiti.C_marginCall1Used_sell);
            total_margin_mc1 += [self __caculateMarginForOneInstrumentByLotsBuy:[aiti C_amount_buy]
                                                                       LotsSell:[aiti C_amount_sell]
                                                                      MarginBuy:[aiti C_marginCall1Used_buy]
                                                                     MarginSell:[aiti C_marginCall1Used_sell]];
            
            //            total_margin_mc2 += __caculateMarginForOneInstrument(aiti.C_amount_buy, aiti.C_amount_sell, aiti.C_marginCall2Used_buy, aiti.C_marginCall2Used_sell);
            total_margin_mc2 += [self __caculateMarginForOneInstrumentByLotsBuy:[aiti C_amount_buy]
                                                                       LotsSell:[aiti C_amount_sell]
                                                                      MarginBuy:[aiti C_marginCall2Used_buy]
                                                                     MarginSell:[aiti C_marginCall2Used_sell]];
            
            //            total_margin_liq += __caculateMarginForOneInstrument(aiti.C_amount_buy, aiti.C_amount_sell, aiti.C_liquidationMarginUsed_buy, aiti.C_liquidationMarginUsed_sell);
            total_margin_liq += [self __caculateMarginForOneInstrumentByLotsBuy:[aiti C_amount_buy]
                                                                       LotsSell:[aiti C_amount_sell]
                                                                      MarginBuy:[aiti C_liquidationMarginUsed_buy]
                                                                     MarginSell:[aiti C_liquidationMarginUsed_sell]];
            
            //            total_margin_unlock += __caculateMarginForOneInstrument(aiti.C_amount_buy, aiti.C_amount_sell, aiti.C_unlockMarginUsed_buy, aiti.C_unlockMarginUsed_sell);
            total_margin_unlock += [self __caculateMarginForOneInstrumentByLotsBuy:[aiti C_amount_buy]
                                                                          LotsSell:[aiti C_amount_sell]
                                                                         MarginBuy:[aiti C_unlockMarginUsed_buy]
                                                                        MarginSell:[aiti C_unlockMarginUsed_sell]];
            // new function, by FEIB 12/01/2014
            total_margin_open_with_order_buy += (aiti.C_openMarginUsed_buy + aiti.C_openMarginUsed_buy_order);
            total_margin_open_with_order_sell += (aiti.C_openMarginUsed_sell + aiti.C_openMarginUsed_sell_order);
            total_margin_open_with_order += MAX(aiti.C_openMarginUsed_buy + aiti.C_openMarginUsed_buy_order, aiti.C_openMarginUsed_sell + aiti.C_openMarginUsed_sell_order);
            // removed on 12/01/2014 because FEIB changed the function
            // total_margin_open_with_order_buy +=
            // __caculateMarginForOneInstrument(aiti.C_amount_buy
            // + aiti.c_amount_buy_order, aiti.C_amount_sell,
            // aiti.C_openMarginUsed_buy
            // + aiti.C_openMarginUsed_buy_order,
            // aiti.C_openMarginUsed_sell);
            // total_margin_open_with_order_sell +=
            // __caculateMarginForOneInstrument(aiti.C_amount_buy,
            // aiti.C_amount_sell
            // + aiti.c_amount_sell_order, aiti.C_openMarginUsed_buy,
            // aiti.C_openMarginUsed_sell
            // + aiti.C_openMarginUsed_sell_order);
            //
            if (fabs([aiti C_amount_buy] - [aiti C_amount_sell]) > 0.1) {
                hasUnlockedPosition = true;
            }
        }
        
        double C_balance = 0;
        double C_floatPL = 0;
        double C_equity = 0;
        double C_margin2 = 0;
        double C_freeze = 0;
        double C_activeCapital4Margin = 0;
        
        double C_margin_open_4Positions = total_margin_open;
        double C_margin_call1 = total_margin_mc1;
        double C_margin_call2 = total_margin_mc2;
        double C_margin_liq = total_margin_liq;
        double C_margin_unlock = total_margin_unlock;
        
        //        C_balance = mac.getCashBalance() + mac.getFixedDeposit();
        C_balance = [ma getCashBalance] + [ma getFixedDeposit];
        C_floatPL = totalPL;
        //        C_equity = C_balance + C_floatPL + mac.getTbs();
        C_equity = C_balance + C_floatPL + [ma getTbs];
        //        C_margin2 = __calculateMaring2(accountStore.getAccountID());
        C_margin2 = [self __calculateMaring2:[accountStore getAccountID]];
        //        C_freeze = __calculateMoneyFrozen(accountStore.getAccountID());
        C_freeze = [self __calculateMoneyFrozen:[accountStore getAccountID]];
        C_activeCapital4Margin = C_equity + C_margin2 - C_freeze;
        
        [accountStore setC_balance:C_balance];
        [accountStore setC_floatPL:C_floatPL];
        [accountStore setC_equity:C_equity];
        [accountStore setC_margin2:C_margin2];
        [accountStore setC_freeze:C_freeze];
        [accountStore setC_activeCapital4Margin:C_activeCapital4Margin];
        [accountStore setC_margin_open_with_order_buy:total_margin_open_with_order_buy];
        [accountStore setC_margin_open_with_order_sell:total_margin_open_with_order_sell];
        [accountStore setC_margin_open_with_order:total_margin_open_with_order];
        [accountStore setC_margin_open_4Positions:C_margin_open_4Positions];
        [accountStore setC_margin_call1:C_margin_call1];
        [accountStore setC_margin_call2:C_margin_call2];
        [accountStore setC_margin_liq:C_margin_liq];
        [accountStore setC_margin_unlock:C_margin_unlock];
        [accountStore setC_allPositionLocked:!hasUnlockedPosition];
        [accountStore setC_totalAmountInUSD4Trades:total_amount_in_USD_4trade];
        if (total_amount_in_USD_4trade < 0.001) {
            [accountStore setC_marginRate:DBL_MAX];
        } else {
            [accountStore setC_marginRate:C_activeCapital4Margin / total_amount_in_USD_4trade];
        }
        [accountStore setHasBeenFixed:true];
        return true;
    }
    @catch (NSException *exception) {
        [accountStore setHasBeenFixed:false];
        NSLog(@"%@ %@", [exception name], [exception reason]);
    }
}

- (void)__fixTradeArray:(NSArray *)tradeArray
//          PriceSnapShot:(NSMutableDictionary *)priceSnapShotMap
       ForceToScanTrade:(Boolean)forceScanTrade{
    
    //    for (TTrade *trade in tradeArray) {
    for (int i = 0; i < [tradeArray count]; i++) {
        TTrade *trade = [tradeArray objectAtIndex:i];
        if (forceScanTrade || ![trade hasBeenFixed]) {
            //            if (![[priceSnapShotMap allKeys] containsObject:[trade getInstrument]]) {
            //                InstrumentUtil *util = ;
            CDS_PriceSnapShot *priceSnapShot = [[APIDoc getInstrumentUtil:[trade getInstrument]]
                                                getPriceSnapShotWithAccountID:[trade getAccount]];
            //                [priceSnapShotMap setValue:priceSnapShot forKey:[trade getInstrument]];
            //                [priceSnapShotMap setObject:priceSnapShot forKey:[trade getInstrument]];
            //            }
            //            CDS_PriceSnapShot *priceSnapShot = [priceSnapShotMap objectForKey:[trade getInstrument]];
            [[[CommDocCaptain getInstance] getFixUtil] fixTrade:trade
                                                  PriceSnapShot:priceSnapShot];
        }
    }
    
    //    priceSnapShotMap = nil;
}

- (void)__fixOrderArray:(NSArray *)orderArray
//          PriceSnapShot:(NSDictionary *)priceSnapShotMap
       ForceToScanTrade:(Boolean)forceScanTrade{
    
    //    for (TOrder *order in orderArray) {
    for (int i = 0; i < [orderArray count]; i++) {
        TOrder *order = [orderArray objectAtIndex:i];
        if (forceScanTrade || ![order hasBeenFixed]) {
            //            if (![[priceSnapShotMap allKeys] containsObject:[order getInstrument]]) {
            //                InstrumentUtil *util = [APIDoc getInstrumentUtil:[order getInstrument]];
            CDS_PriceSnapShot *priceSnapShot = [[APIDoc getInstrumentUtil:[order getInstrument]]
                                                getPriceSnapShotWithAccountID:[order getAccount]];
            //                [priceSnapShotMap setValue:priceSnapShot forKey:[order getInstrument]];
            //            }
            //            CDS_PriceSnapShot *priceSnapShot = [priceSnapShotMap objectForKey:[order getInstrument]];
            [[[CommDocCaptain getInstance] getFixUtil] fixOrder:order
                                                  PriceSnapShot:priceSnapShot];
        }
    }
    //    priceSnapShotMap = nil;
}

- (void)__packTradeIntoAiti:(NSDictionary *)instrumentInfoMap
                      Trade:(TTrade *)trade{
    __AccountInstrumentTradeInfoNode *aiti = (__AccountInstrumentTradeInfoNode *)[instrumentInfoMap objectForKey:[trade getInstrument]];
    if (aiti == nil) {
        aiti = [[__AccountInstrumentTradeInfoNode alloc] init];
        [aiti setInstrument:[trade getInstrument]];
        [instrumentInfoMap setValue:aiti forKey:[trade getInstrument]];
    }
    
    if ([trade getBuysell] == BUY) {
        [aiti setC_openMarginUsed_buy:[aiti C_openMarginUsed_buy] + [trade marginOccupied4OpenTrade]];
        [aiti setC_marginCall1Used_buy:[aiti C_marginCall1Used_buy] + [trade marginOccupied4MarginCall1]];
        [aiti setC_marginCall2Used_buy:[aiti C_marginCall2Used_buy] + [trade marginOccupied4MarginCall2]];
        [aiti setC_liquidationMarginUsed_buy:[aiti C_liquidationMarginUsed_buy] + [trade marginOccupied4Liquidation]];
        [aiti setC_unlockMarginUsed_buy:[aiti C_unlockMarginUsed_buy] + [trade marginOccupied4UnLock]];
        [aiti setC_amount_buy:[aiti C_amount_buy] + [trade getAmount]];
    } else {
        [aiti setC_openMarginUsed_sell:[aiti C_openMarginUsed_sell] + [trade marginOccupied4OpenTrade]];
        [aiti setC_marginCall1Used_sell:[aiti C_marginCall1Used_sell] + [trade marginOccupied4MarginCall1]];
        [aiti setC_marginCall2Used_sell:[aiti C_marginCall2Used_sell] + [trade marginOccupied4MarginCall2]];
        [aiti setC_liquidationMarginUsed_sell:[aiti C_liquidationMarginUsed_sell] + [trade marginOccupied4Liquidation]];
        [aiti setC_unlockMarginUsed_sell:[aiti C_unlockMarginUsed_sell] + [trade marginOccupied4UnLock]];
        [aiti setC_amount_sell:[aiti C_amount_sell] + [trade getAmount]];
    }
}

- (void)__packOrderIntoAiti:(NSDictionary *)instrumentInfoMap
                       Orde:(TOrder *)order{
    
    if ([order getType] != ORDERTYPE_NORMAL || [order getIsToOpenNew] == FALSE) {
        return;
    }
    
    __AccountInstrumentTradeInfoNode *aiti = (__AccountInstrumentTradeInfoNode *)[instrumentInfoMap objectForKey:[order getInstrument]];
    
    if (aiti == nil) {
        aiti = [[__AccountInstrumentTradeInfoNode alloc] init];
        [aiti setInstrument:[order getInstrument]];
        [instrumentInfoMap setValue:aiti forKey:[order getInstrument]];
    }
    
    if ([order getBuysell] == BUY) {
        [aiti setC_openMarginUsed_buy_order:[aiti C_openMarginUsed_buy_order] + [order marginOccupied4OpenTrade]];
        [aiti setC_amount_buy_order:[aiti c_amount_buy_order] + [order getAmount]];
    } else {
        [aiti setC_openMarginUsed_sell_order:[aiti C_openMarginUsed_sell_order] + [order marginOccupied4OpenTrade]];
        [aiti setC_amount_sell_order:[aiti c_amount_sell_order] + [order getAmount]];
    }
}

- (_Margin4LockInfoNode *)__caculateMarginInfoForOneInstrumentByLotsBuy:(double)lotsBuy
                                                               LotsSell:(double)lotsSell
                                                              MarginBuy:(double)marginBuy
                                                             MarginSell:(double)marginSell{
    double scale = [[[[CommDocCaptain getInstance] getSystemDocCaptain] systemConfig] getHedgedMarginScale];
    if (scale < 0.1) {
        scale = 1;
    }
    
    double lockedLots = MIN(lotsBuy, lotsSell);
    double lockedMargin4Buy;
    
    if (lotsBuy < 0.001) {
        lockedMargin4Buy = 0;
    } else {
        lockedMargin4Buy = (lockedLots / lotsBuy) * marginBuy;
    }
    
    double lockedMargin4Sell;
    if (lotsSell < 0.001) {
        lockedMargin4Sell = 0;
    } else {
        lockedMargin4Sell = (lockedLots / lotsSell) * marginSell;
    }
    double leftMargin4Buy = marginBuy - lockedMargin4Buy;
    double leftMargin4Sell = marginSell - lockedMargin4Sell;
    double leftMargin = leftMargin4Buy + leftMargin4Sell;
    double lockedMargin = (lockedMargin4Sell + lockedMargin4Buy) / 2.0 * scale;
    
    if (fabs(scale - 1.0) < 0.0001) {
        lockedMargin = MAX(lockedMargin4Sell, lockedMargin4Buy);
    } else if (fabs(scale - 2.0) < 0.0001) {
        lockedMargin = lockedMargin4Sell + lockedMargin4Buy;
    }
    
    _Margin4LockInfoNode *mlin = [[_Margin4LockInfoNode alloc] initWithUnlockedMargin:leftMargin
                                                                         LockedMargin:lockedMargin];
    return mlin;
}

- (double)__caculateMarginForOneInstrumentByLotsBuy:(double)lotsBuy
                                           LotsSell:(double)lotsSell
                                          MarginBuy:(double)marginBuy
                                         MarginSell:(double)marginSell{
    _Margin4LockInfoNode *node = [self __caculateMarginInfoForOneInstrumentByLotsBuy:lotsBuy
                                                                            LotsSell:lotsSell
                                                                           MarginBuy:marginBuy
                                                                          MarginSell:marginSell];
    return [node getTotalMargin];
}

- (double)__calculateMaring2:(long long)accountID{
    NSArray *list = [[[CommDocCaptain getInstance] getUserDocCaptain] getMargin24Account:accountID];
    double margin2 = 0;
    for (Margin2 *rec in list) {
        if (fabs([rec getAmount]) < 0.01) {
            continue;
        }
        double m = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToAccountBasicCcy:accountID
                                                                                        Ccy1:[rec getCurrencyName]
                                                                                      Amount:[rec getAmount]];
        margin2 += m * [rec getShrinkRate];
    }
    return margin2;
}

- (double)__calculateMoneyFrozen:(long long)accountID{
    NSArray *list = [[[CommDocCaptain getInstance] getUserDocCaptain] getMoneyAccountFrozen4Account:accountID];
    double m = 0;
    for (MoneyAccountFrozen *rec in list) {
        m += [rec getAmount];
    }
    return m;
}

- (double)fixTotalOpenPosition_4USDByAccountID:(long long)accountID
                                    TradeArray:(NSArray *)tradeArray{
    CDS_AccountStore *store = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:accountID];
    if (store == nil) {
        return 0.0;
    }
    
    //    NSMutableDictionary *priceSnapShotMap = [[NSMutableDictionary alloc] init];
    [self __fixTradeArray:tradeArray
     //            PriceSnapShot:priceSnapShotMap
         ForceToScanTrade:false];
    
    NSMutableDictionary *instrumentInfoMap = [[NSMutableDictionary alloc] init];
    double total_amount_in_USD_4trade = 0.0;
    
    for (TTrade *trade in tradeArray) {
        [self __packTradeIntoAiti:instrumentInfoMap  Trade:trade];
    }
    
    for (__AccountInstrumentTradeInfoNode *aiti in instrumentInfoMap) {
        Instrument *instrumentNode = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:[aiti instrument]];
        double tempmargin4open = [self __caculateMarginForOneInstrumentByLotsBuy:[aiti C_amount_buy]
                                                                        LotsSell:[aiti C_amount_sell]
                                                                       MarginBuy:[aiti C_openMarginUsed_buy]
                                                                      MarginSell:[aiti C_openMarginUsed_sell]];
        
        total_amount_in_USD_4trade += tempmargin4open / [instrumentNode getOpenMarginPercentage];
    }
    
    return [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToSysBasicCcy:[store getBasicCurrency]
                                                                                :total_amount_in_USD_4trade];
}

@end
