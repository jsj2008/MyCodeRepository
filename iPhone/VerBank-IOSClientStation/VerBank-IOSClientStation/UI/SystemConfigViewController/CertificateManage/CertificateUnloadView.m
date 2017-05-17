//
//  CertificateUnloadView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/23.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "CertificateUnloadView.h"
#import "LangCaptain.h"

@implementation CertificateUnloadView

@synthesize iphoneOrderLabel = _iphoneOrderLabel;
@synthesize passwordField = _passwordField;
@synthesize nextButton = _nextButton;

+ (CertificateUnloadView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CertificateUnloadView"
                                                 owner:self
                                               options:nil];
    CertificateUnloadView *certificateUnloadView = [nib objectAtIndex:0];
    [certificateUnloadView initContentView];
    return certificateUnloadView;
}

- (void)initContentView {
    [_iphoneOrderLabel setText:[[LangCaptain getInstance] getLangByCode:@"IphoneOrderPassword"]];
    [_nextButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Next"]
                 forState:UIControlStateNormal];
    [_passwordField setKeyboardType:UIKeyboardTypeNumberPad];
    [self setBackgroundColor:[UIColor blackColor]];
}

@end
