//
//  IP_QDB1002.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_QDB1002.h"
static NSString * jsonId        = @"IP_QDB1002";

static NSString * instrument    = @"1";
static NSString * cycle         = @"2";
static NSString * limit         = @"3";

@implementation IP_QDB1002

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Instrument, instrument)
jsonImplementionInt(Cycle, cycle)
jsonImplementionInt(Limit, limit)

@end
