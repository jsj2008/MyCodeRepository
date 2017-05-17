//
//  BackgoundContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BackgoundContentView.h"
#import "UIFormat.h"
#import "IOSLayoutDefine.h"

#import "TextFieldController.h"

@interface BackgoundContentView () {
    MainViewStyle _currentStyle;
}

@end

@implementation BackgoundContentView

@synthesize status;
@synthesize contentArray;

- (id)init {
    if (self = [super init]) {
        [self setStyle:MainViewStyleMiddle];
    }
    return self;
}

- (void)openView {
    NSLog(@"this is super open view.");
    [[TextFieldController getInstance] keyboardReturen];
    for (UIView *view in [[self superview] subviews]) {
        if ([view isKindOfClass:[BackgoundContentView class]]) {
            if ([(BackgoundContentView *)view status] == Opened) {
                [(BackgoundContentView *)view closeView];
            }
        }
    }
    
    [contentView resetContentView];
    [contentView addListener];
    [[self superview] setHidden:false];
    [self setHidden:false];
    self.status = Opened;
}

- (void)closeView {
    NSLog(@"this is super close view.");
    self.status = Closed;
    
    [contentView removeListener];
    [[self superview] setHidden:true];
    [self setHidden:true];
}

- (void)setStyle:(MainViewStyle)style {
    _currentStyle = style;
    switch (style) {
        case MainViewStyleBig:
            [self setBigStyle];
            break;
        case MainViewStyleMiddle:
            [self setMiddleStyle];
            break;
        case MainViewStyleSmall:
            [self setSmallStyle];
            break;
        case MainViewStyleHalf:
            [self setHalfStyle];
            break;
        case MainViewStyleFullScreen:
            [self setFullScreenStyle];
            break;
        default:
            break;
    }
}

- (void)setBigStyle {
    CGFloat contentViewWidth = SCREEN_WIDTH - 30;
    CGFloat contentViewHeight = SCREEN_HEIGHT / 4 * 3;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = (SCREEN_HEIGHT - contentViewHeight) / 2;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    [self setFrame:contentViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:12.0f];
}

- (void)setFullScreenStyle {
    CGFloat contentViewWidth = SCREEN_WIDTH;
    CGFloat contentViewHeight = SCREEN_HEIGHT - 70;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = 70;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    [self setFrame:contentViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:12.0f];
}

- (void)setMiddleStyle {
//    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewHeight = SCREEN_HEIGHT / 4 * 3;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = (SCREEN_HEIGHT - contentViewHeight) / 2;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    [self setFrame:contentViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:12.0f];
}

- (void)setSmallStyle {
//    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewHeight = SCREEN_HEIGHT / 8 * 2;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = (SCREEN_HEIGHT - contentViewHeight) / 2;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    [self setFrame:contentViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:12.0f];
}

- (void)setHalfStyle {
//    CGFloat contentViewWidth = SCREEN_WIDTH / 2;
    CGFloat contentViewWidth = SCREEN_WIDTH / 3;
    CGFloat contentViewHeight = SCREEN_HEIGHT / 2;
    CGFloat contentViewLeft = (SCREEN_WIDTH - contentViewWidth) / 2;
    CGFloat contentViewTop = (SCREEN_HEIGHT - contentViewHeight) / 2;
    CGRect contentViewRect = CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight);
    [self setFrame:contentViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:12.0f];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self setStyle:_currentStyle];
    [contentView setFrame:self.bounds];
}

@end
