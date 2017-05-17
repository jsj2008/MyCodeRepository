//
//  OP_Ctrl5102.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl5102.h"

static NSString *jsonId               = @"OP_Ctrl5102";

static NSString *returnCode         = @"1";
static NSString *previousCA         = @"2";

@implementation OP_Ctrl5102

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt     (ReturnCode,          returnCode)
jsonImplementionString  (PreviousCA,          previousCA)

@end
