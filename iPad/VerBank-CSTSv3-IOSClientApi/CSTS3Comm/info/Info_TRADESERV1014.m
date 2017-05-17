//
//  Info_TRADESERV1014.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1014.h"

static NSString * jsonId        = @"Info_TRADESERV1014";

static NSString * message    = @"1";

@implementation Info_TRADESERV1014

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(Message, message)

@end
