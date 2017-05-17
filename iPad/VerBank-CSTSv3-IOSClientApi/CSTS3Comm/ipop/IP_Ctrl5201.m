//
//  IP_Ctrl5201.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/28.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl5201.h"

static NSString *jsonId                 = @"IP_Ctrl5201";

static NSString *aeid                   = @"1";
static NSString *deviceType             = @"2";
static NSString *deviceToken            = @"3";
static NSString *accountID              = @"4";
static NSString *groupName              = @"5";

@implementation IP_Ctrl5201

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Aeid,          aeid)
jsonImplementionInt     (DeviceType,    deviceType)
jsonImplementionString  (DeviceToken,   deviceToken)
jsonImplementionString  (AccountID,     accountID)
jsonImplementionString  (GroupName,     groupName)

@end
