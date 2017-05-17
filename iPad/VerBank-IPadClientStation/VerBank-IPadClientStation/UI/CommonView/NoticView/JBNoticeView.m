//
//  JBNoticeView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/5/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "JBNoticeView.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"

@implementation JBNoticeView

- (void)initContent {
    
    self.layer.cornerRadius = 10.0f;
    CGFloat width = 400.0f;
    CGFloat height = 170.0f;
    
    [self setFrame:CGRectMake((SCREEN_WIDTH - width) / 2, (SCREEN_HEIGHT - height) / 2, width, height)];
    
    [_titleLabel setBackgroundColor:[UIColor redDownColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
    
    
    [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"NoticeTitle"]];
    [_noticeLabel setText:[[LangCaptain getInstance] getLangByCode:@"SubNotice"]];
//    [_contentTextView setText:[[LangCaptain getInstance] getLangByCode:@"JBNoticeContent"]];
    [_contentTextView setEditable:false];
    [_contentTextView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    [_okButton addTarget:self
                  action:@selector(okAction:)
        forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_contentTextView scrollsToTop];
}

- (void)okAction:(id)sender {
    [[self superview]removeFromSuperview];
}

@end
