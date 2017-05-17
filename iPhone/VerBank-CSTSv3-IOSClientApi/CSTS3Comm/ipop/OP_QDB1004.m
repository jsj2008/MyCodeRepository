//
//  OP_QDB1004.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_QDB1004.h"

static NSString *jsonId                         = @"OP_QDB1004";

static NSString *list                           = @"1";

@implementation OP_QDB1004

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(List, list)

@end
