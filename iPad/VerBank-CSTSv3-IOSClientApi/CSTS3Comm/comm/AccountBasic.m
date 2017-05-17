//
//  AccountBasic.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AccountBasic.h"

static NSString * jsonId                 =@"AccountBasic";

static NSString * account                =@"1";
static NSString * aeid                   =@"2";
static NSString * realName               =@"3";
static NSString * groupName              =@"4";
static NSString * currency               =@"5";
static NSString * equity                 =@"6";

@implementation AccountBasic

- (id)init{
    if(self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(Account, account)
jsonImplementionString(Aeid, aeid)
jsonImplementionString(RealName, realName)
jsonImplementionString(GroupName, groupName)
jsonImplementionString(Currency, currency)
jsonImplementionDouble(Equity, equity)

@end
