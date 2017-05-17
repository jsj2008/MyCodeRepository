//
//  InfoOperator_TRADESERV1003.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1003.h"
#import "Info_TRADESERV1003.h"

#import "APIDoc.h"
#import "API_IDEventCaptain.h"

@implementation InfoOperator_TRADESERV1003

- (void) onInfo:(InfoFather *)info {
    Info_TRADESERV1003 *tinfo = (Info_TRADESERV1003 *)info;
    
    if ([[APIDoc getUserDocCaptain] getCDS_AccountStore:[tinfo getAccountID]] == nil) {
        return;
    }
    
    [[APIDoc getUserDocCaptain] setMoneyAccount:[tinfo getMoneyAccount]];
    [[APIDoc getUserDocCaptain] resetMargin24Account:[tinfo getAccountID]
                                             Margin2:[tinfo getMargin2Vec]];
    [[APIDoc getUserDocCaptain] resetMoneyAccountFrozen4Account:[tinfo getAccountID]
                                              MoneyAccountArray:[tinfo getFrozenVec]];
    
    if ([APIDoc isInited]) {
        JEDI_SYS_Try {
            [[APIDoc getFixUtil] fixAccountWithAccountID:[tinfo getAccountID]];
        } JEDI_SYS_EndTry
    }
    [API_IDEventCaptain fireEventChanged:DATA_ON_MoneyAccount_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    
}

@end
