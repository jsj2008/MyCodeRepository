//
//  MoneyAccountFrozen.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "MoneyAccountFrozen.h"
//private long long guid;
//private long long account;
//private String currencyName;
//private int type;
//private double amount;
//private String tradeDay;
//private Date frozenTime;
//private String comments;
//private String userName;
//private int userType;
//private String ipAddress;

    
static NSString * jsonId = @"MoneyAccountFrozen";

static NSString * guid = @"1";
static NSString * account = @"2";
static NSString * currencyName = @"3";
static NSString * type = @"4";
static NSString * amount = @"5";
static NSString * tradeDay = @"6";
static NSString * frozenTime = @"7";
static NSString * comments = @"8";
static NSString * userName = @"9";
static NSString * userType = @"10";
static NSString * ipAddress = @"11";
@implementation MoneyAccountFrozen
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionLongLong(Guid,          guid)
jsonImplementionLongLong(Account,       account)
jsonImplementionString(CurrencyName,currencyName)
jsonImplementionInt(Type,           type)
jsonImplementionDouble(Amount,      amount)
jsonImplementionString(TradeDay,    tradeDay)
jsonImplementionDate(FrozenTime,    frozenTime)
jsonImplementionString(Comments,    comments)
jsonImplementionString(UserName,    userName)
jsonImplementionInt(UserType,       userType)
jsonImplementionString(IpAddress,   ipAddress)
@end
