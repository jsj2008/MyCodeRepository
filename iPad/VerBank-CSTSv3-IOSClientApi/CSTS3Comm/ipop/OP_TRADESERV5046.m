//
//  OP_TRADESERV5046.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5046.h"

static NSString *jsonId                         = @"OP_TRADESERV5046";

static NSString *result                         = @"1";

@implementation OP_TRADESERV5046

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionBoolean(Result, result)

@end
