//
//  QuoteSizeData.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "QuoteSizeData.h"
static NSString * jsonId = @"QuoteSizeData";

static NSString * instrument = @"1";
static NSString * priceType = @"2";
static NSString * ammount = @"3";
@implementation QuoteSizeData
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
@end
