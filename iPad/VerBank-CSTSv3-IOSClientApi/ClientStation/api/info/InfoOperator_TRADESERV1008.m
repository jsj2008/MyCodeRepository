//
//  InfoOperator_TRADESERV1008.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1008.h"

#import "Info_TRADESERV1008.h"
#import "APIDoc.h"
#import "UserDocOperator.h"

@implementation InfoOperator_TRADESERV1008

- (void) onInfo:(InfoFather *)info {
    Info_TRADESERV1008 *tinfo = (Info_TRADESERV1008 *)info;
    if ([tinfo getAttrID] == ATTR_TRANSFER_WITH_FUND) {
        [self infoWithFund:[tinfo getAccountID]];
    }
}

- (void)infoWithFund:(long long)account {
    if ([[APIDoc getUserDocCaptain] getCDS_AccountStore:account] == nil) {
        return;
    }
    
    [[UserDocOperator getInstance] loadMoneyAccount:account];
}

@end
