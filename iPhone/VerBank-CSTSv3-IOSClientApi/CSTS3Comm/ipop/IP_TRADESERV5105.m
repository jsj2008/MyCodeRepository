//
//  IP_TRADESERV5105.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5105.h"
static NSString * jsonId = @"IP_TRADESERV5105";

static NSString * account = @"1";
static NSString * orderID = @"2";
static NSString * accountDigist = @"3";
static NSString * aeid = @"4";

@implementation IP_TRADESERV5105

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(OrderID, orderID)
jsonImplementionLongLong(AccountID, account)
jsonImplementionString(AccountDigist, accountDigist)
jsonImplementionString(Aeid, aeid)

- (NSString *)toString {
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString appendString:[NSString stringWithFormat:@"account=%lld|", [self getAccountID]]];
    [tempString appendString:[NSString stringWithFormat:@"orderID=%lld|", [self getOrderID]]];
    [tempString appendString:[NSString stringWithFormat:@"accountDigist=%@|", [self getAccountDigist]]];
    [tempString appendString:[NSString stringWithFormat:@"aeid=%@|", [self getAeid]]];
    return tempString;
}

@end
