//
//  IP_TRADESERV5017.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5017.h"

static NSString * jsonId        = @"IP_TRADESERV5017";

static NSString * groupName     = @"1";

@implementation IP_TRADESERV5017

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(GroupName, groupName)

@end
