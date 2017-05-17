//
//  SystemDocOperator.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SystemDocOperator.h"

#import "API_IDEventCaptain.h"

#import "CSTSCaptain.h"
#import "APIDoc.h"

#import "IP_TRADESERV5010.h"
#import "OP_TRADESERV5010.h"
#import "IP_TRADESERV5011.h"
#import "OP_TRADESERV5011.h"

static SystemDocOperator *instance = nil;

@implementation SystemDocOperator

+ (id)getInstance {
    if (instance == nil) {
        instance = [[SystemDocOperator alloc] init];
    }
    return instance;
}

- (Boolean)loadBasicCurrency {
    //    API_IDEventCaptain fireEventChanged:<#(NSString *)#> eventData:<#(id)#>]
    IP_TRADESERV5010 *ip =[[IP_TRADESERV5010 alloc] init];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    
    if (![opFather isSuccessed]) {
        return false;
    }
    
    OP_TRADESERV5010 *op = (OP_TRADESERV5010 *)opFather;
    [[APIDoc getSystemDocCaptain] resetBasicCurrencys:[op getBasicCurrencyArray]];
    return true;
}

- (Boolean)loadSystemConfig {
    IP_TRADESERV5011 *ip = [[IP_TRADESERV5011 alloc] init];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    
    if (![opFather isSuccessed]) {
        return false;
    }
    
    OP_TRADESERV5011 *op = (OP_TRADESERV5011 *)opFather;
    [[APIDoc getSystemDocCaptain] setSystemConfig:[op getSystemConfig]];
    return true;
}

@end
