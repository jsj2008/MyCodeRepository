//
//  OP_Ctrl4001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl4001.h"

static NSString *jsonId                         = @"OP_Ctrl4001";

static NSString *result                   = @"1";

@implementation OP_Ctrl4001
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(Result, result);

@end
