//
//  OP_TRADESERV5022.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5022.h"

static NSString *jsonId                     = @"OP_TRADESERV5022";

static NSString *moneyAccount               = @"1";

@implementation OP_TRADESERV5022

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(MoneyAccount, moneyAccount)

@end
