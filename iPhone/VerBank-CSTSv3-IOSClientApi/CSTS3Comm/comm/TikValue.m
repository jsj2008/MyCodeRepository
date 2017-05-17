//
//  TikValue.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TikValue.h"

static NSString * jsonId = @"TikValue";

static NSString * tikTime = @"1";
static NSString * bid = @"2";
static NSString * ask = @"3";
static NSString * volume = @"4";
static NSString * amount = @"5";

@implementation TikValue
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionLongLong(TikTime, tikTime)
jsonImplementionDouble(Bid, bid)
jsonImplementionDouble(Ask, ask)
jsonImplementionDouble(Volume, volume)
jsonImplementionDouble(Amount, amount)

@end
