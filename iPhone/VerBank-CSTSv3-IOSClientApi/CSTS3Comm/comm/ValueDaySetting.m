//
//  ValueDaySetting.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "ValueDaySetting.h"
static NSString * jsonId = @"ValueDaySetting";

static NSString * tradeDay = @"1";
static NSString * instrument = @"2";
static NSString * valueDay = @"3";
static NSString * description = @"4";
@implementation ValueDaySetting
- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(TradeDay,    tradeDay)
jsonImplementionString(Instrument,  instrument)
jsonImplementionString(ValueDay,    valueDay)
jsonImplementionString(Description, description)
@end
