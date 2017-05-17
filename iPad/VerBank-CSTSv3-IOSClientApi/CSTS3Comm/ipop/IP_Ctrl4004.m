//
//  IP_Ctrl4004.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/13.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl4004.h"

static NSString * jsonId        = @"IP_Ctrl4004";

static NSString * aeid          = @"1";
static NSString * account       = @"2";
static NSString * phonePin      = @"3";

@implementation IP_Ctrl4004

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Aeid,      aeid)
jsonImplementionLongLong(Account,   account)
jsonImplementionString  (PhonePin,  phonePin)

@end
