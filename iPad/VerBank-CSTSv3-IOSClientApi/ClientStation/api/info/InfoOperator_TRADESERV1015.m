//
//  InfoOperator_TRADESERV1015.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1015.h"

#import "Info_TRADESERV1015.h"
#import "API_IDEventCaptain.h"
#import "MTP4CommDataInterface.h"
#import "TradeApi.h"

@implementation InfoOperator_TRADESERV1015

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1015 *tinfo = (Info_TRADESERV1015 *)info;
    [API_IDEventCaptain fireEventChanged:DATA_ON_PriceWarning_Reached eventData:[tinfo getPriceWarning]];
    if ([[tinfo getPriceWarning] getOrigin] == ROLETYPE_USER) {
        [NSThread detachNewThreadSelector:@selector(runReached:) toTarget:self withObject:[[tinfo getPriceWarning] getGuid]];
    }
}

- (void)runReached:(NSString *)guid {
    [[TradeApi getInstance] readPriceWarning:guid];
}

@end
