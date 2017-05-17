//
//  IP_TRADESERV5116.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5116.h"
static NSString * jsonId        = @"IP_TRADESERV5116";

static NSString * withDrawApplication   = @"1";
static NSString * password              = @"2";

@implementation IP_TRADESERV5116

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(WithDrawApplication, withDrawApplication)
jsonImplementionString(Password, password)

@end
