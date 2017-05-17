//
//  OP_QDB1002.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_QDB1002.h"

static NSString *jsonId                         = @"OP_QDB1002";

static NSString *hisDatas                       = @"1";

@implementation OP_QDB1002

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(HisDatas, hisDatas)

@end
