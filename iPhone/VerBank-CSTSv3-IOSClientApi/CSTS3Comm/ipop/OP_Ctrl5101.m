//
//  OP_Ctrl5101.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl5101.h"

static NSString *jsonId               = @"OP_Ctrl5101";

static NSString *fnStatus               = @"1";

@implementation OP_Ctrl5101

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject (FnStatus,          fnStatus)

@end
