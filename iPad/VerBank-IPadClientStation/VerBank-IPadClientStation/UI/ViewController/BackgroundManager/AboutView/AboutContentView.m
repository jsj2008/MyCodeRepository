//
//  AboutContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AboutContentView.h"
#import "LangCaptain.h"
#import "IosConfig.h"
#import "ClientAPI.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@implementation AboutContentView

@synthesize logoImageView;
@synthesize bankTitle;
@synthesize sysTitle;
@synthesize phoneNameTitle;
@synthesize phoneNumberLabel;
@synthesize emailImageView;
@synthesize emailLabel;
@synthesize facebookImageView;
@synthesize facebookLabel;
@synthesize version;

- (void)initContent {
    NSString *phoneNameString = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"PhoneNumberName"]];
    
    [self.logoImageView     setImage:[UIImage imageNamed:@"images/logo/logoabout.png"]];
    [self.bankTitle         setText:[[LangCaptain getInstance] getLangByCode:@"BankCode"]];
    [self.sysTitle          setText:[[LangCaptain getInstance] getLangByCode:@"SystemCode"]];
    [self.phoneNameTitle    setText:phoneNameString];
    [self.phoneNumberLabel  setText:[[LangCaptain getInstance] getLangByCode:@"PhoneNumber"]];
    [self.emailLabel        setText:[[LangCaptain getInstance] getLangByCode:@"EmailAddress"]];
    [self.facebookLabel     setText:[[LangCaptain getInstance] getLangByCode:@"FacebookName"]];
    [self.emailImageView    setImage:[UIImage imageNamed:@"images/logo/mail"]];
    [self.facebookImageView setImage:[UIImage imageNamed:@"images/logo/facebook"]];
    //    NSString *version = [NSString stringWithFormat:@"version:%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    [self.version           setText:[NSString stringWithFormat:@"%@%@", [[IosConfig getInstance] getType], [[ClientAPI getInstance] version]]];
    [self addListener];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

#pragma action
- (void)phoneTouched {
//    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ABOUT subType:APP_OPT_TYPE_ABOUT_ITEM_1];
//    NSString *phoneNum = self.phoneNumberLabel.text;
//    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]];
//    
//    UIWebView * webView = [[UIWebView alloc] init];
//    [self addSubview:webView];
//    [webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (void)emailTouched {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ABOUT subType:APP_OPT_TYPE_ABOUT_ITEM_2];
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: self.emailLabel.text];
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
    self.phoneNumberLabel.userInteractionEnabled = true;
    UITapGestureRecognizer *phoneTpped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneTouched)];
    [self.phoneNumberLabel addGestureRecognizer:phoneTpped];
    
    self.emailLabel.userInteractionEnabled = true;
    UITapGestureRecognizer *emailTpped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emailTouched)];
    [self.emailLabel addGestureRecognizer:emailTpped];
    
    self.facebookLabel.userInteractionEnabled = true;
    UITapGestureRecognizer *facebookTpped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(facebookTouched)];
    [self.facebookLabel addGestureRecognizer:facebookTpped];
}

@end
