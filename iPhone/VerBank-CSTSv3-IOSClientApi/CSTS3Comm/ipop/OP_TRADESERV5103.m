//
//  OP_TRADESERV5103.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5103.h"

static NSString *jsonId                         = @"OP_TRADESERV5103";

static NSString *order                            = @"1";

@implementation OP_TRADESERV5103
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(Order, order)

@end
