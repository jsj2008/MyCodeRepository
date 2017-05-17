//
//  IP_TRADESERV5102.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5102.h"

#import "ToOpenTradeNode.h"
#import "ToCloseTradeNode.h"

static NSString * jsonId = @"IP_TRADESERV5102";

static NSString * aeid = @"1";
static NSString * accountID = @"2";
static NSString * instrument = @"3";
static NSString * accountDigist = @"4";
static NSString * closeBuyTradeVec = @"5";
static NSString * closeSellTradeVec = @"6";

@implementation IP_TRADESERV5102

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)
jsonImplementionLongLong(AccountID, accountID)
jsonImplementionString(Instrument, instrument)
jsonImplementionString(AccountDigist, accountDigist)
jsonImplementionObjectVec(CloseBuyTradeVec, closeBuyTradeVec)
jsonImplementionObjectVec(CloseSellTradeVec, closeSellTradeVec)

- (NSString *)toString {
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString appendString:[NSString stringWithFormat:@"aeid=%@|", [self getAeid]]];
    [tempString appendString:[NSString stringWithFormat:@"accountID=%lld|", [self getAccountID]]];
    [tempString appendString:[NSString stringWithFormat:@"instrument=%@|", [self getInstrument]]];
    [tempString appendString:[NSString stringWithFormat:@"accountDigist=%@|", [self getAccountDigist]]];
    
    [tempString appendString:@" @ closeBuyTradeVec: "];
    for (ToCloseTradeNode *tctn in [self getCloseBuyTradeVec]) {
        [tempString appendString:[tctn toString]];
        [tempString appendString:@" : "];
    }
    
    [tempString appendString:@" @ closeSellTradeVec: "];
    for (ToCloseTradeNode *tctn in [self getCloseSellTradeVec]) {
        [tempString appendString:[tctn toString]];
        [tempString appendString:@" : "];
    }
    return tempString;
}

@end
