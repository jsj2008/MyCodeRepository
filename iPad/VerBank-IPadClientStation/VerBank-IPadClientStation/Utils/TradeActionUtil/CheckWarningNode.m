//
//  CheckWarningNode.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CheckWarningNode.h"

@implementation CheckWarningNode

@synthesize isSucceed = _isSucceed;
@synthesize errorMsg = _errorMsg;

- (id)initWithIsSucceed:(Boolean)isSucceed errorMsg:(NSString *)errorMsg {
    if (self = [super init]) {
        self.isSucceed = isSucceed;
        self.errorMsg = errorMsg;
    }
    return self;
}

@end
