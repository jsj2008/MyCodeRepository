//
//  WithDrawApplication.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "WithDrawApplication.h"

static NSString * jsonId = @"WithDrawApplication";

static NSString * guid = @"1";
static NSString * type = @"2";
static NSString * account = @"3";
static NSString * currency = @"4";
static NSString * amount = @"5";
static NSString * appTime = @"6";
static NSString * ipAddress = @"7";
static NSString * description = @"8";
static NSString * dealer = @"9";
static NSString * dealerIp = @"10";
static NSString * isRead = @"11";
static NSString * readTime = @"12";
static NSString * state = @"13";
static NSString * cmdType = @"14";
static NSString * cmdName = @"15";
static NSString * cmdIpAddress = @"16";
static NSString * closeInterest = @"17";

@implementation WithDrawApplication

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Guid, guid)
jsonImplementionInt(Type, type)
jsonImplementionLongLong(Account, account)
jsonImplementionString(Currency, currency)
jsonImplementionDouble(Amount, amount)
jsonImplementionDate(AppTime, appTime)

jsonImplementionString(IpAddress, ipAddress)
jsonImplementionString(Description, description)
jsonImplementionString(Dealer, dealer)
jsonImplementionString(DealerIP, dealerIp)
jsonImplementionInt(IsRead, isRead)
jsonImplementionDate(ReadTime, readTime)

jsonImplementionInt(State, state)
jsonImplementionInt(CmdType, cmdType)
jsonImplementionString(CmdName, cmdName)
jsonImplementionString(CmdIpAddress, cmdIpAddress)
jsonImplementionDouble(CloseInterest, closeInterest)

@end
