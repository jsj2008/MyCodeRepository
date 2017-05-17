//
//  SystemDocCaptain.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "SystemDocCaptain.h"
#import "MTP4CommDataInterface.h"
#import "ExchangeUtil.h"
#import "BalanceRate.h"


@interface SystemDocCaptain(){
    NSMutableDictionary *basicCurrencyMap;
    NSMutableDictionary *interestRateMap;
    NSMutableDictionary *interestAddTypeMap;
    NSMutableDictionary *holidays4CcySetMap;
    NSMutableDictionary *notValueDay4InstSetMap;
    NSMutableDictionary *valueDay4InstSetMap;
    NSMutableDictionary *instrumentMap;
    NSMutableArray *instrumentList;
    NSMutableDictionary *exchangeName2InstrumentNameMap;
    NSMutableDictionary *instrumentGroupCfgMap;
    NSMutableDictionary *instrumentAccountCfgMap;
    NSMutableDictionary *quoteMap;
    NSMutableDictionary *tradeEnableMap;
    long long orderID;
    long long ticketID;
    
    NSObject *instrumentLock;
    NSObject *instrumentGroupCfgLock;
    NSObject *instrumentAccountCfgLock;
    NSObject *quoteLock;
    NSObject *lock_for_IDs;
}

@end

@implementation SystemDocCaptain

- (id)init{
    if (self = [super init]) {
        basicCurrencyMap = [[NSMutableDictionary alloc] init];
        systemConfig = nil;
        interestRateMap = [[NSMutableDictionary alloc] init];
        interestAddTypeMap = [[NSMutableDictionary alloc] init];
        holidays4CcySetMap = [[NSMutableDictionary alloc] init];
        notValueDay4InstSetMap = [[NSMutableDictionary alloc] init];
        valueDay4InstSetMap = [[NSMutableDictionary alloc] init];
        instrumentMap = [[NSMutableDictionary alloc] init];
        instrumentList = [[NSMutableArray alloc] init];
        exchangeName2InstrumentNameMap = [[NSMutableDictionary alloc] init];
        instrumentGroupCfgMap = [[NSMutableDictionary alloc] init];
        instrumentAccountCfgMap = [[NSMutableDictionary alloc] init];
        quoteMap = [[NSMutableDictionary alloc] init];
        tradeEnableMap = [[NSMutableDictionary alloc] init];
        orderID = 0;
        ticketID = 0;
        
        instrumentLock = [[NSObject alloc] init];
        instrumentGroupCfgLock = [[NSObject alloc] init];
        instrumentAccountCfgLock = [[NSObject alloc] init];
        quoteLock = [[NSObject alloc] init];
        lock_for_IDs = [[NSObject alloc] init];
        
    }
    return self;
}

#pragma BasicCurrency
- (void)resetBasicCurrencys:(NSArray *)basicCurrencyArray{
    @synchronized(basicCurrencyMap){
        [basicCurrencyMap removeAllObjects];
        for (BasicCurrency *bc in basicCurrencyArray) {
            [basicCurrencyMap setObject:bc forKey:[bc  getCurrencyName]];
        }
    }
}

- (void)addBasicCurrency:(BasicCurrency *)bc{
    @synchronized(basicCurrencyMap){
        [basicCurrencyMap setObject:bc forKey:[bc getCurrencyName]];
    }
}

- (BasicCurrency *)getBasicCurrency:(NSString *)currencyName{
    @synchronized(basicCurrencyMap){
        return [basicCurrencyMap objectForKey:currencyName];
    }
}
- (NSArray *)getBasicCurrencyArray{
    @synchronized(basicCurrencyMap){
        return [basicCurrencyMap allValues];
    }
}

#pragma SystemConfig
@synthesize systemConfig;
- (NSString *)getSystemBasicCurrency{
    return [systemConfig getBatchCurrency];
}

- (Boolean)isSystemOpened{
    return [systemConfig getCloseStatus] == CLOSESTATUS_OPEN;
}

#pragma InterestRate
- (void)resetInterestRate:(NSArray *)irv{
    @synchronized(interestRateMap){
        [interestRateMap removeAllObjects];
        for (InterestRate *ir in irv) {
            [interestRateMap setObject:ir forKey:[ir getCurrencyName]];
        }
    }
}

- (void)addInterestRate:(InterestRate *)ir{
    @synchronized(interestRateMap){
        [interestRateMap setObject:ir forKey:[ir getCurrencyName]];
    }
}

- (InterestRate *)getInterestRate:(NSString *)ccy{
    @synchronized(interestRateMap){
        return [interestRateMap objectForKey:ccy];
    }
}

#pragma InterestAddType
- (void)resetInterestAddType:(NSArray *)iatArray{
    @synchronized(interestAddTypeMap){
        [interestAddTypeMap removeAllObjects];
        for (InterestAddType *iat in iatArray) {
            [self addInterestAddType:iat];
        }
    }
}

- (void)addInterestAddType:(InterestAddType *)iat{
    @synchronized(interestAddTypeMap){
        NSMutableDictionary *map = nil;
        if ([[interestAddTypeMap allKeys] containsObject:[iat getTypeId]]) {
            map = [interestAddTypeMap objectForKey:[iat getTypeId]];
        } else {
            map = [[NSMutableDictionary alloc] init];
            [interestAddTypeMap setObject:map forKey:[iat getTypeId]];
        }
        [map setObject:iat forKey:[iat getCurrencyName]];
    }
}

- (InterestAddType *)getInterestAddType:(NSString *)ccy :(NSString *)typeID{
    @synchronized(interestAddTypeMap){
        if ([[interestAddTypeMap allKeys] containsObject:typeID]) {
            return [[interestAddTypeMap objectForKey:typeID] objectForKey:ccy];
        }
        return nil;
    }
}

- (NSArray *)getInterestAddTypes{
    @synchronized(interestAddTypeMap){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *map in interestAddTypeMap) {
            [array addObjectsFromArray:[map allValues]];
        }
        return array;
    }
}

#pragma CDS_InterestRate4Ccy
- (CDS_InterestRate4Ccy *)getCDS_InterestRate4Ccy:(NSString *)ccy :(NSString *)typeID4Group :(NSString *)typeID4Acount{
    InterestRate *ir = [self getInterestRate:ccy];
    if (ir == nil) {
        return  nil;
    }
    CDS_InterestRate4Ccy *cds = [[CDS_InterestRate4Ccy alloc] init];
    [cds setCurrency:ccy];
    [cds setTypeID4Group:typeID4Group];
    [cds setTypeID4Account:typeID4Acount];
    [cds setBuy_cost:[ir getBankCostBid]];
    [cds setBuy_sys:[ir getCustomerCostBid]];
    [cds setSell_cost:[ir getBankCostOffer]];
    [cds setSell_sys:[ir getCustomerCostOffer]];
    InterestAddType *iat_group = [self getInterestAddType:ccy :typeID4Group];
    if (iat_group != nil) {
        [cds setBuy_add_group:[iat_group getInterestBuyAdd]];
        [cds setSell_add_group:[iat_group getInterestSellAdd]];
    }
    InterestAddType *iat_account = [self getInterestAddType:ccy :typeID4Acount];
    if (iat_group != nil) {
        [cds setBuy_add_account:[iat_account getInterestBuyAdd]];
        [cds setSell_add_account:[iat_account getInterestSellAdd]];
    }
    return cds;
}

#pragma Holidays4CCy
- (void)resetHolidays4Ccy:(NSArray *)h4cArray{
    @synchronized(holidays4CcySetMap){
        [holidays4CcySetMap removeAllObjects];
        for (Holidays4ccy *h4c in h4cArray) {
            NSMutableArray *set = nil;
            if ([[holidays4CcySetMap allKeys] containsObject:[h4c getHdatetime]]) {
                set = [holidays4CcySetMap objectForKey:[h4c getHdatetime]];
            } else {
                set = [[NSMutableArray alloc] init];
                [holidays4CcySetMap setObject:set forKey:[h4c getHdatetime]];
            }
            NSArray *ss = [[h4c getCurrencynames] componentsSeparatedByString:@";"];
            [set addObjectsFromArray:ss];
        }
    }
}

- (Boolean)isHoliday4Ccy:(NSString *)ccy :(NSString *)tradeDay{
    @synchronized(holidays4CcySetMap){
        if (![[holidays4CcySetMap allKeys] containsObject:tradeDay]) {
            return false;
        }
        return [[[holidays4CcySetMap objectForKey:tradeDay] allKeys] containsObject:ccy];
    }
}

#pragma NotValueDay4Inst
- (void)resetNotValueDay4Inst:(NSArray *)nvd4InstArray{
    @synchronized(notValueDay4InstSetMap){
        [notValueDay4InstSetMap removeAllObjects];
        for (NotValueDay4Inst *nvd in nvd4InstArray) {
            NSMutableArray *set = nil;
            if ([[notValueDay4InstSetMap allKeys] containsObject:[nvd getHdatetime]]) {
                set = [notValueDay4InstSetMap objectForKey:[nvd getHdatetime]];
            } else {
                set = [[NSMutableArray alloc] init];
                [notValueDay4InstSetMap setObject:set forKey:[nvd getHdatetime]];
            }
            NSArray *ss = [[nvd getInstruments] componentsSeparatedByString:@";"];
            [set addObjectsFromArray:ss];
        }
    }
}

- (Boolean)isHoliday4Instrument:(NSString *)inst :(NSString *)tradeDay{
    @synchronized(notValueDay4InstSetMap){
        if (![[notValueDay4InstSetMap allKeys] containsObject:tradeDay]) {
            return false;
        }
        return [[[notValueDay4InstSetMap objectForKey:tradeDay] allKeys] containsObject:inst];
    }
}

#pragma ValueDay4Inst
- (void)resetValueDay4Inst:(NSArray *)vdsArray{
    @synchronized(valueDay4InstSetMap){
        [valueDay4InstSetMap removeAllObjects];
        for (ValueDaySetting *vds in vdsArray) {
            NSMutableDictionary *map = nil;
            if ([[valueDay4InstSetMap allKeys] containsObject:[vds getTradeDay]]) {
                map = [valueDay4InstSetMap objectForKey:[vds getTradeDay]];
            } else {
                map = [[NSMutableDictionary alloc] init];
                [valueDay4InstSetMap setObject:map forKey:[vds getTradeDay]];
            }
            [map setObject:vds forKey:[vds getInstrument]];
        }
    }
}

- (ValueDaySetting *)getValueDay4InstrumentTradeDay:(NSString *)inst :(NSString *)tradeDay{
    @synchronized(valueDay4InstSetMap){
        if (![[valueDay4InstSetMap allKeys] containsObject:tradeDay]) {
            return nil;
        }
        return [[valueDay4InstSetMap objectForKey:tradeDay] objectForKey:inst];
    }
}

#pragma Instrument
- (void)resetInstruments:(NSArray *)instArray{
    @synchronized(instrumentLock){
        [instrumentMap removeAllObjects];
        [instrumentList removeAllObjects];
        for (Instrument *instrument in instArray) {
            [instrumentMap setObject:instrument forKey:[instrument getInstrument]];
            [instrumentList addObject:instrument];
            /////exchangeUtil
            NSString *key = [ExchangeUtil getExchangeUtilName:[instrument getCcy1] :[instrument getCcy2]];
            [exchangeName2InstrumentNameMap setObject:[instrument getInstrument] forKey:key];
        }
    }
}

- (void)setInstrument:(Instrument *)instrument{
    @synchronized(instrumentLock){
        [instrumentMap setObject:instrument forKey:[instrument getInstrument]];
        //        for (Instrument *temp in instrumentList) {
        for (int i = 0; i < instrumentList.count; i++) {
            Instrument *tempInst = [instrumentList objectAtIndex:i];
            if ([[[tempInst getInstrument] uppercaseString] isEqualToString:[[instrument getInstrument] uppercaseString]]) {
                [instrumentList insertObject:tempInst atIndex:i];
                return;
            }
        }
        [instrumentList addObject:instrument];
        NSString *key = [ExchangeUtil getExchangeUtilName:[instrument getCcy1] :[instrument getCcy2]];
        [exchangeName2InstrumentNameMap setObject:[instrument getInstrument] forKey:key];
    }
    //    }
}

- (Instrument *)getInstrument:(NSString *)instrumentName{
    @synchronized(instrumentLock){
        return [instrumentMap objectForKey:instrumentName];
    }
}

- (NSArray *)getInstrumentArray{
    @synchronized(instrumentLock){
        return instrumentList;
    }
}

- (NSString *)getInstrumentName4Exchange:(NSString *)exchangeName{
    return [exchangeName2InstrumentNameMap objectForKey:exchangeName];
}

#pragma InstrumenGroupCfg
- (void)resetInstrumentGroupCfg:(NSArray *)igcArray{
    @synchronized(instrumentGroupCfgLock){
        [instrumentGroupCfgMap removeAllObjects];
        for (InstrumentsGroupCfg *igc in igcArray) {
            [self setInstrumentGroupCfg:igc];
        }
    }
}

- (void)resetInstrumentGroupCfg:(NSString *)groupName :(NSArray *)igcArray{
    @synchronized(instrumentGroupCfgLock){
        [instrumentGroupCfgMap removeObjectForKey:groupName];
        for (InstrumentsGroupCfg *igc in igcArray) {
            [self setInstrumentGroupCfg:igc];
        }
    }
}

- (void)setInstrumentGroupCfg:(InstrumentsGroupCfg *)igc{
    @synchronized(instrumentGroupCfgLock){
        NSMutableDictionary *map = nil;
        if ([[instrumentGroupCfgMap allKeys] containsObject:[igc getGroupName]]) {
            map = [instrumentGroupCfgMap objectForKey:[igc getGroupName]];
        } else {
            map = [[NSMutableDictionary alloc] init];
            [instrumentGroupCfgMap setObject:map forKey:[igc getGroupName]];
        }
        [map setObject:igc forKey:[igc getInstrument]];
    }
}

- (InstrumentsGroupCfg *)getInstrumentsGroupCfg:(NSString *)group :(NSString *)instrument{
    @synchronized(instrumentGroupCfgLock){
        if (![[instrumentGroupCfgMap allKeys] containsObject:group]) {
            return nil;
        }
        
        return [[instrumentGroupCfgMap objectForKey:group] objectForKey:instrument];
    }
}

- (NSArray *)getInstrumentsGroupCfg:(NSString *)group{
    @synchronized(instrumentGroupCfgLock){
        if (![[instrumentGroupCfgMap allKeys] containsObject:group]) {
            return [[NSArray alloc] initWithObjects:[[Instrument alloc] init], nil];
        }
        return [[instrumentGroupCfgMap objectForKey:group] allValues];
    }
}

#pragma InstrumentAccountCfg
- (void)resetInstrumentAccountCfg:(NSArray *)iccArray{
    @synchronized(instrumentAccountCfgLock){
        [instrumentAccountCfgMap removeAllObjects];
        for (InstrumentsAccountCfg* icc in iccArray) {
            [self setInstrumentAccountCfg:icc];
        }
    }
}

- (void)resetInstrumentAccountCfg:(long long)accountID :(NSArray *)iccArray{
    @synchronized(instrumentAccountCfgLock){
        [instrumentAccountCfgMap removeObjectForKey:[@(accountID) stringValue]];
        for (InstrumentsAccountCfg* icc in iccArray) {
            [self setInstrumentAccountCfg:icc];
        }
    }
}

- (void)setInstrumentAccountCfg:(InstrumentsAccountCfg *)icc{
    @synchronized(instrumentAccountCfgLock){
        NSMutableDictionary *map = nil;
        NSString *key = [NSString stringWithFormat:@"%lld", [icc getAccount]];
        if ([[instrumentAccountCfgMap allKeys] containsObject:key]) {
            map = [instrumentAccountCfgMap objectForKey:key];
        } else {
            map = [[NSMutableDictionary alloc] init];
            [instrumentAccountCfgMap setObject:map forKey:key];
        }
        [map setObject:icc forKey:[icc getInstrument]];
    }
}

- (void)removeInstrumentAccountCfg:(long long)accountID{
    @synchronized(instrumentAccountCfgLock){
        [instrumentAccountCfgMap removeObjectForKey:[@(accountID) stringValue]];
    }
}

- (InstrumentsAccountCfg *)getInstrumentsAccountCfg:(long long)accountID :(NSString *)instrument{
    
    @synchronized (instrumentAccountCfgLock) {
        NSString *key = [@(accountID) stringValue];
        if (![[instrumentAccountCfgMap allKeys] containsObject:key]) {
            return nil;
        }
        return [[instrumentAccountCfgMap objectForKey:key] objectForKey:instrument];
    }
}

- (NSArray *)getInstrumentsAccountCfg:(long long)accountID{
    @synchronized (instrumentAccountCfgLock) {
        NSString *key = [NSString stringWithFormat:@"%lld", accountID];
        if (![[instrumentAccountCfgMap allKeys] containsObject:key]) {
            return [[NSMutableArray alloc] initWithObjects:[[InstrumentsAccountCfg alloc] init], nil];
        }
        return [[instrumentAccountCfgMap objectForKey:key] allValues];
    }
}

#pragma Quote
- (QuoteData *)getQuote:(NSString *)instrumentName{
    @synchronized (quoteLock) {
        return [quoteMap objectForKey:instrumentName];
    }
}

- (void)setQuote:(QuoteData *)quote{
    @synchronized (quoteLock) {
        if ([quote getTradeable] && ![quote getClose]) {
            Instrument *inst = [instrumentMap objectForKey:[quote getInstrument]];
            if (inst != nil) {
                [quoteMap setObject:quote forKey:[quote getInstrument]];
                [self setQuoteTradeEnable:[quote getInstrument] :true];
            }
        } else {
            [self setQuoteTradeEnable:[quote getInstrument] :false];
        }
        [quoteMap setObject:quote forKey:[quote getInstrument]];
    }
}

- (void)resetQuote:(NSArray *)quoteArray{
    @synchronized (quoteLock) {
        [quoteMap removeAllObjects];
        for (QuoteData *quote in quoteArray) {
            [self setQuote:quote];
        }
    }
}

- (Boolean)isQuoteTradableIgnoreQuoteEnable:(NSString *)instrument{
    Instrument *inst = [instrumentMap objectForKey:instrument];
    if (inst == nil) {
        return false;
    }
    
    if ([inst getTradeable] != TRUE) {
        return false;
    }
    return true;
}

- (NSArray *)getBalanceRateVec{
    
    NSArray *instrumentArray = [self getInstrumentArray];
    NSMutableArray *balanceRateArray = [[NSMutableArray alloc] init];
    for (Instrument *instrument in instrumentArray) {
        QuoteData *quote = [self getQuote:[instrument getInstrument]];
        if (quote == nil) {
            continue;
        }
        if ([self getBasicCurrency:[instrument getCcy1]] != nil) {
            BalanceRate *balanceRate = [[BalanceRate alloc] init];
            [balanceRate setInstrument:[instrument getInstrument]];
            [balanceRate setCur1:[instrument getCcy1]];
            [balanceRate setCur2:[instrument getCcy2]];
            [balanceRate setTradeDay:[systemConfig getTradeDay]];
            [balanceRate setAsk:[quote getAsk]];
            [balanceRate setBid:[quote getBid]];
            [balanceRateArray addObject:balanceRate];
        }
    }
    return balanceRateArray;
}

- (void)disableQuoteTradeAbility_all{
    NSArray *insArray = [self getInstrumentArray];
    for (Instrument *inst in insArray) {
        [self setQuoteTradeEnable:[inst getInstrument] :false];
    }
}

- (void)disableQuoteTradeAbility_instrument:(NSString *)instrument{
    [self setQuoteTradeEnable:instrument :false];
}

- (void)setQuoteTradeEnable:(NSString *)instrument :(Boolean)flag{
    @synchronized(quoteLock){
        [tradeEnableMap setObject:[NSString stringWithFormat:@"%hhu", flag] forKey:instrument];
    }
}

- (Boolean)isQuoteTradable:(NSString *)instrument{
    if (![self isQuoteTradable:instrument]) {
        return false;
    }
    
    @synchronized(quoteLock){
        NSString *flag  = [tradeEnableMap objectForKey:instrument];
        return flag != nil && [flag isEqualToString:@"1"];
    }
}

- (long long)getNextOrderID{
    @synchronized (lock_for_IDs) {
        if (orderID < 1000) {
            orderID = (long) (random() * 1000) + 98654;
            return orderID;
        } else {
            return ++orderID;
        }
    }
}

- (void)setOrderID:(long long)_orderID{
    @synchronized (lock_for_IDs) {
        orderID = _orderID + 50;
    }
}

- (long long)getNextTicketID{
    @synchronized (lock_for_IDs) {
        if (ticketID < 1000) {
            ticketID = (long) (random() * 1000) + 98654;
            return ticketID;
        } else {
            return ++ticketID;
        }
    }
}

- (void)setTicketID:(long long)_ticketID{
    @synchronized (lock_for_IDs) {
        ticketID = (long long)(_ticketID + 50);
    }
}

@end
