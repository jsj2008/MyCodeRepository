//
//  InfoOperator_TRADESERV1010.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1010.h"

#import "Info_TRADESERV1010.h"
#import "APIDoc.h"
#import "APIDocCaptain.h"
#import "API_IDEventCaptain.h"

@implementation InfoOperator_TRADESERV1010

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1010 *tinfo = (Info_TRADESERV1010 *)info;
    if ([[APIDoc getUserDocCaptain] getCDS_AccountStore:[tinfo getAccountID]] == nil) {
        return;
    }
    
    if ([tinfo getMoneyAccount] != nil) {
        [[APIDoc getUserDocCaptain] setMoneyAccount:[tinfo getMoneyAccount]];
    }
    
    if ([tinfo getOrderVec] != nil) {
        [[APIDoc getUserDocCaptain] resetOrderByAccount:[tinfo getAccountID]
                                            TOrderArray:[tinfo getOrderVec]];
    }
    
    if ([tinfo getTradeVec] != nil) {
        [[APIDoc getUserDocCaptain] resetTradeByAccount:[tinfo getAccountID]
                                                 Trades:[tinfo getTradeVec]];
    }
    
    if ([APIDoc isInited]) {
        JEDI_SYS_Try {
            [[APIDoc getFixUtil] fixAccount:[[APIDoc getUserDocCaptain] getCDS_AccountStore:[tinfo getAccountID]]
                            ForceToScanTrde:true];
        } JEDI_SYS_EndTry
    }
    
    if ([tinfo getTsettledVec] != nil && [[tinfo getTsettledVec] count] > 0) {
        [APIDocCaptain addSettle:[tinfo getTsettledVec]];
        // 消息通知
        [API_IDEventCaptain fireEventChanged:NAME_NAME_ON_TSETTLED4CFD_CHANGED eventData:nil];
    }
    
    [API_IDEventCaptain fireEventChanged:DATA_ON_MoneyAccount_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    [API_IDEventCaptain fireEventChanged:DATA_ON_Trade_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    [API_IDEventCaptain fireEventChanged:DATA_ON_Order_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    if ([[[tinfo getTradeOperatorID] uppercaseString] isEqualToString:@"TRADESERV5202"] && [tinfo getOrderHis] != nil) {
        [API_IDEventCaptain fireEventChanged:DATA_ON_Order_Trade eventData:[@([[tinfo getOrderHis] getOrderID]) stringValue]];
    }
    
}

@end
