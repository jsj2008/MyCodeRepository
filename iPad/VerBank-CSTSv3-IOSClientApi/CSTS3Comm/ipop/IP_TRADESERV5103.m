//
//  IP_TRADESERV5103.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5103.h"
static NSString * jsonId        = @"IP_TRADESERV5103";

static NSString * aeid = @"1";
static NSString * accountID = @"2";
static NSString * instrument = @"3";
static NSString * buysell = @"4";
static NSString * amount = @"5";
static NSString * type = @"6";
static NSString * limitprice = @"7";
static NSString * oriStopprice = @"8";
static NSString * stopMoveGap = @"9";
static NSString * toOpenNew = @"10";
static NSString * toCloseTickets = @"11";;
static NSString * expireType = @"12";
static NSString * expireTime = @"13";
static NSString * IFDLimitPrice = @"14";
static NSString * IFDStopPrice = @"15";
static NSString * accountDigist = @"16";

static NSString * isManual = @"17";
static NSString * comment = @"18";

@implementation IP_TRADESERV5103

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)
jsonImplementionLongLong(AccountID, accountID)
jsonImplementionString(Instrument, instrument)

jsonImplementionInt(BuySell, buysell)
jsonImplementionDouble(Amount, amount)
jsonImplementionInt(Type, type)
jsonImplementionDouble(LimitPrice, limitprice)
jsonImplementionDouble(OriStopprice, oriStopprice)
jsonImplementionInt(StopMoveGap, stopMoveGap)
jsonImplementionBoolean(ToOpenNew, toOpenNew)
jsonImplementionString(ToCloseTickets, toCloseTickets)
jsonImplementionInt(ExpireType, expireType)
jsonImplementionString(ExpireTime, expireTime)

jsonImplementionDouble(IFDLimitPrice, IFDLimitPrice)
jsonImplementionDouble(IFDStopPrice, IFDStopPrice)
jsonImplementionString(AccountDigist, accountDigist)

jsonImplementionBoolean(IsManual, isManual)
jsonImplementionString(Comment, comment)

- (NSString *)toString {
//    StringBuffer sb = new StringBuffer();
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString appendString:[NSString stringWithFormat:@"aeid=%@|", [self getAeid]]];
    [tempString appendString:[NSString stringWithFormat:@"accountID=%lld|", [self getAccountID]]];
    [tempString appendString:[NSString stringWithFormat:@"instrumentName=%@|",[self getInstrument]]];
    [tempString appendString:[NSString stringWithFormat:@"buysell=%d|",[self getBuySell]]];
    [tempString appendString:[NSString stringWithFormat:@"amount=%f|",[self getAmount]]];
    [tempString appendString:[NSString stringWithFormat:@"type=%d|", [self getType]]];
    [tempString appendString:[NSString stringWithFormat:@"limitprice=%f|", [self getLimitPrice]]];
    [tempString appendString:[NSString stringWithFormat:@"oriStopprice=%f|",[self getOriStopprice]]];
    [tempString appendString:[NSString stringWithFormat:@"stopMoveGap=%d|", [self getStopMoveGap]]];
    [tempString appendString:[NSString stringWithFormat:@"toOpenNew=%hhu|", [self getToOpenNew] ]];
    [tempString appendString:[NSString stringWithFormat:@"toCloseTickets=%@|",[self getToCloseTickets] ]];
    [tempString appendString:[NSString stringWithFormat:@"expireType=%d|",[self getExpireType]]];
    [tempString appendString:[NSString stringWithFormat:@"expireTime=%@|",[self getExpireTime] ]];
    [tempString appendString:[NSString stringWithFormat:@"IFDLimitPrice=%f|", [self getIFDLimitPrice] ]];
    [tempString appendString:[NSString stringWithFormat:@"IFDStopPrice=%f|", [self getIFDStopPrice]]];
    [tempString appendString:[NSString stringWithFormat:@"accountDigist=%@|", [self getAccountDigist]]];
    
    return tempString;
}

@end
