//
//  IP_TRADESERV5020.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5020.h"

static NSString * jsonId            = @"IP_TRADESERV5020";

static NSString * instrument        = @"1";
static NSString * groupName         = @"2";
static NSString * isToQuerryAll     = @"3";

@implementation IP_TRADESERV5020
-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Instrument, instrument)
jsonImplementionBoolean(IsToQuerryAll, isToQuerryAll)
jsonImplementionString(GroupName, groupName)

@end
