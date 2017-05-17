//
//  OP_TRADESERV5030.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5030.h"

static NSString *jsonId                 = @"OP_TRADESERV5030";

static NSString *basicCurrencyArray     = @"1";
static NSString *systemConfig           = @"2";
static NSString *instrumentArray        = @"3";
static NSString *interestAddType        = @"4";

@implementation OP_TRADESERV5030

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(BasicCurrencyArray, basicCurrencyArray)
jsonImplementionObject(SystemConfig, systemConfig)
jsonImplementionObjectVec(InstrumentArray, instrumentArray)
jsonImplementionObjectVec(InterestAddType, interestAddType)

@end
