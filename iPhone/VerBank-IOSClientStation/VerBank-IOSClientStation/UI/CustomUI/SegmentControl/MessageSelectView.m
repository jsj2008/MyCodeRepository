//
//  MessageSelectView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MessageSelectView.h"
#import "LangCaptain.h"

@implementation MessageSelectView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initThirdSegment];
    }
    return self;
}

- (void)initThirdSegment {
    
    NSString *noticeInformation = [[LangCaptain getInstance] getLangByCode:@"NoticeInformation"];
//    NSString *economicData = [[LangCaptain getInstance] getLangByCode:@"EconomicData"];
    NSString *pushInformation = [[LangCaptain getInstance] getLangByCode:@"PushInformation"];
    
        self.titleArray = @[noticeInformation, pushInformation];
    //    self.titleArray = @[noticeInformation,economicData, pushInformation];
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
