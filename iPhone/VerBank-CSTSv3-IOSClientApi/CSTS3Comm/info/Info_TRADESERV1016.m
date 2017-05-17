//
//  Info_TRADESERV1016.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1016.h"

static NSString * jsonId        = @"Info_TRADESERV1016";

static NSString * timeoutInstruments        = @"1";
static NSString * closedInstruments         = @"2";

@implementation Info_TRADESERV1016

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(TimeoutInstruments, timeoutInstruments)
jsonImplementionObjectVec(ClosedInstruments,  closedInstruments)

@end
