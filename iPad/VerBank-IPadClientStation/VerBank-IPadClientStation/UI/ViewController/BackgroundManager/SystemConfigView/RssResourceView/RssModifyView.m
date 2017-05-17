//
//  RssModifyView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "RssModifyView.h"
#import "RssModifyContentView.h"
#import "LayoutCenter.h"

@implementation RssModifyView

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
    contentView = [RssModifyContentView newInstance];
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
