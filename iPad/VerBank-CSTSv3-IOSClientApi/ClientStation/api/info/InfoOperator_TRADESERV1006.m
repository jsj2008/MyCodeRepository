//
//  InfoOperator_TRADESERV1006.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1006.h"

#import "Info_TRADESERV1006.h"
#import "APIDoc.h"
#import "MTP4CommDataInterface.h"
#import "API_IDEventCaptain.h"
#import "DocOperator.h"

@implementation InfoOperator_TRADESERV1006

- (void) onInfo:(InfoFather *)info {
    Info_TRADESERV1006 *tinfo = (Info_TRADESERV1006 *)info;
    
    [[[APIDoc getSystemDocCaptain] systemConfig] setTradeDay:[tinfo getTradeDay]];
    [[[APIDoc getSystemDocCaptain] systemConfig] setCloseStatus:[tinfo getCloseState]];
    
    if ([tinfo getCloseState] == CLOSESTATUS_CLOSE) {
        [API_IDEventCaptain fireEventChanged:OTHER_ON_SYSTEMCLOSE eventData:nil];
        NSArray *asArray = [[APIDoc getUserDocCaptain] getCDS_AccountStoreArray];
        for (CDS_AccountStore *as in asArray) {
            [[DocOperator getInstance] loadAccountData:[as getAccountID]];
        }
    } else {
        [API_IDEventCaptain fireEventChanged:OTHER_ON_SYSTEMOPEN eventData:nil];
        NSArray *asArray = [[APIDoc getUserDocCaptain] getCDS_AccountStoreArray];
        for (CDS_AccountStore *as in asArray) {
            [[DocOperator getInstance] loadAccountData:[as getAccountID]];
        }
        [API_IDEventCaptain fireEventChanged:DATA_ON_Rollover_Changed eventData:nil];
    }
}

@end
