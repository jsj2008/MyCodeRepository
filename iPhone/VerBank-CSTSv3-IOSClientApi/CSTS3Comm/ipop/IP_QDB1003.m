//
//  IP_QDB1003.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_QDB1003.h"

static NSString * jsonId        = @"IP_QDB1003";

static NSString * instrument    = @"1";
static NSString * cycle         = @"2";
static NSString * limit         = @"3";
static NSString * endTime       = @"4";

@implementation IP_QDB1003

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Instrument, instrument)
jsonImplementionInt(Cycle, cycle)
jsonImplementionInt(Limit, limit)
jsonImplementionLongLong(EndTime, endTime)

@end
