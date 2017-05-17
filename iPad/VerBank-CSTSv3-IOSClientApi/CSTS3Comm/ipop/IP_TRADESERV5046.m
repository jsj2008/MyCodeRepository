//
//  IP_TRADESERV5046.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5046.h"

static NSString * jsonId        = @"IP_TRADESERV5046";

static NSString * accountID         = @"1";
static NSString * digist            = @"2";

@implementation IP_TRADESERV5046

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID, accountID)
jsonImplementionString(Digist, digist)

@end
