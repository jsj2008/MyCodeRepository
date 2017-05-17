//
//  OtherClientConfig.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "OtherClientConfig.h"
static NSString * jsonId = @"OtherClientConfig";

static NSString * key = @"1";
static NSString * locale = @"2";
static NSString * type = @"3";
static NSString * Link = @"4";
static NSString * Content = @"5";
static NSString * value = @"6";
@implementation OtherClientConfig
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(Key,         key)
jsonImplementionString(Locale,      locale)
jsonImplementionInt(Type,           type)
jsonImplementionString(Link ,       Link)
jsonImplementionString(Content ,    Content)
jsonImplementionString(Value,       value)
@end
