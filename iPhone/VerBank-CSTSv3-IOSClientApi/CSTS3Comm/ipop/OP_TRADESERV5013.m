//
//  OP_TRADESERV5013.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5013.h"
static NSString *jsonId               = @"OP_TRADESERV5013";

static NSString *instrument           = @"1";
@implementation OP_TRADESERV5013
-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(Instrument, instrument)

@end
