//
//  IP_QG1001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_QG1001.h"

static NSString * jsonId        = @"IP_QG1001";

static NSString * searchType     = @"3";
static NSString * instruments    = @"4";

@implementation IP_QG1001

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt         (SearchType, searchType)
jsonImplementionObjectVec   (Instruments, instruments)

@end
