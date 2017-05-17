//
//  DocOperator.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "DocOperator.h"
#import "IP_Ctrl2002.h"
#import "OP_Ctrl2002.h"

#import "IP_TRADESERV5030.h"
#import "OP_TRADESERV5030.h"

#import "IP_TRADESERV5040.h"
#import "OP_TRADESERV5040.h"

#import "IP_TRADESERV5041.h"
#import "OP_TRADESERV5041.h"

#import "CSTSCaptain.h"
#import "APIDocCaptain.h"
#import "APIDoc.h"

#import "InstrumentDocOperator.h"

static DocOperator *docOperator = nil;

@implementation DocOperator

+ (DocOperator *)getInstance{
    if (docOperator == nil) {
        docOperator = [[DocOperator alloc] init];
    }
    return docOperator;
}

- (Boolean)initDoc:(NSLocale *)local
    otherCfgKeyVec:(NSArray *)otherCfgKeyVec{
    
    //加载配置参数
    if (![self loadOtherClientConfigWithKeys:otherCfgKeyVec local:local]) {
        return false;
    }
    
    // 加载系统基本数据
    if (![self loadSystemBasicData]) {
        return false;
    }
    
    // 加载用户信息
    if (![self loadUserData:[[ClientAPI getInstance] aeid]]) {
        return false;
    }
    
    NSArray *asArray = [[APIDoc getUserDocCaptain] getCDS_AccountStoreArray];
    for (CDS_AccountStore *as in asArray) {
        if (![self loadAccountData:[as getAccountID]]) {
            return false;
        }
    }
    
    [APIDoc setInited:true];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    [thread start];
    
    [NSThread sleepForTimeInterval:0.5];
    //    [self runThread];
    
    return true;
}

- (void)runThread{
    
    NSArray *instArray = [[APIDoc getSystemDocCaptain] getInstrumentArray];
    NSMutableArray *instNameArray = [[NSMutableArray alloc] init];
    for (Instrument *inst in instArray) {
        [instNameArray addObject:[inst getInstrument]];
    }
    [self loadQuoteTable:instNameArray];
}

- (void)loadQuoteTable:(NSArray *)instNameVec{
    [[InstrumentDocOperator getInstance] loadQuoteTable:instNameVec];
    [API_IDEventCaptain fireEventChanged:NAME_ON_QUOTELIST_INITED eventData:nil];
}


- (Boolean)resetUserDoc{
    if (![self loadUserData:[[ClientAPI getInstance] aeid]]) {
        return false;
    }
    NSArray *array = [[APIDoc getUserDocCaptain] getCDS_AccountStoreArray];
    for (CDS_AccountStore *as in array) {
        if (![self loadAccountData:[as getAccountID]]) {
            return false;
        }
    }
    return true;
}

- (Boolean)loadUserData:(NSString *)userName{
    //        ListenerCaptain.getApiDataEventListener().onLoadUserBaseData(APIDataEventListener.STATE_START);
    IP_TRADESERV5040 *ip = [[IP_TRADESERV5040 alloc] init];
    [ip setUserName:userName];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
        //        ListenerCaptain.getApiDataEventListener().onLoadUserBaseData(APIDataEventListener.STATE_START);
        return false;
    }
    OP_TRADESERV5040 *op = (OP_TRADESERV5040 *)opFather;
    [[APIDoc getUserDocCaptain] clearAccountByAeid:userName];
    [[APIDoc getUserDocCaptain] addGroups:[op getGroupConfigArray]];
    [[APIDoc getUserDocCaptain] addUserLogin:[op getUserLogin]];
    [[APIDoc getUserDocCaptain] setAccountStrategys:[op getAccountStrategyArray]];
    [[APIDoc getSystemDocCaptain] resetInstrumentGroupCfg:[op getInstrumentGroupCfgArray]];
    [[APIDoc getSystemDocCaptain] resetInstrumentAccountCfg:[op getInstrumentAccountCfgArray]];
    
    //        ListenerCaptain.getApiDataEventListener().onLoadUserBaseData(APIDataEventListener.STATE_SUCCEED);
    return true;
}

- (Boolean)loadAccountData:(long long)accountID{
    //        ListenerCaptain.getApiDataEventListener().onLoadAccountBaseData(APIDataEventListener.STATE_START);
    IP_TRADESERV5041 *ip = [[IP_TRADESERV5041 alloc] init];
    [ip setAccountID:accountID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
        //        ListenerCaptain.getApiDataEventListener().onLoadAccountBaseData(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5041 *op = (OP_TRADESERV5041 *)opFather;
    
    
    [[APIDoc getUserDocCaptain] setMoneyAccount:[op getMoneyAccount]];
    [[APIDoc getUserDocCaptain] resetTradeByAccount:accountID Trades:[op getTradeArray]];
    [[APIDoc getUserDocCaptain] resetOrderByAccount:accountID TOrderArray:[op getOrderArray]];
    [[APIDoc getUserDocCaptain] resetMargin24Account:accountID Margin2:[op getMargin2Array]];
    [[APIDoc getUserDocCaptain] resetMoneyAccountFrozen4Account:accountID MoneyAccountArray:[op getMoneyAccountFrozenArray]];
    
    if ([APIDoc isInited]) {
        [[APIDoc getFixUtil] fixAccount:[[APIDoc getUserDocCaptain] getCDS_AccountStore:accountID] ForceToScanTrde:true];
    }
    
    //        ListenerCaptain.getApiDataEventListener().onLoadAccountBaseData(APIDataEventListener.STATE_SUCCEED);
    [API_IDEventCaptain fireEventChanged:DATA_ON_MoneyAccount_Changed eventData:[@(accountID)stringValue]];
    [API_IDEventCaptain fireEventChanged:DATA_ON_Trade_Changed eventData:[@(accountID)stringValue]];
    [API_IDEventCaptain fireEventChanged:DATA_ON_Order_Changed eventData:[@(accountID)stringValue]];
    return true;
}


#pragma privateFunc
// --------------otherclientconfig---------------
- (Boolean)loadOtherClientConfigWithKeys:(NSArray *)keys
                                   local:(NSLocale *)local{
    
    //    NSString *storeName = @"OCC";
    NSMutableArray *occ = nil;
    IP_Ctrl2002 *ip = [[IP_Ctrl2002 alloc] init];
    //    [ip setDigist:[[NSData alloc] init]];
    [ip setDigist:[[NSString alloc] init]];
    [ip setKeySet:keys];
    [ip setLocale:[local localeIdentifier]];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
        //         ListenerCaptain.getApiDataEventListener().onLoadSystemBaseData(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_Ctrl2002 *op = (OP_Ctrl2002 *)opFather;
    if ([op getIsForceToReNew]) {
        occ = [op getOtherClientConfigArray];
        //         LocaleFileOperator.storeRuntimeData(storeFileName, occ);
    }
    [APIDocCaptain addOtnerClientConfig:occ];
    return true;
}

- (Boolean)loadSystemBasicData{
    //        ListenerCaptain.getApiDataEventListener().onLoadSystemBaseData(APIDataEventListener.STATE_START);
    IP_TRADESERV5030 *ip = [[IP_TRADESERV5030 alloc] init];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
        //        ListenerCaptain.getApiDataEventListener().onLoadSystemBaseData(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5030 *op = (OP_TRADESERV5030 *)opFather;
    [[APIDoc getSystemDocCaptain] resetBasicCurrencys:[op getBasicCurrencyArray]];
    [[APIDoc getSystemDocCaptain] setSystemConfig:[op getSystemConfig]];
    [[APIDoc getSystemDocCaptain] resetInstruments:[op getInstrumentArray]];
    [[APIDoc getSystemDocCaptain] resetInterestAddType:[op getInterestAddType]];
    
    //        ListenerCaptain.getApiDataEventListener().onLoadSystemBaseData(APIDataEventListener.STATE_SUCCEED);
    return true;
}


@end
