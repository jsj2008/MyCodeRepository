//
//  InfoOperator_TRADESERV1013.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1013.h"

#import "Info_TRADESERV1013.h"
#import "APIDoc.h"
#import "API_IDEventCaptain.h"

@implementation InfoOperator_TRADESERV1013

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1013 *tinfo = (Info_TRADESERV1013 *)info;
    if ([[APIDoc getUserDocCaptain] getCDS_AccountStore:[tinfo getAccountID]] == nil) {
        return;
    }
    
    [API_IDEventCaptain fireEventChanged:OTHER_ON_MARGINCALL eventData:[@([tinfo getAccountID]) stringValue]];
}

@end
