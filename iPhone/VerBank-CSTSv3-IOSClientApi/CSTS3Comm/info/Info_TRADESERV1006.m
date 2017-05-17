//
//  Info_TRADESERV1006.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1006.h"

static NSString * jsonId        = @"Info_TRADESERV1006";

static NSString * closeState    = @"1";
static NSString * tradeDay      = @"2";

@implementation Info_TRADESERV1006

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(CloseState, closeState)
jsonImplementionString(TradeDay, tradeDay)

@end
