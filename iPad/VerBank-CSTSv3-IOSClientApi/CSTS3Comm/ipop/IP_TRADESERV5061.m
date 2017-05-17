//
//  IP_TRADESERV5061.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5061.h"

static NSString * jsonId        = @"IP_TRADESERV5061";

static NSString * aeid         = @"1";

@implementation IP_TRADESERV5061

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)

@end
