//
//  PhonePinPwdContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PhonePinPwdContentView.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "ZLKeyboardView.h"
#import "LayoutCenter.h"
#import "IosLogic.h"
#import "CheckUtils.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "UIColor+CustomColor.h"

@interface PhonePinPwdContentView()<CustomAlertDelegate, ZLKeyboardDelegate> {}

@end

@implementation PhonePinPwdContentView

@synthesize titleLabel;
@synthesize textView;

@synthesize oPwdLabel;
@synthesize nPwdLabel;
@synthesize nPwdAgainLabel;
@synthesize oPwdTextField;
@synthesize nPwdTextField;
@synthesize nPwdAgainTextField;

@synthesize commitButton;
@synthesize backButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"PhonePinPwdChange"]];
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"CertificateChangeTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [textView setText:tempString];
    [textView setBackgroundColor:[UIColor clearColor]];
    
    [oPwdLabel      setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"CurrentPin"]]];
    [nPwdLabel      setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPin"]]];
    [nPwdAgainLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPinAgain"]]];
    
    [backButton     setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [commitButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"Comfirm"] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleSimpleNumber];
    self.oPwdTextField.inputView        = inputView;
    self.nPwdTextField.inputView        = inputView;
    self.nPwdAgainTextField.inputView   = inputView;
    
    [TextFieldUtil removeShortCutItem:self.oPwdTextField];
    [TextFieldUtil removeShortCutItem:self.nPwdTextField];
    [TextFieldUtil removeShortCutItem:self.nPwdAgainTextField];
    
    [self.oPwdTextField         setDelegate:(id)inputView];
    [self.nPwdTextField         setDelegate:(id)inputView];
    [self.nPwdAgainTextField    setDelegate:(id)inputView];
    
    [self.oPwdTextField         setSecureTextEntry:true];
    [self.nPwdTextField         setSecureTextEntry:true];
    [self.nPwdAgainTextField    setSecureTextEntry:true];
    
    [inputView setKeyboardDelegate:self];
    
    [self setBackgroundColor:[UIColor grayColor]];
}

- (void)resetContentView {
    [oPwdTextField      setText:@""];
    [nPwdTextField      setText:@""];
    [nPwdAgainTextField setText:@""];
}

- (void)backAction {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
}

- (void)commitAction {
    NSString *oPinString = oPwdTextField.text;
    NSString *nPinString = nPwdTextField.text;
    NSString *nPinAgainString = nPwdAgainTextField.text;
    
    if ([self isNull:oPinString] || [self isNull:nPinString] || [self isNull:nPinAgainString]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]
                                                            delegate:nil];
        return;
    }
    
    if (![nPinAgainString.uppercaseString isEqualToString:nPinString.uppercaseString]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordUnsame"]
                                                            delegate:nil];
        return;
    }
    
    Boolean PinIsRight = [CheckUtils isPhonePinLegal:nPinString];
    
    if (!PinIsRight) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]
                                                            delegate:nil];
        return;
    }
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int result = [[TradeApi getInstance] changePhonePinAccount:[[ClientAPI getInstance] accountID]
                                                       oldPhonePin:oPinString
                                                       newPhonePin:nPinString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            switch (result) {
                case USERIDENTIFY_RESULT_SUCCEED:
                    [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                                      andMessage:[[LangCaptain getInstance] getLangByCode:@"NewPinChangeSuccess"]
                                                                        delegate:self];
                    break;
                    
                default:
                    [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                      andMessage:[[LangCaptain getInstance] getPaswordResultByCode:[@(result) stringValue]]
                                                                        delegate:nil];
                    break;
            }
        });
    });
}

- (Boolean)isNull:(NSString *)string {
    if (string == nil) {
        return true;
    }
    
    if ([string length] == 0) {
        return true;
    }
    
    return false;
}

- (UIView *)getMainView {
    return [[[[IosLogic getInstance] uiWindow] rootViewController] view];
}

-(void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}
@end
