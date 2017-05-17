//
//  OP_TRADESERV5021.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5021.h"

static NSString *jsonId                             = @"OP_TRADESERV5021";

static NSString *instrumentAccountCgfArray          = @"1";
static NSString *instrumentAccountCgf               = @"2";

@implementation OP_TRADESERV5021

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(InstrumentsAccountCfgArray, instrumentAccountCgfArray)
jsonImplementionObject(InstrumentsAccountCfg, instrumentAccountCgf)

@end
