//
//  IP_TRADESERV6001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV6101.h"

@implementation IP_TRADESERV6101
static NSString * jsonId = @"IP_TRADESERV6101";

static NSString * aeid              = @"1";
static NSString * caDownloadTimer   = @"2";

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid,            aeid)
jsonImplementionInt(CaDownloadTimer,    caDownloadTimer)

@end
