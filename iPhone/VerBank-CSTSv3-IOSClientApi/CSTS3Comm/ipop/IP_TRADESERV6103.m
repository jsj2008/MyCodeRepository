//
//  IP_TRADESERV6103.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV6103.h"

static NSString * jsonId = @"IP_TRADESERV6103";

static NSString * aeid              = @"1";
static NSString * guid              = @"2";

@implementation IP_TRADESERV6103

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid,            aeid)
jsonImplementionString(GUID,            guid)
@end
