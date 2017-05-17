//
//  IP_TRADESERV5065.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5065.h"

static NSString * jsonId        = @"IP_TRADESERV5065";

static NSString * aeid      = @"1";
static NSString * account   = @"2";

@implementation IP_TRADESERV5065

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)
jsonImplementionLongLong(Account, account)


@end
