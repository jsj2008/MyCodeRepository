//
//  InfoOperator_TRADESERV1012.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1012.h"

#import "Info_TRADESERV1012.h"
#import "APIDoc.h"
#import "API_IDEventCaptain.h"

@implementation InfoOperator_TRADESERV1012

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1012 *tinfo = (Info_TRADESERV1012 *)info;
    if ([[APIDoc getUserDocCaptain] getCDS_AccountStore:[tinfo getAccountID]] == nil) {
        return;
    }
    
    if ([tinfo getToRemoveOrderID] > 0) {
        long long orderID = [tinfo getToRemoveOrderID];
        TOrder *tempOrder = [[APIDoc getUserDocCaptain] getOrder:orderID];
        if ([tempOrder getCorrespondingTicket] > 0) {
            TTrade *tempTrade = [[APIDoc getUserDocCaptain] getTrade:[tempOrder getCorrespondingTicket]];
            if (tempTrade != nil) {
                [tempTrade setCorOrderID:0];
            }
        }
        [[APIDoc getUserDocCaptain] removeOrder:orderID];
    }
    
    if ([tinfo getOrder] != nil) {
        [[APIDoc getUserDocCaptain] addOrder:[tinfo getOrder]];
        if ([[tinfo getOrder] getCorrespondingTicket] > 0) {
            TTrade *tempTrade = [[APIDoc getUserDocCaptain] getTrade:[[tinfo getOrder] getCorrespondingTicket]];
            if (tempTrade != nil) {
                [tempTrade setCorOrderID:[[tinfo getOrder] getOrderID]];
            }
        }
    }
    
    [API_IDEventCaptain fireEventChanged:DATA_ON_Order_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    if ([[tinfo getOrder] getCorrespondingTicket] > 0) {
        [API_IDEventCaptain fireEventChanged:DATA_ON_Trade_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    }
}

@end
