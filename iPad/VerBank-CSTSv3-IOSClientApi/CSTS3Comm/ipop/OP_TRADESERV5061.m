//
//  OP_TRADESERV5061.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5061.h"

static NSString *jsonId                         = @"OP_TRADESERV5061";

static NSString *messages                         = @"1";


@implementation OP_TRADESERV5061
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(Messages, messages)
@end
