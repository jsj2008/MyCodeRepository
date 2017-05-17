//
//  OP_TRADESERV5011.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5011.h"
static NSString *jsonId                 = @"OP_TRADESERV5011";

static NSString *systemConfig           = @"1";

@implementation OP_TRADESERV5011

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(SystemConfig, systemConfig)

@end
