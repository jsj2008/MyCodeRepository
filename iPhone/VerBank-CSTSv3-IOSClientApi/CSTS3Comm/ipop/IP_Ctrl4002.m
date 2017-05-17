//
//  IP_Ctrl4002.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl4002.h"

static NSString * jsonId        = @"IP_Ctrl4002";

static NSString * aeid          = @"1";
static NSString * account       = @"2";
static NSString * oldPhonePin   = @"3";
static NSString * newPhonePin   = @"4";
static NSString * realName      = @"5";
static NSString * ipAddress     = @"6";

@implementation IP_Ctrl4002

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Aeid,        aeid)
jsonImplementionLongLong(Account,     account)
jsonImplementionString  (OldPhonePin, oldPhonePin)
jsonImplementionString  (NewPhonePin, newPhonePin)
jsonImplementionString  (RealName,    realName)
jsonImplementionString  (IpAddress,   ipAddress)
@end
