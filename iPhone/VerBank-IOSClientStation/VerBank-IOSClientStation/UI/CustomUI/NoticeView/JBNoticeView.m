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
#import "UIFormat.h"

@implementation JBNoticeView

+ (JBNoticeView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JBNoticeView" owner:self options:nil];
    JBNoticeView *view = (JBNoticeView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
    
    self.layer.cornerRadius = 10.0f;
    [self setFrame:CGRectMake(60, (SCREEN_HEIGHT - 170) / 2, SCREEN_WIDTH - 120, 170)];
    
    [_titleLabel setBackgroundColor:[UIColor redDownColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
    
    
    [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"NoticeTitle"]];
    [_subnoticeLabel setText:[[LangCaptain getInstance] getLangByCode:@"SubNotice"]];
//    [_contentTextView setText:[[LangCaptain getInstance] getLangByCode:@"JBNoticeContent"]];
    [_contentTextView setEditable:false];
    [_contentTextView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    [_okButton addTarget:self
                  action:@selector(okAction:)
        forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [_okButton sizeToFit];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_okButton];
//    [UIFormat setComplexBlueButtonColor:_okButton];
    [UIFormat setComplexRedButtonColor:_okButton];
    [_contentTextView scrollsToTop];
    [_okButton layoutIfNeeded];
}

- (void)okAction:(id)sender {
    [[self superview]removeFromSuperview];
}

@end
