//
//  IP_TRADESERV5021.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5021.h"
static NSString * jsonId            = @"IP_TRADESERV5021";

static NSString * accountID         = @"1";
static NSString * instrumentName    = @"2";
static NSString * isToQueryAll     = @"3";

@implementation IP_TRADESERV5021

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID, accountID)
jsonImplementionString(InstrumentName, instrumentName)
jsonImplementionBoolean(IsToQueryAll, isToQueryAll)

@end
