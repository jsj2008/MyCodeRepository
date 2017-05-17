//
//  OP_TRADESERV6001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV6101.h"

static NSString *jsonId                         = @"OP_TRADESERV6101";

@implementation OP_TRADESERV6101
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

@end
