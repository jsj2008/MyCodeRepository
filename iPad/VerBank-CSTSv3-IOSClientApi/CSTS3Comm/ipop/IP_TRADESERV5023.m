//
//  IP_TRADESERV5023.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5023.h"

static NSString * jsonId        = @"IP_TRADESERV5023";



static NSString * queryType         = @"1";
static NSString * accountID         = @"2";
static NSString * aeid              = @"3";

@implementation IP_TRADESERV5023

jsonImplementionInt     (QueryType,   queryType)
jsonImplementionLongLong(AccountID,   accountID)
jsonImplementionString  (Aeid,        aeid)

@end
