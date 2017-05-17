//
//  OP_TRADESERV5020.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5020.h"

static NSString *jsonId                             = @"OP_TRADESERV5020";

static NSString *instrumentGroupCfgArray            = @"1";
static NSString *instrumentGroupCfg                 = @"2";

@implementation OP_TRADESERV5020

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(InstrumentGroupCfgArray, instrumentGroupCfgArray)
jsonImplementionObject(InstrumentGroupCfg, instrumentGroupCfg)

@end
