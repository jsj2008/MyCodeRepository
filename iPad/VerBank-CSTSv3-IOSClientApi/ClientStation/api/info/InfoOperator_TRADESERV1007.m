//
//  InfoOperator_TRADESERV1007.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1007.h"

#import "Info_TRADESERV1007.h"
#import "API_IDEventCaptain.h"

@implementation InfoOperator_TRADESERV1007

- (void)onInfo:(InfoFather *)info {
    Info_TRADESERV1007 *tinfo = (Info_TRADESERV1007 *)info;
    // 暂时将整个对象传入
    [API_IDEventCaptain fireEventChanged:DATA_ON_MktOrderHasSendToMarket eventData:tinfo];
    
}

@end
