//
//  OpenPositionFailed.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OpenPositionFailed.h"
#import "LangCaptain.h"
#import "UIFormat.h"

@implementation OpenPositionFailed

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize confirmButton = _confirmButton;
@synthesize titleLabel = _titleLabel;
@synthesize contentView = _contentView;

+ (OpenPositionFailed *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OpenPositionFailed" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
//    self.layer.cornerRadius = 10.0f;
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self];
    
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OpenTradeFaild"]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setBackgroundColor:[UIColor redColor]];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.confirmButton];
    [UIFormat setComplexRedButtonColor:self.confirmButton];
    
    [self.contentView setTextAlignment:NSTextAlignmentCenter];
    [self.contentView setFont:[UIFont boldSystemFontOfSize:15.0f]];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneNumber)];
    [self.contentView addGestureRecognizer:tapRecognizer];
    
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
}

- (void)callPhoneNumber {
    NSString *phoneNumber = [[LangCaptain getInstance] getLangByCode:@"PhoneNumber"];
    if ([_contentView.text containsString:phoneNumber]) {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]];
        
        UIWebView * webView = [[UIWebView alloc] init];
        [self addSubview:webView];
        [webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
}

@end
