//
//  SystemMainConfigView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "SystemMainConfigView.h"
#import "SystemMainConfigContentView.h"

@implementation SystemMainConfigView

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
    contentView = [SystemMainConfigContentView newInstance];
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
