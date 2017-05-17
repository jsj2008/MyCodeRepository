//
//  LangPack.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "LangPack.h"
static NSString * jsonId = @"LangPack";

static NSString * treeLangMap = @"1";
static NSString * instrumentLangMap = @"2";
@implementation LangPack
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
@end
