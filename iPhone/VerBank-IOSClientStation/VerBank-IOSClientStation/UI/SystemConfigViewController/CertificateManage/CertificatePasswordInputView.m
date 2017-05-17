//
//  CertificatePasswordInputView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/23.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "CertificatePasswordInputView.h"
#import "LangCaptain.h"

@implementation CertificatePasswordInputView

@synthesize certficateLabel = _certificateLabel;
@synthesize passwordField = _passwordField;
@synthesize downloadButton = _downloadButton;
@synthesize textView = _textView;

+ (CertificatePasswordInputView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CertificatePasswordInputView"
                                                owner:self
                                              options:nil];
    CertificatePasswordInputView *certificatePasswordInputView = [nib objectAtIndex:0];
    [certificatePasswordInputView initContentView];
    return [nib objectAtIndex:0];
}

- (void)initContentView {
    [_certificateLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificatePasswordSet"]];
    [_downloadButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Download"]
                     forState:UIControlStateNormal];
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"CertificatePasswordChangeTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [_textView setText:tempString];
    [_textView setEditable:false];
    [self setBackgroundColor:[UIColor blackColor]];
}

@end
