//
//  InfoOperator_TRADESERV1014.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1014.h"

#import "Info_TRADESERV1014.h"
#import "MessageToAccount.h"
#import "MTP4CommDataInterface.h"
#import "API_IDEventCaptain.h"

@implementation InfoOperator_TRADESERV1014

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1014 *tinfo = (Info_TRADESERV1014 *)info;
    MessageToAccount *message = [tinfo getMessage];
    [message setIsRead:FALSE];
    
    [API_IDEventCaptain fireEventChanged:DATA_ON_MessageReceive eventData:message];
}

@end
