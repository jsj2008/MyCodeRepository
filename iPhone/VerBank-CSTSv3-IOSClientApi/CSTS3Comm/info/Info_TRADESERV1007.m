//
//  Info_TRADESERV1007.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1007.h"

static NSString * jsonId        = @"Info_TRADESERV1007";

static NSString * userOperatorID    = @"1";
static NSString * uptradeExcId      = @"2";

@implementation Info_TRADESERV1007

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(UserOperatorID, userOperatorID)
jsonImplementionLongLong(UptradeExcId, uptradeExcId)

@end