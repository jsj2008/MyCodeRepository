//
//  FixUtil_4Order.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/3.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "FixUtil_4Order.h"
#import "MTP4CommDataInterface.h"
#import "Instrument.h"
#import "CommDocCaptain.h"
#import "InstrumentsAccountCfg.h"
#import "InstrumentsGroupCfg.h"
#import "APIDoc.h"

@implementation FixUtil_4Order

- (void)fixOrder:(TOrder *)order  PriceSnapShot:(CDS_PriceSnapShot *)shot{
    if (![[order getInstrument] isEqualToString:[shot instrumentName]]) {
        [order setHasBeenFixed:false];
        return;
    }
    
    if (!([order getType] == ORDERTYPE_NORMAL) && [order getIsToOpenNew] == TRUE) {
        [order setHasBeenFixed:false];
        return;
    }
    @try {
        Instrument *instrument = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:[order getInstrument]];
        long long accountID = [order getAccount];
        double orderPrice = [order getLimitPrice];
        if (orderPrice <= 0.0001) {
            orderPrice = [order getOriStopPrice];
        }
        
        double margin_open_per = [instrument getOpenMarginPercentage];
        if (false) {
            InstrumentsAccountCfg *iac = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsAccountCfg:accountID :[order getInstrument]];
            
            NSString *groupName = [[[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:accountID] getGroupName];
            InstrumentsGroupCfg *igc = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsGroupCfg:groupName :[order getInstrument]];
            if (igc != nil) {
                if ([igc getOpenMarginPercentage] >= 0 && [igc getOpenMarginPercentage] != DEFAULT) {
                    margin_open_per = [igc getOpenMarginPercentage];
                }
            }
            
            if (iac != nil) {
                if ([iac getOpenMarginPercentage] >= 0 && [iac getOpenMarginPercentage] != DEFAULT) {
                    margin_open_per = [iac getOpenMarginPercentage];
                }
            }
            
            double totleMarginInBasicCur;
            @try {
                totleMarginInBasicCur = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToAccountBasicCcy:[order getAccount]
                                                                                                           Ccy1:[instrument getCcy1]
                                                                                                         Amount:[order getAmount]];
            }
            @catch (NSException *exception) {
                double priceToCalMargin = 0;
                if ([order getBuysell ] == BUY) {
                    priceToCalMargin = [shot getAsk];
                } else {
                    priceToCalMargin = [shot getBid];
                }
                double totleMargin = [order getAmount] * priceToCalMargin;
                totleMarginInBasicCur = [[[CommDocCaptain getInstance] getExchangeUtil] exchangeToAccountBasicCcy:[order getAccount]
                                                                                                           Ccy1:[instrument getCcy2]
                                                                                                         Amount:totleMargin];
            }
            [order setMarginOccupied4OpenTrade:totleMarginInBasicCur * margin_open_per];
            [order setHasBeenFixed:true];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@ %@", [exception name], [exception reason]);
        [order setHasBeenFixed:false];
    }
}

- (void)fixOrder:(TOrder *)order{
    @try {
        InstrumentUtil *util = [APIDoc getInstrumentUtil:[order getInstrument]];
        CDS_PriceSnapShot *shot = [util getPriceSnapShotWithAccountID:[order getAccount]];
        [self fixOrder:order  PriceSnapShot:shot];
    }
    @catch (NSException *exception) {
        [order setHasBeenFixed:false];
        return;
    }
}

@end
