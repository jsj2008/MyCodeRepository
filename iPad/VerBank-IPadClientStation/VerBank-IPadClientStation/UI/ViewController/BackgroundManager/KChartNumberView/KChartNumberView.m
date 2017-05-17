//
//  KChartNumberView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "KChartNumberView.h"
#import "KChartNumberContentView.h"
#import "LayoutCenter.h"

@implementation KChartNumberView

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
    contentView = [KChartNumberContentView newInstance];
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
