//
//  OpenFailedView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenFailedView.h"
#import "OpenFailedContentView.h"
#import "LayoutCenter.h"

@implementation OpenFailedView

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
    contentView = [OpenFailedContentView newInstance];
    [self addSubview:contentView];
}

#pragma action

- (void)openView {
    [super openView];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] uneffectiveTouchBackView];
}

- (void)closeView {
    [super closeView];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] effectiveTouchBackView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
