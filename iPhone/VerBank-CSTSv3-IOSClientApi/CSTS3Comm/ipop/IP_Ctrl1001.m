//
//  IP_Ctrl1001.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/23.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "IP_Ctrl1001.h"

#import "JEDIDateTime.h"
#import "JEDISystem.h"

static NSString * jsonId        = @"IP_Ctrl1001";

static NSString * password      = @"1";
static NSString * isfirstLogin  = @"2";
static NSString * firstLoginTime=@"3";
static NSString * IPAddress     = @"4";
static NSString * aeid          = @"5";
static NSString * clientId      = @"6";
static NSString * version       = @"7";

@implementation IP_Ctrl1001

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Password,      password)
jsonImplementionBoolean (IsFirstLogin,  isfirstLogin)
jsonImplementionLongLong(FirstLoginTime,firstLoginTime)
jsonImplementionString  (IPAddress,     IPAddress)
jsonImplementionString  (Aeid,          aeid)
jsonImplementionString  (ClientID,      clientId)
jsonImplementionString  (Version,       version)

@end
