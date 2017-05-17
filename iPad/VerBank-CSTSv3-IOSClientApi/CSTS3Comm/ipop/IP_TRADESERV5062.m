//
//  IP_TRADESERV5062.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5062.h"

static NSString * jsonId        = @"IP_TRADESERV5062";

static NSString * messageGuid  = @"1";
static NSString * aeid         = @"2";

@implementation IP_TRADESERV5062

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)
jsonImplementionString(MessageGuid, messageGuid)
@end
