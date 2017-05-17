//
//  Info_TRADESERV1008.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1008.h"

static NSString * jsonId        = @"Info_TRADESERV1008";

static NSString * accountID     = @"1";
static NSString * attrID        = @"2";

@implementation Info_TRADESERV1008

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(AccountID,   accountID)
jsonImplementionInt     (AttrID,      attrID)

@end
