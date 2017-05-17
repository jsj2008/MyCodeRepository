//
//  OP_TRADESERV6103.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV6103.h"

@implementation OP_TRADESERV6103

static NSString *jsonId                         = @"OP_TRADESERV6103";

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

@end
