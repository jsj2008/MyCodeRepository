//
//  OP_TRADESERV5062.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5062.h"

static NSString *jsonId                         = @"OP_TRADESERV5062";

static NSString *message                         = @"1";

@implementation OP_TRADESERV5062
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(Message, message)

@end
