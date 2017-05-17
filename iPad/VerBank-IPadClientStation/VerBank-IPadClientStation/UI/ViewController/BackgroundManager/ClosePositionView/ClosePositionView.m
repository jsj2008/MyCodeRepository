//
//  ClosePositionView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/31.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ClosePositionView.h"
#import "ClosePositionContentView.h"
#import "LayoutCenter.h"

@implementation ClosePositionView

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
    contentView = [ClosePositionContentView newInstance];
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

- (void)doTrade {
    [(ClosePositionContentView *)contentView doCloseTrade];
}

@end