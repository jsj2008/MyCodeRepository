//
//  OP_TDB1016.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TDB1016.h"

static NSString *jsonId                         = @"OP_TDB1016";

static NSString *tSettled                       = @"1";

@implementation OP_TDB1016
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(TSettled, tSettled)

@end
