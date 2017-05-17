//
//  IP_TRADESERV5109.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV5109.h"
static NSString * jsonId = @"IP_TRADESERV5109";



static NSString * operateType = @"1";
static NSString * toDeletePWGUID = @"2";
static NSString * dealerDesc = @"3";
static NSString * aeid = @"4";
static NSString * price = @"5";
static NSString * expiryType = @"6";
static NSString * expiryTime = @"7";
static NSString * toAddPW = @"8";

@implementation IP_TRADESERV5109

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(OperateType, operateType)
jsonImplementionString(ToDeletePWGUID, toDeletePWGUID)
jsonImplementionString(DealerDesc, dealerDesc)
jsonImplementionString(Aeid, aeid)
jsonImplementionDouble(Price, price)
jsonImplementionInt(ExpiryType, expiryType)
jsonImplementionDate(ExpiryTime, expiryTime)
jsonImplementionObject(ToAddPW, toAddPW)

@end
