//
//  ToCloseTradeNode.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ToCloseTradeNode.h"

static NSString * jsonId = @"ToCloseTradeNode";

static NSString * ticket = @"1";
static NSString * splitno = @"2";
static NSString * amount = @"3";


@implementation ToCloseTradeNode
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionLongLong(Ticket, ticket)
jsonImplementionInt(Splitno, splitno)
jsonImplementionDouble(Amount, amount)

- (NSString *)toString {
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString appendString:[NSString stringWithFormat:@"ticket=%lld|",[self getTicket]]];
    [tempString appendString:[NSString stringWithFormat:@"splitno=%d|",[self getSplitno]]];
    [tempString appendString:[NSString stringWithFormat:@"amount=%f|",[self getAmount]]];
    return tempString;
}

@end
