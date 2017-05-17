//
//  NoticeView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "NoticeView.h"
#import "IosLayoutDefine.h"
#import "UIFormat.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"

@implementation NoticeView

+ (NoticeView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NoticeView" owner:self options:nil];
    NoticeView *view = (NoticeView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}
//
//- (void)initContentView {
//    
//    self.layer.cornerRadius = 10.0f;
//    [self setFrame:CGRectMake(30, SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT, SCREEN_WIDTH - 60, SCREEN_HEIGHT - (SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT) * 2)];
//    
//    [_titleLabel setTextColor:[UIColor blueButtonColor]];
//    
//    [_okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
//
//    
//    [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"NoticeTitle"]];
//    [_contentTextView setText:[[LangCaptain getInstance] getLangByCode:@"NoticeContent"]];
//    [_contentTextView setEditable:false];
//    [_contentTextView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
//    [_okButton addTarget:self
//                  action:@selector(okAction:)
//        forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
////    [_okButton sizeToFit];
//    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_okButton];
//    [UIFormat setComplexBlueButtonColor:_okButton];
//    [_contentTextView scrollsToTop];
//    [_okButton layoutIfNeeded];
//}
//
//- (void)okAction:(id)sender {
//    [[self superview]removeFromSuperview];
//}

- (void)initContentView {
    
    self.layer.cornerRadius = 10.0f;
    [self setFrame:CGRectMake(30, SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT, SCREEN_WIDTH - 60, SCREEN_HEIGHT - (SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT) * 2)];
    
    [_titleLabel setTextColor:[UIColor blueButtonColor]];
    
    [_okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
    
    
    [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"NoticeTitle"]];
    //    NSMutableString *tempString = [NSMutableString stringWithFormat:@"%@",[[LangCaptain getInstance] getLangByCode:@"NoticeContent"]];
    //    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    //    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    //    [_contentTextView setText:tempString];
    [_contentTextView setEditable:false];
    [_contentTextView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    [_okButton addTarget:self
                  action:@selector(okAction:)
        forControlEvents:UIControlEventTouchUpInside];
}

- (void)setShowViewTitle:(NSString *)title {
    [_titleLabel setText:title];
}

- (void)setShowViewContent:(NSString *)content {
    NSMutableString *tempString = [NSMutableString stringWithFormat:@"%@",content];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [_contentTextView setText:tempString];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [_okButton sizeToFit];
    //    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_okButton];
    //    [UIFormat setComplexBlueButtonColor:_okButton];
//    [_contentTextView scrollsToTop];
    //    [_okButton layoutIfNeeded];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_okButton];
    [UIFormat setComplexBlueButtonColor:_okButton];
    [_contentTextView scrollsToTop];
    [_okButton layoutIfNeeded];
}

- (void)okAction:(id)sender {
    [[self superview]removeFromSuperview];
}

@end
