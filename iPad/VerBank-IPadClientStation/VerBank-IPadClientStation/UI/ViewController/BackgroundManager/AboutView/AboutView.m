//
//  AboutView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AboutView.h"
#import "AboutContentView.h"

@implementation AboutView

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
    contentView = [AboutContentView newInstance];
    [self addSubview:contentView];
}

#pragma action
- (void)openView {
    [super openView];
}

- (void)closeView {
    [super closeView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
