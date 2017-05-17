//
//  InfoOperator_TRADESERV1005.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1005.h"

#import "Info_TRADESERV1005.h"
#import "CDS_AccountStore.h"
#import "APIDoc.h"
#import "DocOperator.h"
#import "InstrumentDocOperator.h"
#import "UserDocOperator.h"

@implementation InfoOperator_TRADESERV1005

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1005 *tinfo = (Info_TRADESERV1005 *)info;
    
    int attrID = [tinfo getChangedAttrID];
    switch (attrID) {
        case ATTRID_ACCOUNTSTRATEGY:
            for (CDS_AccountStore *as in [[APIDoc getUserDocCaptain] getCDS_AccountStoreArray]) {
                [[APIDoc getUserDocCaptain] killUserAccount:[as getAccountID]];
            }
            [[DocOperator getInstance] resetUserDoc];
            [APIDoc setInited:true];
            break;
            
        case ATTRID_INSTRUMENTCFG4ACCOUNT:
            if ([[APIDoc getUserDocCaptain] getCDS_AccountStore:[tinfo getAccountID]] == nil) {
                return;
            }
            
            if ([tinfo getInstrumentName] == nil) {
                [[InstrumentDocOperator getInstance] loadInstrumentsAccountCfg:[tinfo getAccountID]];
            } else {
                [[InstrumentDocOperator getInstance] loadInstrumentsAccountCfg:[tinfo getAccountID]
                                                                    instrument:[tinfo getInstrumentName]];
            }
            break;
            
        case ATTRID_INSTRUMENTCFG4GROUP:
            
            if ([[APIDoc getUserDocCaptain] getGroupDoc:[tinfo getGroupName]] == nil) {
                return;
            }
            
            if ([tinfo getInstrumentName] == nil) {
                [[InstrumentDocOperator getInstance] loadInstrumentsGroupCfg:[tinfo getGroupName]];
            } else {
                [[InstrumentDocOperator getInstance] loadInstrumentsGroupCfg:[tinfo getGroupName]
                                                                  instrument:[tinfo getInstrumentName]];
            }
            break;
            
        case ATTRID_USERLOGIN:
            if ([[APIDoc getUserDocCaptain] getUserLogin:[tinfo getAeid]] == nil) {
                return;
            }
            [[UserDocOperator getInstance] loadUserLogin:[tinfo getAeid]];
            break;
            
        case ATTRID_ACCOUNT_DELETE:
            [[APIDoc getUserDocCaptain] killUserAccount:[tinfo getAccountID]];
            break;
            
        default:
            break;
    }
}

@end
