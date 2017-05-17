//
//  OP_REPORT2001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_REPORT2001.h"

static NSString *jsonId                     = @"OP_REPORT2001";

static NSString *closePosList               = @"1";

@implementation OP_REPORT2001

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(ClosePosList, closePosList)

@end
