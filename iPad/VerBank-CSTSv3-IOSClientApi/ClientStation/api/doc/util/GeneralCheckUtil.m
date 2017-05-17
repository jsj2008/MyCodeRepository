//
//  GeneralCheckUtil.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "GeneralCheckUtil.h"
#import "JEDISystem.h"

#import "InstrumentUtil.h"
#import "CommDocCaptain.h"

#import "MTP4CommDataInterface.h"
#import "APIDoc.h"

@implementation GeneralCheckUtil

- (Boolean)isTradeAmountLegal4MKTTrade:(NSString *)instrument
                                  acid:(long long)accountID
                               buySell:(int)buySell
                                amount:(long)amount{
    JEDI_SYS_Try {
        InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:instrument];
        CDS_PriceSnapShot *pss = [instUtil getPriceSnapShotWithAccountID:accountID];
        double price = [pss tradePrice:buySell];
        return [self isTradeAmountLegal:instrument price:price amount:amount];
    }JEDI_SYS_EndTry
}

- (Boolean)isTradeAmountLegal:(NSString *)instrument
                        price:(double)price
                       amount:(long)amount{
    JEDI_SYS_Try {
        long d = amount % 10000;
        if (d != 0) {
            return false;
        }
        
        Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument];
        double amountInUSD = -1;
        amountInUSD = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToSysBasicCcy:[inst getCcy1] :amount];
        if (amountInUSD <= 0) {
            double amountInCcy2 = amount * price;
            amountInUSD = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToSysBasicCcy:[inst getCcy2] :amountInCcy2];
        }
        
        if (amountInUSD < [[[[CommDocCaptain getInstance] getSystemDocCaptain] systemConfig] getWebTradeMinAmount]) {
            NSLog(@"[amountInUSD < WebTradeMinAmount]");
            return false;
        }
        
        if (amountInUSD > [[[[CommDocCaptain getInstance] getSystemDocCaptain] systemConfig] getWebTradeMaxAmount]) {
            NSLog(@"[amountInUSD > WebTradeMaxAmount]");
            return false;
        }
        return true;
    } JEDI_SYS_EndTry
}

- (NSString *)isTradeAmountLegal4MKTTrade2:(NSString *)instrument
                                      acid:(long long)accountID
                                   buySell:(int)buySell
                                    amount:(long)amount{
    @try {
        InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:instrument];
        CDS_PriceSnapShot *pss = [instUtil getPriceSnapShotWithAccountID:accountID];
        double price = [pss tradePrice:buySell];
        return [self isTradeAmountLegal2:instrument price:price amount:amount];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return @"20115";
    }
    
}

- (NSString *)isTradeAmountLegal2:(NSString *)instrument
                            price:(double)price
                           amount:(long)amount{
    @try {
        long d = amount % 10000;
        if (d != 0) {
            return @"20111";
        }
        Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument];
        double amountInUSD = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToSysBasicCcy:[inst getCcy1] :amount];
        
        if (amountInUSD <= 0) {
            double amountInCcy2 = amount * price;
            amountInUSD = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToSysBasicCcy:[inst getCcy2] :amountInCcy2];
        }
        
        if (amountInUSD < [[[[CommDocCaptain getInstance] getSystemDocCaptain] systemConfig] getWebTradeMinAmount]) {
            NSLog(@"[amountInUSD < WebTradeMinAmount]");
            return @"20112";
        }
        
        if (amountInUSD > [[[[CommDocCaptain getInstance] getSystemDocCaptain] systemConfig] getWebTradeMaxAmount]) {
            NSLog(@"[amountInUSD > WebTradeMaxAmount]");
            return @"20118";
        }
        return nil;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return @"20115";
    }
}

- (Boolean)isTradeAmountLegalForClosePosition:(long)positionAmount
                                toCloseAmount:(long)toCloseAmount{
    long d = toCloseAmount % 10000;
    if (d != 0) {
        return false;
    }
    
    double left = positionAmount - toCloseAmount;
    if (left == 0) {
        return true;
    }
    return true;
}

- (Boolean)isTradeAmountLegalForOpenPosition:(long)amount{
    long d = amount % 10000;
    if (d != 0) {
        return false;
    }
    if (amount == 0) {
        return true;
    }
    return true;
}

@end
