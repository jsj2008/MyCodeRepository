//
//  IP_QBD1004.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_QDB1004.h"

static NSString * jsonId        = @"IP_QDB1004";

static NSString * instrument    = @"1";
static NSString * today         = @"2";
static NSString * limit         = @"3";

@implementation IP_QDB1004

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Instrument, instrument)
jsonImplementionBoolean(Today, today)
jsonImplementionInt(Limit, limit)
@end
