//
//  IP_Ctrl4001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl4001.h"

static NSString * jsonId        = @"IP_Ctrl4001";

static NSString * aeid          = @"1";
static NSString * account       = @"2";
static NSString * oldPswd       = @"3";
static NSString * newPswd       = @"4";
static NSString * realName      = @"5";
static NSString * ipAddress     = @"6";

@implementation IP_Ctrl4001

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Aeid,        aeid)
jsonImplementionLongLong(Account,     account)
jsonImplementionString  (OldPswd,     oldPswd)
jsonImplementionString  (NewPswd,     newPswd)
jsonImplementionString  (RealName,    realName)
jsonImplementionString  (IpAddress,   ipAddress)

@end
