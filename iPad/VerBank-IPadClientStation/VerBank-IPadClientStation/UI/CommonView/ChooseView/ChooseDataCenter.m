//
//  ChooseDataCenter.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ChooseDataCenter.h"

static ChooseDataCenter *instance = nil;

@implementation ChooseDataCenter

@synthesize accountChooseArray;

+ (ChooseDataCenter *)getInstance {
    if (instance == nil) {
        instance = [[ChooseDataCenter alloc] init];
    }
    return instance;
}

- (void)resetData {
    self.accountChooseArray = nil;
}


@end
