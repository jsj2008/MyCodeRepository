//
//  IP_REPORT2023.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_REPORT2023.h"

static NSString * jsonId        = @"IP_REPORT2023";

//static const int TYPE_ALL       = 1;
//static const int TYPE_GROUP     = 2;
//static const int TYPE_AEID      = 3;

static NSString * isClient      = @"1";
static NSString * type          = @"2";
static NSString * aeid          = @"3";
static NSString * fromTime      = @"4";
static NSString * endTime       = @"5";

@implementation IP_REPORT2023

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionBoolean (IsClient,    isClient)
jsonImplementionInt     (Type,        type)
jsonImplementionString  (Aeid,        aeid)
jsonImplementionDate    (FromTime,    fromTime)
jsonImplementionDate    (EndTime,     endTime)

@end
