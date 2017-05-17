//
//  SystemDocCaptain.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicCurrency.h"
#import "SystemConfig.h"
#import "InterestRate.h"
#import "InterestAddType.h"
#import "CDS_InterestRate4Ccy.h"
#import "ValueDaySetting.h"
#import "Instrument.h"
#import "InstrumentsGroupCfg.h"
#import "InstrumentsAccountCfg.h"
#import "QuoteData.h"
#import "Holidays4ccy.h"
#import "NotValueDay4Inst.h"

@interface SystemDocCaptain : NSObject

#pragma basicCurrency
- (void)resetBasicCurrencys:(NSArray *)basicCurrencyArray;
- (void)addBasicCurrency:(BasicCurrency *)bc;
- (BasicCurrency *)getBasicCurrency:(NSString *)currencyName;
- (NSArray *)getBasicCurrencyArray;

#pragma SystemConfig
@property SystemConfig* systemConfig;
- (NSString *)getSystemBasicCurrency;
- (Boolean)isSystemOpened;

#pragma InterestRate
- (void)resetInterestRate:(NSArray *)irv;
- (void)addInterestRate:(InterestRate *)ir;
- (InterestRate *)getInterestRate:(NSString *)ccy;

#pragma InterestAddType
- (void)resetInterestAddType:(NSArray *)iatArray;
- (void)addInterestAddType:(InterestAddType *)iat;
- (InterestAddType *)getInterestAddType:(NSString *)ccy :(NSString *)typeID;
- (NSArray *)getInterestAddTypes;

#pragma CDS_InterestRate4Ccy
- (CDS_InterestRate4Ccy *)getCDS_InterestRate4Ccy:(NSString *)ccy :(NSString *)typeID4Group :(NSString *)typeID4Acount;

#pragma Holidays4CCy
- (void)resetHolidays4Ccy:(NSArray *)h4cArray;
- (Boolean)isHoliday4Ccy:(NSString *)ccy :(NSString *)tradeDay;

#pragma NotValueDay4Inst
- (void)resetNotValueDay4Inst:(NSArray *)nvd4InstArray;
- (Boolean)isHoliday4Instrument:(NSString *)inst :(NSString *)tradeDay;

#pragma ValueDay4Inst
- (void)resetValueDay4Inst:(NSArray *)vdsArray;
- (ValueDaySetting *)getValueDay4InstrumentTradeDay:(NSString *)inst :(NSString *)tradeDay;

#pragma Instrument
- (void)resetInstruments:(NSArray *)instArray;
- (void)setInstrument:(Instrument *)instrument;
- (Instrument *)getInstrument:(NSString *)instrumentName;
- (NSArray *)getInstrumentArray;
- (NSString *)getInstrumentName4Exchange:(NSString *)exchangeName;

#pragma InstrumenGroupCfg
- (void)resetInstrumentGroupCfg:(NSArray *)igcArray;
- (void)resetInstrumentGroupCfg:(NSString *)groupName :(NSArray *)igcArray;
- (void)setInstrumentGroupCfg:(InstrumentsGroupCfg *)igc;
- (InstrumentsGroupCfg *)getInstrumentsGroupCfg:(NSString *)group :(NSString *)instrument;
- (NSArray *)getInstrumentsGroupCfg:(NSString *)group;

#pragma InstrumentAccountCfg
- (void)resetInstrumentAccountCfg:(NSArray *)iccArray;
- (void)resetInstrumentAccountCfg:(long long)accountID :(NSArray *)iccArray;
- (void)setInstrumentAccountCfg:(InstrumentsAccountCfg *)icc;
- (void)removeInstrumentAccountCfg:(long long)accountID;
- (InstrumentsAccountCfg *)getInstrumentsAccountCfg:(long long)accountID :(NSString *)instrument;
- (NSArray *)getInstrumentsAccountCfg:(long long)accountID;

#pragma Quote
- (QuoteData *)getQuote:(NSString *)instrumentName;
- (void)setQuote:(QuoteData *)quote;
- (void)resetQuote:(NSArray *)quoteArray;
- (Boolean)isQuoteTradableIgnoreQuoteEnable:(NSString *)instrument;
- (NSArray *)getBalanceRateVec;
- (void)disableQuoteTradeAbility_all;
- (void)disableQuoteTradeAbility_instrument:(NSString *)instrument;


- (void)setQuoteTradeEnable:(NSString *)instrument :(Boolean)flag;
- (Boolean)isQuoteTradable:(NSString *)instrument;
- (long long)getNextOrderID;
- (void)setOrderID:(long long)orderID;
- (long long)getNextTicketID;
- (void)setTicketID:(long long)ticketID;

@end
