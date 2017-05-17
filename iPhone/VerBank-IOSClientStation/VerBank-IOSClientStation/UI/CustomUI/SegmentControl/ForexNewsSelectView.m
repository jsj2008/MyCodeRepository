//
//  ForexNewsSelecteView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ForexNewsSelectView.h"
#import "LangCaptain.h"

@implementation ForexNewsSelectView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initThirdSegment];
    }
    return self;
}

- (void)initThirdSegment {
    
    NSString *news = [[LangCaptain getInstance] getLangByCode:@"News"];
    NSString *economicData = [[LangCaptain getInstance] getLangByCode:@"EconomicData"];
    NSString *review = [[LangCaptain getInstance] getLangByCode:@"Review"];
    
    self.titleArray = @[news, economicData, review];
//    self.titleArray = @[news, review];
    self.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    self.selectIndex = 0;
    _normalTitleColor = DEFAULT_NORMAL_COLOR;
    _selectTitleColor = DEFAULT_SELECTE_COLOR;
    _backgroundColor = [UIColor backgroundColor];
    
    _cornerRadio = 16.0f;
    [self initLayout];
    [self initBtnOnView];
    [self setBackgroundColor:[UIColor backgroundColor]];
}

- (void)layoutSubviews {
    [self updateLayout];
}

@end
