//
//  InstTypeTree.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "InstTypeTree.h"
static NSString * jsonId = @"InstTypeTree";

static NSString * typeName = @"1";
static NSString * parentType = @"2";
static NSString * sort = @"3";
@implementation InstTypeTree
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
@end
