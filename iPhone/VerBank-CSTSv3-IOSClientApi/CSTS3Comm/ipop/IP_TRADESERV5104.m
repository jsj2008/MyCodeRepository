//
//  IP_TRADESERV5104.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5104.h"
static NSString * jsonId = @"IP_TRADESERV5104";
static NSString * orderID = @"1";
static NSString * accountID = @"2";
static NSString * amount = @"3";
static NSString * stopMoveGap = @"4";
static NSString * limitprice = @"5";
static NSString * oriStopprice = @"6";
static NSString * expiryType = @"7";
static NSString * expiryTime = @"8";
static NSString * IFDLimitPrice = @"9";
static NSString * IFDStopPrice = @"10";
static NSString * accountDigist = @"11";
static NSString * aeid = @"12";
static NSString * isManual = @"13";
static NSString * comment = @"14";

@implementation IP_TRADESERV5104

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(OrderID, orderID)
jsonImplementionLongLong(AccountID, accountID)
jsonImplementionDouble(Amount, amount)
jsonImplementionInt(StopMoveGap, stopMoveGap)
jsonImplementionDouble(LimitPrice, limitprice)
jsonImplementionDouble(OriStopprice, oriStopprice)
jsonImplementionInt(ExpireType, expiryType)
jsonImplementionString(ExpireTime, expiryTime)

jsonImplementionDouble(IFDLimitPrice, IFDLimitPrice)
jsonImplementionDouble(IFDStopPrice, IFDStopPrice)
jsonImplementionString(AccountDigist, accountDigist)
jsonImplementionString(Aeid, aeid)
jsonImplementionBoolean(IsManual, isManual)
jsonImplementionString(Comment, comment)

- (NSString *)toString {
    NSMutableString *tempString = [[NSMutableString alloc] init];
    
    [tempString appendString:[NSString stringWithFormat:@"orderID=%lld|",[self getOrderID] ]];
    [tempString appendString:[NSString stringWithFormat:@"accountID=%f|", [self getIFDLimitPrice] ]];
    [tempString appendString:[NSString stringWithFormat:@"amount=%f|", [self getIFDStopPrice]]];
    [tempString appendString:[NSString stringWithFormat:@"stopMoveGap=%@|", [self getAccountDigist]]];
    [tempString appendString:[NSString stringWithFormat:@"limitprice=%f|",[self getLimitPrice] ]];
    [tempString appendString:[NSString stringWithFormat:@"oriStopprice=%f|", [self getOriStopprice] ]];
    [tempString appendString:[NSString stringWithFormat:@"expiryType=%d|", [self getExpireType]]];
    [tempString appendString:[NSString stringWithFormat:@"expiryTime=%@|", [self getExpireTime]]];
    [tempString appendString:[NSString stringWithFormat:@"IFDLimitPrice=%f|",[self getLimitPrice] ]];
    [tempString appendString:[NSString stringWithFormat:@"IFDStopPrice=%f|", [self getIFDStopPrice] ]];
    [tempString appendString:[NSString stringWithFormat:@"accountDigist=%@|", [self getAccountDigist]]];
    [tempString appendString:[NSString stringWithFormat:@"aeid=%@|", [self getAeid]]];
   
    return tempString;
}

@end
