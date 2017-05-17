//
//  DocUtil.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by zhanglei on 15/7/7.
//  Copyright (c) 2013年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instrument.h"
#import "CDS_AccountStore.h"

@interface DocUtil : NSObject

- (Boolean)isTradableIgnoreQuoteTimeoutWithGroup:(NSString *)group
                                       Account:(long long)account
                                    Instrument:(NSString *)instrument;

- (double)getMaxAmountWithGroup:(NSString *)group
                      Account:(long long)account
                   Instrument:(NSString *)instrument;

- (double)getMinAmountWithGroup:(NSString *)group
                      Account:(long long)account
                   Instrument:(NSString *)instrument;

- (Boolean)isAmountLegalWitjAccount:(long long)accountID
                       Instrument:(NSString *)instrument
                           Amount:(double)amount;

- (Boolean)isTradableWithGroup:(NSString *)group
                     Account:(long long)accountID
                  Instrument:(NSString *)instrument;

- (Boolean)isQuoteTradable:(NSString *)instrument;

- (Boolean)isForceToUptradeWithInstrument:(NSString *)instrument
                                Account:(long long)account
                                 Amount:(double)amount;

- (double)formatPriceWithOriPrice:(double)oriPrice
                  InstrumentName:(NSString *)instrument;

- (double)formatPriceWithOriPrice:(double)oriPrice
                      Instrument:(Instrument *)instrument;

- (double)getCallWithdraw:(CDS_AccountStore *)as;

- (double)_getWithdrawable_1:(CDS_AccountStore *)as;

- (double)_getWithdrawable_2:(CDS_AccountStore *)as;

@end
