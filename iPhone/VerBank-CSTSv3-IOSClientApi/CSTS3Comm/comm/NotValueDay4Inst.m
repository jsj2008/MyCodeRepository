//
//  NotValueDay4Inst.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "NotValueDay4Inst.h"

static NSString * jsonId = @"NotValueDay4Inst";

static NSString * Hdatetime = @"1";
static NSString * instruments = @"2";
static NSString * Description = @"3";
static NSString * holidayNames = @"4";
@implementation NotValueDay4Inst
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(Hdatetime,   Hdatetime)
jsonImplementionString(Instruments ,instruments)
jsonImplementionString(Description ,Description)
jsonImplementionString(HolidayNames,holidayNames)
@end
