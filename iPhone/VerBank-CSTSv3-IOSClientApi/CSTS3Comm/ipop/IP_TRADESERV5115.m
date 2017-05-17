//
//  IP_TRADESERV5115.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5115.h"
static NSString * jsonId        = @"IP_TRADESERV5115";

static NSString * title     = @"1";
static NSString * context   = @"2";

@implementation IP_TRADESERV5115

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Title, title)
jsonImplementionString(Context, context)

@end
