//
//  InfoOperator_TRADESERV1016.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1016.h"

#import "Info_TRADESERV1016.h"
#import "APIDocCaptain.h"

@implementation InfoOperator_TRADESERV1016

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1016 *tinfo = (Info_TRADESERV1016 *)info;
    [APIDocCaptain setClosedInstruments:[tinfo getClosedInstruments]];
}

@end
