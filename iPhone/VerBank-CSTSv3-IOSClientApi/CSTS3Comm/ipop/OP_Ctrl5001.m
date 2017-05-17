//
//  OP_Ctrl5001.m
//  VerBank-IOSClientStation
//
//  Created by ZhangLei on 2016/10/27.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OP_Ctrl5001.h"

static NSString *jsonId                             = @"OP_Ctrl5001";

static NSString *verify                             = @"1";
static NSString *failedReason                       = @"2";

@implementation OP_Ctrl5001

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Verify, verify)
jsonImplementionString(FailedReason, failedReason)

@end
