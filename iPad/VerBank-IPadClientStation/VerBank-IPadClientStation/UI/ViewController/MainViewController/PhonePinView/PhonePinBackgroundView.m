//
//  PhonePinBackgroundView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PhonePinBackgroundView.h"
#import "PhonePinInputView.h"
#import "IOSLayoutDefine.h"
#import "UIFormat.h"

@interface PhonePinBackgroundView() {
    PhonePinInputView *contentView;
}

@end

@implementation PhonePinBackgroundView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

#pragma init
- (void)initComponent {
    contentView = [PhonePinInputView newInstance];
    [self addSubview:contentView];
}

- (void)resetValue {
    [contentView.inputFeild setText:@""];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewHeight = SCREEN_HEIGHT / 8 * 2;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = (SCREEN_HEIGHT - contentViewHeight * 2) / 2;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    [contentView setFrame:contentViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:contentView withCorner:12.0f];
}


@end
