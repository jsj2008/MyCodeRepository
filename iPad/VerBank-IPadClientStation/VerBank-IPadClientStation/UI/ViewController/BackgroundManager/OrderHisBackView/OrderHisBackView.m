//
//  OrderHisBackView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderHisBackView.h"
#import "OrderHisBackContentView.h"
#import "LayoutCenter.h"

@implementation OrderHisBackView

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
    contentView = [OrderHisBackContentView newInstance];
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
