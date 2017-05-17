//
//  AboutContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AboutContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "ClientAPI.h"
#import "IosConfig.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@implementation AboutContentView

+ (AboutContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AboutContentView" owner:self options:nil];
    AboutContentView *contentView = [nib objectAtIndex:0];
    [contentView initContent];
    return contentView;
}

- (void)initContent {
    NSString *phoneNameString = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"PhoneNumberName"]];
    
    [_logoImageView     setImage:[UIImage imageNamed:@"images/logo/logoabout.png"]];
    [_bankTitle         setText:[[LangCaptain getInstance] getLangByCode:@"BankCode"]];
    [_sysTitle          setText:[[LangCaptain getInstance] getLangByCode:@"SystemCode"]];
    [_phoneNameTitle    setText:phoneNameString];
    [_phoneNumberLabel  setText:[[LangCaptain getInstance] getLangByCode:@"PhoneNumber"]];
    [_emailLabel        setText:[[LangCaptain getInstance] getLangByCode:@"EmailAddress"]];
    [_facebookLabel     setText:[[LangCaptain getInstance] getLangByCode:@"FacebookName"]];
    [_emailImageView    setImage:[UIImage imageNamed:@"images/logo/mail"]];
    [_facebookImageView setImage:[UIImage imageNamed:@"images/logo/facebook"]];
//    NSString *version = [NSString stringWithFormat:@"version:%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    [_version           setText:[NSString stringWithFormat:@"%@%@", [[IosConfig getInstance] getType], [[ClientAPI getInstance] version]]];
    [self addListener];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

#pragma action
- (void)phoneTouched {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ABOUT subType:APP_OPT_TYPE_ABOUT_ITEM_1];
    NSString *phoneNum = _phoneNumberLabel.text;
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]];
    
    UIWebView * webView = [[UIWebView alloc] init];
    [self addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (void)emailTouched {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ABOUT subType:APP_OPT_TYPE_ABOUT_ITEM_2];
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: _emailLabel.text];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
    //    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
    //    [mailUrl appendString:@"&subject=my email"];
    //添加邮件内容
    
    //[mailUrl appendString:@"&body=<b>email</b> body!"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (void)facebookTouched {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ABOUT subType:APP_OPT_TYPE_ABOUT_ITEM_3];
//    NSURL *myURL = [NSURL URLWithString: @"fb://profile/"];
    NSURL *myURL = [NSURL URLWithString: [[LangCaptain getInstance] getLangByCode:@"FacebookURL"]];
//    Boolean isOpen = [[UIApplication sharedApplication] openURL:myURL];
    [[UIApplication sharedApplication] openURL:myURL];
//    if (!isOpen) {
//        NSURL *facebookURL = [NSURL URLWithString:[[LangCaptain getInstance] getLangByCode:@"FacebookURL"]];
//        [[UIApplication sharedApplication] openURL:facebookURL];
//    }
}

#pragma listener
- (void)addListener {
    _phoneNumberLabel.userInteractionEnabled = true;
    UITapGestureRecognizer *phoneTpped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneTouched)];
    [_phoneNumberLabel addGestureRecognizer:phoneTpped];
    
    _emailLabel.userInteractionEnabled = true;
    UITapGestureRecognizer *emailTpped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emailTouched)];
    [_emailLabel addGestureRecognizer:emailTpped];
    
    _facebookLabel.userInteractionEnabled = true;
    UITapGestureRecognizer *facebookTpped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(facebookTouched)];
    [_facebookLabel addGestureRecognizer:facebookTpped];
}

@end
