//
//  IP_TADESERV6102.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IP_REPORT6102.h"

static NSString * jsonId = @"IP_REPORT6102";

static NSString * aeid              = @"1";
static NSString * fromTime              = @"2";
static NSString * endTime              = @"3";

@implementation IP_REPORT6102

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid,            aeid)
jsonImplementionDate(FromTime,        fromTime)
jsonImplementionDate(EndTime,         endTime)

@end
