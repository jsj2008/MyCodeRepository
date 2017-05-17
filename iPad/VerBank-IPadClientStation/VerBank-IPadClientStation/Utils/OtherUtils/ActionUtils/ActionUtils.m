//
//  ActionUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ActionUtils.h"
#import "LayoutCenter.h"
#import "JumpDataCenter.h"

static ActionUtils *instance = nil;

@implementation ActionUtils

+ (ActionUtils *)getInstance {
    if (instance == nil) {
        instance = [[ActionUtils alloc] init];
    }
    return instance;
}

- (void)showDatePickView:(id)sender {
    [[JumpDataCenter getInstance] setValueTimeButton:sender];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showDatePickView];
}

- (void)instrumentPick {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showInstrumentPickView];
}

- (void)showSystemConfigView {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
}

@end
