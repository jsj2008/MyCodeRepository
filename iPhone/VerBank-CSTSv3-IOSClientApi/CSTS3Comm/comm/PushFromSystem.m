//
//  PushFromSystem.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PushFromSystem.h"

static NSString * jsonId = @"PushFromSystem";

static NSString * guid          = @"1";
static NSString * aeid          = @"2";
static NSString * title         = @"3";
static NSString * context       = @"4";
static NSString * isRead        = @"5";
static NSString * pushTime      = @"6";
static NSString * description   = @"7";
static NSString * account       = @"8";

@implementation PushFromSystem

@synthesize sortTag;

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Guid,          guid)
jsonImplementionString  (Aeid,          aeid)
jsonImplementionString  (Title,         title)
jsonImplementionString  (Context,       context)
jsonImplementionInt     (IsRead,        isRead)
jsonImplementionDate    (Time,          pushTime)
jsonImplementionString  (Description,   description)
jsonImplementionLongLong(Account,       account)

@end
