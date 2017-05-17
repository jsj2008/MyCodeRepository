//
//  LoginSegmentControl.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/2.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LoginSegmentControl.h"
#import "LangCaptain.h"

@implementation LoginSegmentControl

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        [self initLoginSegment];
    }
    return self;
}

- (void)initLoginSegment {
    NSString *liveAccountLang = [[LangCaptain getInstance] getLangByCode:@"LiveAccount"];
    NSString *demoAccountLang = [[LangCaptain getInstance] getLangByCode:@"DemoAccount"];
    self.titleFont = [UIFont systemFontOfSize:10.0f];
    NSArray *array = @[liveAccountLang, demoAccountLang];
    self.titleArray = array;
    self.selectIndex = 0;
    _normalTitleColor = DEFAULT_NORMAL_COLOR;
    _selectTitleColor = DEFAULT_SELECTE_COLOR;
    _backgroundColor = [UIColor backgroundColor];
    
//    [self initLayoutWithFrame:self.frame];
    _cornerRadio = 8.0f;
    [self initLayout];
    [self initBtnOnView];
    [self setBackgroundColor:[UIColor clearColor]];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [self initLoginSegment];
//}

- (void)updateTitle:(NSArray *)array {
    self.titleArray = array;
    [self changeBtnTitle];
}

- (void)layoutSubviews {
    [self initLoginSegment];
    [self updateLayout];
    
}

@end
