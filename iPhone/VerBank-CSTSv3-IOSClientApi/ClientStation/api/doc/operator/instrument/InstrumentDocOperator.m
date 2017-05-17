//
//  InstrumentDocOperator.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InstrumentDocOperator.h"

#import "IP_TRADESERV5013.h"
#import "OP_TRADESERV5013.h"

#import "IP_QG1001.h"
#import "OP_QG1001.h"

#import "IP_TRADESERV5020.h"
#import "OP_TRADESERV5020.h"

#import "IP_TRADESERV5021.h"
#import "OP_TRADESERV5021.h"

#import "CSTSCaptain.h"
#import "APIDoc.h"
#import "QuoteDataStore.h"

static InstrumentDocOperator *instrumentDocOperator = nil;

@implementation InstrumentDocOperator

+ (InstrumentDocOperator *)getInstance{
    if (instrumentDocOperator == nil) {
        instrumentDocOperator = [[InstrumentDocOperator alloc] init];
    }
    return instrumentDocOperator;
}

- (Boolean)loadInstruments{
//    ListenerCaptain.getApiDataEventListener().onLoadInstruments(APIDataEventListener.STATE_START);
    IP_TRADESERV5013 *ip = [[IP_TRADESERV5013 alloc] init];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadInstruments(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5013 *op = (OP_TRADESERV5013 *)opFather;
    [[APIDoc getSystemDocCaptain] resetInstruments:[op getInstrument]];
    
//    ListenerCaptain.getApiDataEventListener().onLoadInstruments(APIDataEventListener.STATE_SUCCEED);
//    ListenerCaptain.getApiDataChangeListener().onInstrumentChanged(null);
    [API_IDEventCaptain fireEventChanged:DATA_ON_Instrument_Changed eventData:nil];
    return true;
}

- (Boolean)loadInstruments:(NSString *)instrument{
//    ListenerCaptain.getApiDataEventListener().onLoadInstruments(APIDataEventListener.STATE_START);
    IP_TRADESERV5013 *ip = [[IP_TRADESERV5013 alloc] init];
    [ip setInstrument:instrument];
    
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadInstruments(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5013 *op = (OP_TRADESERV5013 *)opFather;
//    [[APIDoc getSystemDocCaptain] resetInstruments:[op getInstrument]];
    [[APIDoc getSystemDocCaptain] setInstrument:[[op getInstrument] objectAtIndex:0]];
    
//    ListenerCaptain.getApiDataEventListener().onLoadInstruments(APIDataEventListener.STATE_SUCCEED);
//    ListenerCaptain.getApiDataChangeListener().onInstrumentChanged(null);
    [API_IDEventCaptain fireEventChanged:DATA_ON_Instrument_Changed eventData:instrument];
    return true;
}

- (Boolean)loadQuoteTable:(NSArray *)instrumentArray{
    
    IP_QG1001 *ip = [[IP_QG1001 alloc] init];
    if (instrumentArray != nil) {
        [ip setSearchType:SEARCH_TYPE_INSTRUMENTVECTOR];
        [ip setInstruments:instrumentArray];
    } else {
        [ip setSearchType:SEARCH_TYPE_ALL];
    }
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
        return false;
    }
    OP_QG1001 *top = (OP_QG1001 *)opFather;
    if ([top getQuoteArray] != nil) {
        NSMutableArray *quoteArray = [top getQuoteArray];
        [[APIDoc getSystemDocCaptain] resetQuote:quoteArray];
    }
    
    return true;
}

- (Boolean)loadInstrumentsGroupCfg:(NSString *)groupName{
//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(APIDataEventListener.STATE_START);
    
    IP_TRADESERV5020 *ip = [[IP_TRADESERV5020 alloc] init];
    [ip setGroupName:groupName];
    [ip setIsToQuerryAll:true];
    
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5020 *op = (OP_TRADESERV5020 *)opFather;
    [[APIDoc getSystemDocCaptain] resetInstrumentGroupCfg:groupName :[op getInstrumentGroupCfgArray]];

//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(APIDataEventListener.STATE_SUCCEED);
//    ListenerCaptain.getApiDataChangeListener().onInstrumentGroupCfgChanged(groupName, null);
    [API_IDEventCaptain fireEventChanged:DATA_ON_InstrumentGroupCfg_Changed eventData:groupName];
    return true;
}

- (Boolean)loadInstrumentsAccountCfg:(long long)accountID{
//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(APIDataEventListener.STATE_START);
    IP_TRADESERV5021 *ip = [[IP_TRADESERV5021 alloc] init];
    [ip setAccountID:accountID];
    [ip setIsToQueryAll:true];
    
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5021 *op = (OP_TRADESERV5021 *)opFather;
    [[APIDoc getSystemDocCaptain] resetInstrumentAccountCfg:accountID :[op getInstrumentsAccountCfgArray]];
    
//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(APIDataEventListener.STATE_SUCCEED);
//    ListenerCaptain.getApiDataChangeListener().onInstrumentAccountCfgChanged(new Long(accountID), null);
    [API_IDEventCaptain fireEventChanged:DATA_ON_InstrumentAccountCfg_Changed eventData:[@(accountID)stringValue]];
    return true;
}

- (Boolean)loadInstrumentsGroupCfg:(NSString *)groupName
                        instrument:(NSString *)instrument{
//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(APIDataEventListener.STATE_START);
    IP_TRADESERV5020 *ip = [[IP_TRADESERV5020 alloc] init];
    [ip setGroupName:groupName];
    [ip setInstrument:instrument];
    [ip setIsToQuerryAll:false];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5020 *op = (OP_TRADESERV5020 *)opFather;
    [[APIDoc getSystemDocCaptain] setInstrumentGroupCfg:[op getInstrumentGroupCfg]];

//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(APIDataEventListener.STATE_SUCCEED);
//    ListenerCaptain.getApiDataChangeListener().onInstrumentGroupCfgChanged(groupName, instrument);
    [API_IDEventCaptain fireEventChanged:DATA_ON_InstrumentGroupCfg_Changed eventData:groupName];
    
    return true;
}

- (Boolean)loadInstrumentsAccountCfg:(long long)accountID
                          instrument:(NSString *)instrument{
//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(APIDataEventListener.STATE_START);
    IP_TRADESERV5021 *ip = [[IP_TRADESERV5021 alloc] init];
    [ip setAccountID:accountID];
    [ip setInstrumentName:instrument];
    [ip setIsToQueryAll:false];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//         ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5021 *op = (OP_TRADESERV5021 *)opFather;
    [[APIDoc getSystemDocCaptain] setInstrumentAccountCfg:[op getInstrumentsAccountCfg]];

//    ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(APIDataEventListener.STATE_SUCCEED);
//    ListenerCaptain.getApiDataChangeListener().onInstrumentAccountCfgChanged(new Long(accountID), instrument);
    [API_IDEventCaptain fireEventChanged:DATA_ON_InstrumentAccountCfg_Changed eventData:[@(accountID)stringValue]];
    return true;
}

@end
