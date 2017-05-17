//
//  Holidays4ccy.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "Holidays4ccy.h"
static NSString * jsonId = @"Holidays4ccy";

static NSString * Hdatetime = @"1";
static NSString * Currencynames = @"2";
static NSString * Description = @"3";
static NSString * holidayNames = @"4";
@implementation Holidays4ccy
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Hdatetime,       Hdatetime)
jsonImplementionString(Currencynames,   Currencynames)
jsonImplementionString(Description,     Description)
jsonImplementionString(holidayNames,    holidayNames)
@end
