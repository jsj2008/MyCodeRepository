//
//  OP_TRADESERV5040.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5040.h"

static NSString *jsonId                         = @"OP_TRADESERV5040";

static NSString *groupConfigArray               = @"1";
static NSString *userLogin                      = @"2";
static NSString *accountStrategyArray           = @"3";
static NSString *instrumentGroupCfgArray        = @"4";
static NSString *instrumentAccountCfgArray      = @"5";

@implementation OP_TRADESERV5040

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(GroupConfigArray, groupConfigArray)
jsonImplementionObject(UserLogin, userLogin)
jsonImplementionObjectVec(AccountStrategyArray, accountStrategyArray)
jsonImplementionObjectVec(InstrumentGroupCfgArray, instrumentGroupCfgArray)
jsonImplementionObjectVec(InstrumentAccountCfgArray, instrumentAccountCfgArray)

@end
