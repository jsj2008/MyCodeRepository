//
//  InstrumentPickView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "InstrumentPickView.h"
#import "InstrumentPickContentView.h"
#import "LayoutCenter.h"

@implementation InstrumentPickView

- (id)init {
    if (self = [super init]) {
        [self setDefault];
        [self initComponent];
    }
    return self;
}

#pragma init

- (void)setDefault {
    self.status = Closed;
}

- (void)initComponent {
    contentView = [InstrumentPickContentView newInstance];
    [self addSubview:contentView];
}

#pragma action

- (void)openView {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] uneffectiveTouchBackView];
    [super openView];
}

- (void)closeView {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] effectiveTouchBackView];
    [super closeView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
