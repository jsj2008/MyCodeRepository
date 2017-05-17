//
//  OP_Ctrl2002.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl2002.h"
static NSString *jsonId                         = @"OP_Ctrl2002";

static NSString *isForceToNew                   = @"1";
static NSString *otherClientConfigArray         = @"2";

@implementation OP_Ctrl2002

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionBoolean(IsForceToReNew, isForceToNew)
jsonImplementionObjectVec(OtherClientConfigArray, otherClientConfigArray)

@end
