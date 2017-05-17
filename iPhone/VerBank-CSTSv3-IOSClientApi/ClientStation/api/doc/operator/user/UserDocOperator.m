//
//  UserDocOperator.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "UserDocOperator.h"
#import "IP_TRADESERV5018.h"
#import "OP_TRADESERV5018.h"

#import "IP_TRADESERV5017.h"
#import "OP_TRADESERV5017.h"

#import "IP_TRADESERV5019.h"
#import "OP_TRADESERV5019.h"

#import "IP_TRADESERV5022.h"
#import "OP_TRADESERV5022.h"

#import "IP_TRADESERV5024.h"
#import "OP_TRADESERV5024.h"

#import "IP_TRADESERV5025.h"
#import "OP_TRADESERV5025.h"

#import "CSTSCaptain.h"
#import "APIDoc.h"

static UserDocOperator *userDocOperator = nil;

@implementation UserDocOperator

+ (UserDocOperator *)getInstance{
    if (userDocOperator == nil) {
        userDocOperator = [[UserDocOperator alloc] init];
    }
    return userDocOperator;
}

- (Boolean)loadUserLogin:(NSString *)aeid{
//        ListenerCaptain.getApiDataEventListener().onLoadUserLogin(APIDataEventListener.STATE_START);
    
    IP_TRADESERV5018 *ip = [[IP_TRADESERV5018 alloc] init];
    [ip setUserName:aeid];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadUserLogin(APIDataEventListener.STATE_FAILED);
        return false;
    }
    
    OP_TRADESERV5018 *op = (OP_TRADESERV5018 *)opFather;
    [[APIDoc getUserDocCaptain] addUserLogin:[op getUserLogin]];
    
//    ListenerCaptain.getApiDataEventListener().onLoadUserLogin(APIDataEventListener.STATE_SUCCEED);
    return true;
}

- (Boolean)loadGroupConfig:(NSString *)groupName{
//        ListenerCaptain.getApiDataEventListener().onLoadGroupConfig(APIDataEventListener.STATE_START);
    
    IP_TRADESERV5017 *ip = [[IP_TRADESERV5017 alloc] init];
    [ip setGroupName:groupName];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadGroupConfig(APIDataEventListener.STATE_FAILED);
        return false;
    }

    OP_TRADESERV5017 *op = (OP_TRADESERV5017 *)opFather;
    [[APIDoc getUserDocCaptain] addGroups:[op getGroupConfigArray]];
    
//        ListenerCaptain.getApiDataEventListener().onLoadGroupConfig(APIDataEventListener.STATE_SUCCEED);
    return true;
}

- (Boolean)loadAccountStrategy:(long long)accountID{
    return [self loadAccountStrategyWitAccountID:accountID aeid:nil];
}

- (Boolean)loadAccountStrategyWitAccountID:(long long)accountID aeid:(NSString *)aeid{
//        ListenerCaptain.getApiDataEventListener().onLoadAccountStrategy(APIDataEventListener.STATE_START);
    
    IP_TRADESERV5019 *ip = [[IP_TRADESERV5019 alloc] init];
    [ip setAccountID:accountID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadAccountStrategy(APIDataEventListener.STATE_FAILED);
        return false;
    }
    
    OP_TRADESERV5019 *op = (OP_TRADESERV5019 *)opFather;
    AccountStrategy *accountStrategy = [op getAccountStrategy];
    if (aeid != nil && (![[accountStrategy getAeid] isEqualToString:aeid])) {
        return false;
    }
    [[APIDoc getUserDocCaptain] setAccountStrategy:[op getAccountStrategy]];
    
//        ListenerCaptain.getApiDataEventListener().onLoadAccountStrategy(APIDataEventListener.STATE_SUCCEED);
    return true;
}

- (Boolean)loadMoneyAccount:(long long)accountID{
//        ListenerCaptain.getApiDataEventListener().onLoadMoneyAccount(APIDataEventListener.STATE_START);
    IP_TRADESERV5022 *ip = [[IP_TRADESERV5022 alloc] init];
    [ip setAccountID:accountID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadMoneyAccount(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5022 *op = (OP_TRADESERV5022 *)opFather;
    [[APIDoc getUserDocCaptain] setMoneyAccount:[op getMoneyAccount]];
    if ([APIDoc isInited]) {
        JEDI_SYS_Try {
            [[APIDoc getFixUtil] fixAccount:[[APIDoc getUserDocCaptain] getCDS_AccountStore:accountID]
                            ForceToScanTrde:true];
        }JEDI_SYS_EndTry
    }

//        ListenerCaptain.getApiDataEventListener().onLoadMoneyAccount(APIDataEventListener.STATE_SUCCEED);
//        ListenerCaptain.getApiDataChangeListener().onMoneyAccountChanged(new Long(accountID));
    NSString *account  = [NSString stringWithFormat:@"%lld", accountID];
    [API_IDEventCaptain fireEventChanged:DATA_ON_MoneyAccount_Changed eventData:account];
        return true;
}

- (Boolean)loadTrade4CFD:(long long)accountID{
//        ListenerCaptain.getApiDataEventListener().onLoadTrade4CFD(APIDataEventListener.STATE_START);
    IP_TRADESERV5024 *ip = [[IP_TRADESERV5024 alloc] init];
    [ip setAccountID:accountID];
    OPFather *opFather = [[CSTSCaptain getInstance]trade:ip];
    if (![opFather isSuccessed]) {
//        ListenerCaptain.getApiDataEventListener().onLoadTrade4CFD(APIDataEventListener.STATE_FAILED);
        return false;
    }
    OP_TRADESERV5024 *op = (OP_TRADESERV5024 *)opFather;
    [[APIDoc getUserDocCaptain] resetTradeByAccount:accountID Trades:[op getTTradeArray]];
    
    if ([APIDoc isInited]) {
        JEDI_SYS_Try{
            [[APIDoc getFixUtil] fixAccount:[[APIDoc getUserDocCaptain] getCDS_AccountStore:accountID]
                            ForceToScanTrde:true];
        }JEDI_SYS_EndTry
    }
//        ListenerCaptain.getApiDataEventListener().onLoadTrade4CFD(APIDataEventListener.STATE_SUCCEED);
//        API_IDEventCaptain.getInstance().fireEventChanged(new API_IDEvent(API_IDEvent_NameInterface.DATA_ON_Trade_Changed, new Long[] { accountID }, true, ""));
//        ListenerCaptain.getApiDataChangeListener().onTradeChanged(new Long(accountID));
    NSString *account = [NSString stringWithFormat:@"%lld", accountID];
    [API_IDEventCaptain fireEventChanged:DATA_ON_Trade_Changed eventData:account];
        return true;
}

- (Boolean)loadOrder4CFD:(long long)accountID{
//        ListenerCaptain.getApiDataEventListener().onLoadOrder4CFD(APIDataEventListener.STATE_START);
    IP_TRADESERV5025 *ip = [[IP_TRADESERV5025 alloc] init];
    [ip setAccountID:accountID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if (![opFather isSuccessed]) {
        return false;
    }
    OP_TRADESERV5025 *op = (OP_TRADESERV5025 *)opFather;
    [[APIDoc getUserDocCaptain] resetOrderByAccount:accountID TOrderArray:[op getTOrderArray]];
    [API_IDEventCaptain fireEventChanged:DATA_ON_Order_Changed eventData:[@(accountID) stringValue]];
    
    return true;
}

@end
