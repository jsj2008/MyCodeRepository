//
//  InstWarnConfig.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/7.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InstWarnConfig.h"

static InstWarnConfig *instance = nil;

static double warningPerc = 0.01;

@implementation InstWarnConfig

+ (InstWarnConfig *)getInstance {
    if (instance == nil) {
        instance = [[InstWarnConfig alloc] init];
    }
    return instance;
}

- (double)getWarningPerc {
    return warningPerc;
}

@end
