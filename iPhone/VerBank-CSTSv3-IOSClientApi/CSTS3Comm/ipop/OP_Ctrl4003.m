//
//  OP_Ctrl4003.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl4003.h"

static NSString *jsonId                         = @"OP_Ctrl4003";

@implementation OP_Ctrl4003

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

@end
