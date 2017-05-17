//
//  ZLKeyboardSuperView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/1.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ZLKeyboardSuperView.h"

@interface ZLKeyboardSuperView() {
    Boolean _isUpState;
    Boolean _clickable;
}

@end

@implementation ZLKeyboardSuperView

//@synthesize clickable;
- (void)setClickable:(Boolean)clickable {
    _clickable = clickable;
    for (UIView *view in [self subviews]) {
        [view setUserInteractionEnabled:clickable];
    }
}

- (Boolean)clickable {
    return _clickable;
}

- (void)initContent {
    _isUpState = false;
    self.clickable = true;
}

- (void)changeUpState {
    _isUpState = !_isUpState;
    [self updateButtonTitle];
}

- (void)updateButtonTitle {
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            if (_isUpState) {
                [button setTitle:[[button currentTitle] uppercaseString] forState:UIControlStateNormal];
            } else {
                [button setTitle:[[button currentTitle] lowercaseString] forState:UIControlStateNormal];
            }
        }
    }
}

@end
