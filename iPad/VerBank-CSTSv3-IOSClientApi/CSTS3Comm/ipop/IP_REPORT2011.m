//
//  IP_REPORT2011.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IP_REPORT2011.h"

static NSString * jsonId        = @"IP_REPORT2011";

static NSString * type          = @"1";
static NSString * account       = @"2";
static NSString * groupName     = @"3";
static NSString * typeVec       = @"4";
static NSString * fromTime      = @"5";
static NSString * endTime       = @"6";

@implementation IP_REPORT2011

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt     (Type,            type)
jsonImplementionLongLong(Account,         account)
jsonImplementionString  (GroupName,       groupName)
jsonImplementionObjectVec(TypeVec,        typeVec)
jsonImplementionDate    (FromTime,        fromTime)
jsonImplementionDate    (EndTime,         endTime)

@end
