//
//  FixUtil_4Trade.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/3.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "FixUtil_4Trade.h"
#import "Instrument.h"
#import "CommDocCaptain.h"
#import "KeyNotFundException.h"
#import "MTP4CommDataInterface.h"
#import "APIDoc.h"

@implementation FixUtil_4Trade

- (void)fixTrade:(TTrade *)trade  PriceSnapShot:(CDS_PriceSnapShot *)shot{
    if (![[trade getInstrument] isEqualToString:[shot instrumentName]]) {
        [trade setHasBeenFixed:false];
    }
    
    @try {
        Instrument *instrument = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:[trade getInstrument]];
//        PriceSnapShotUtil *priceSnapShotUtil = [[CommDocCaptain getInstance] getPriceSnapShotUtil:shot];
//        PriceSnapShotUtil *priceSnapShotUtil = [APIDoc getPriceSnapShotUtil:shot];
        PriceSnapShotUtil *priceSnapShotUtil = [PriceSnapShotUtil newInstance:shot];
        long long accountID = [trade getAccount];
        double amount = [trade getAmount];
        double price4PLCalculate = [shot tradePrice:[trade getBuysell] == BUY ? SELL : BUY];
        double realPL = [priceSnapShotUtil calculateRealPL4PositionWithAccount:amount
                                                                OpenTradePrice:[trade getOpenprice]
                                                                   ToBuyOrSell:[trade getBuysell]];
        priceSnapShotUtil = nil;
        CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:accountID];
        if (as == nil) {
            @throw [[KeyNotFundException alloc] initWithKeyName:@"account"  Object:[NSString stringWithFormat:@"%lld", accountID]];
        }
        ExchangeUtil_node *exchangeUtilNode4PL = [[[CommDocCaptain getInstance] getExchangeUtil] createExchangeNode:[instrument getCcy2]
                                                                                                             Amount:realPL
                                                                                                               Ccy2:[as getBasicCurrency]
                                                                                                     PairInstrument:[trade getInstrument]
                                                                                                     SuggestedPrice:price4PLCalculate];
        double plInBasicCur = [exchangeUtilNode4PL getExchangeMoney];
        double margin_open_per = [instrument getOpenMarginPercentage];
        double margin_MC1_per = [instrument getMarginCall1Percentage];
        double margin_MC2_per = [instrument getMarginCall2Percentage];
        double margin_Liq_per = [instrument getLiquidationMarginPercentage];
        double margin_unlock_per = [instrument getUnLockMarginPercentage];
        double totleMarginInBasicCur;
        
        @try {
            totleMarginInBasicCur = fabs([[[CommDocCaptain getInstance] getExchangeUtil] exchangeToAccountBasicCcy:[trade getAccount]
                                                                                                              Ccy1:[instrument getCcy1]
                                                                                                            Amount:-[trade getAmount]]);
        }
        @catch (NSException *exception) {
            double priceToCalMargin = 0;
            if ([trade getBuysell] == BUY) {
                priceToCalMargin = [shot getAsk];
            } else {
                priceToCalMargin = [shot getBid];
            }
            
            double totleMargin = [trade getAmount] * priceToCalMargin;
            totleMarginInBasicCur = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToAccountBasicCcy:[trade getAccount]
                                                                                                         Ccy1:[instrument getCcy2]
                                                                                                       Amount:totleMargin];
        }
        
        [trade setMarginOccupied4OpenTrade:totleMarginInBasicCur * margin_open_per];
        [trade setMarginOccupied4MarginCall1:totleMarginInBasicCur * margin_MC1_per];
        [trade setMarginOccupied4MarginCall2:totleMarginInBasicCur * margin_MC2_per];
        
        [trade setMarginOccupied4Liquidation:totleMarginInBasicCur * margin_Liq_per];
        [trade setMarginOccupied4UnLock:totleMarginInBasicCur * margin_unlock_per];
        
        [trade setFloatPL:plInBasicCur];
        [trade setFloatPLInCCY2:realPL];
        [trade setPlRate:[exchangeUtilNode4PL getExchangePrice]];
        [trade setMarketPrice:price4PLCalculate];
        [trade setHasBeenFixed:true];
    }
    @catch (NSException *exception) {
        NSLog(@"%@ %@", [exception name], [exception reason]);
        [trade setHasBeenFixed:false];
    }
}

- (void)fixTrade:(TTrade *)trade{
    @try {
        InstrumentUtil *util = [APIDoc getInstrumentUtil:[trade getInstrument]];
        CDS_PriceSnapShot *shot = [util getPriceSnapShotWithAccountID:[trade getAccount]];
        [self fixTrade:trade  PriceSnapShot:shot];
    }
    @catch (NSException *exception) {
        NSLog(@"%@ %@", [exception name], [exception reason]);
        [trade setHasBeenFixed:false];
        return;
    }
}

@end
