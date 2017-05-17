//
//  OP_Ctrl4004.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/13.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl4004.h"

static NSString *jsonId                         = @"OP_Ctrl4004";

static NSString *checkType                      = @"1";

@implementation OP_Ctrl4004

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(CheckType, checkType)

@end
