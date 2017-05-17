//
//  OP_Ctrl5107.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl5107.h"

static NSString *jsonId               = @"OP_Ctrl5107";

static NSString *fnCertStatus               = @"1";

@implementation OP_Ctrl5107

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject (FnCertStatus,          fnCertStatus)

@end
