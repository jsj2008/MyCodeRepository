//
//  ToOpenTradeNode.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ToOpenTradeNode.h"

static NSString * jsonId = @"ToOpenTradeNode";

static NSString * instrumentName = @"1";
static NSString * buySell = @"2";
static NSString * amount = @"3";

@implementation ToOpenTradeNode

- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(InstrumentName, instrumentName)
jsonImplementionInt(BuySell, buySell)
jsonImplementionDouble(Amount, amount)

- (NSString *)toString {
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString appendString:[NSString stringWithFormat:@"instrumentName=%@|",[self getInstrumentName]]];
    [tempString appendString:[NSString stringWithFormat:@"buySell=%d|",[self getBuySell]]];
    [tempString appendString:[NSString stringWithFormat:@"amount=%f|",[self getAmount]]];
    return tempString;
}

@end
