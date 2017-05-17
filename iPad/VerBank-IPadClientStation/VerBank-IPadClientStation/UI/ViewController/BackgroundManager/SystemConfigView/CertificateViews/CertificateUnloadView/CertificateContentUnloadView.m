//
//  CertificateContentUnloadView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CertificateContentUnloadView.h"
#import "LangCaptain.h"
#import "ShowAlertManager.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "JumpDataCenter.h"
#import "LayoutCenter.h"
#import "ActionUtils.h"
#import "ZLKeyboardView.h"
#import "UIColor+CustomColor.h"
#import "TextFieldUtil.h"

@interface CertificateContentUnloadView() <ZLKeyboardDelegate>

@end

@implementation CertificateContentUnloadView

@synthesize titleLabel;
@synthesize backButton;

@synthesize iphoneOrderLabel;
@synthesize passwordField;
@synthesize nextButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"CertificateManagement"]];
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    
    [iphoneOrderLabel setText:[[LangCaptain getInstance] getLangByCode:@"IphoneOrderPassword"]];
    [nextButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Next"]
                forState:UIControlStateNormal];
    [passwordField setKeyboardType:UIKeyboardTypeNumberPad];
    [self setBackgroundColor:[UIColor grayColor]];
    
    [nextButton addTarget:self action:@selector(unloadNextGap) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:[ActionUtils getInstance]
                   action:@selector(showSystemConfigView)
         forControlEvents:UIControlEventTouchUpInside];
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleSimpleNumber];
    self.passwordField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.passwordField];
    [self.passwordField  setDelegate:(id)inputView];
    [inputView setKeyboardDelegate:self];
    [self.passwordField setSecureTextEntry:true];
}

- (void)resetContentView {
    [passwordField setText:@""];
}

#pragma action

- (void)unloadNextGap {
    NSString *phonePin = self.passwordField.text;
    if (phonePin == nil || [phonePin isEqualToString:@""]) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinIsNil"]
                                                             delegate:nil];
        return;
    }
    // 检查下单密码是否正确
    int checkType = [self checkPhonePin];
    if (checkType == USERIDENTIFY_RESULT_ERR_NETERR) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"ERR_NetErr"]
                                                             delegate:nil];
        return;

    }
    
    if (checkType != CA_TRADE_SUCCEED) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinErr"]
                                                             delegate:nil];
        [[JumpDataCenter getInstance] phonePinErr];
        return;
    }
    
    // 接下來顯示 要輸入憑證密碼
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showCertificatePwdInputView];
}

- (int)checkPhonePin {
    long long account = [[ClientAPI getInstance] accountID];
    NSString *phonePin = self.passwordField.text;
    int checkType = [[TradeApi getInstance] checkAccount:account
                                                phonePin:phonePin];
    if (checkType == CA_TRADE_SUCCEED) {
        [[JumpDataCenter getInstance] resetPhonePinErr];
    }
    return checkType;
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

@end
