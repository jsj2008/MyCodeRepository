//
//  LoginPwdContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LoginPwdContentView.h"
#import "LangCaptain.h"
#import "ResizeForKeyboard.h"
#import "ShowAlertManager.h"
#import "ClientAPI.h"
#import "CheckUtils.h"
#import "TradeApi.h"
#import "IosLogic.h"
#import "LayoutCenter.h"
#import "ZLKeyboardView.h"
#import "UIColor+CustomColor.h"

#import "LoginViewController.h"
#import "IosLogic.h"

@interface LoginPwdContentView()<CustomAlertDelegate, ZLKeyboardDelegate>

@end

@implementation LoginPwdContentView

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
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"LoginPwdChange"]];
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"PasswordChangeTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [textView setText:tempString];
    [textView setBackgroundColor:[UIColor clearColor]];
    
    [oPwdLabel      setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"CurrentPassword"]]];
    [nPwdLabel      setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPassword"]]];
    [nPwdAgainLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPasswordAgain"]]];
    
    [backButton     setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [commitButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"Comfirm"] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLoginNumber];
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
    
    [self.layer setCornerRadius:10.0f];
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
    //    UIView *superview = [self superview];
    //    if ([superview respondsToSelector:@selector(keyboardReturn)]) {
    //        [superview performSelector:@selector(keyboardReturn) withObject:nil];
    //    }
    //    [ResizeForKeyboard setViewPosition:superview forY:0];
    [oPwdTextField resignFirstResponder];
    [nPwdTextField resignFirstResponder];
    [nPwdAgainTextField resignFirstResponder];
    
    NSString *oPwdString = oPwdTextField.text;
    NSString *nPwdString = nPwdTextField.text;
    NSString *nPwdAgainString = nPwdAgainTextField.text;
    
    if ([self isNull:oPwdString] || [self isNull:nPwdString] || [self isNull:nPwdAgainString]) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]
                                                             delegate:nil];
        return;
    }
    
    if (![nPwdString.uppercaseString isEqualToString:nPwdAgainString.uppercaseString]) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordUnsame"]
                                                             delegate:nil];
        return;
    }
    
    NSString *accid = [@([[ClientAPI getInstance] accountID]) stringValue];
    Boolean passwordIsRight = [CheckUtils isPwdLegal:nPwdString accountID:accid];
    
    if (!passwordIsRight) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]
                                                             delegate:nil];
        return;
    }
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:[self getMainView]];
    UIViewController *viewController = [[[IosLogic getInstance] uiWindow] rootViewController];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int reslut = [[TradeApi getInstance] changePassword:oPwdString newPassword:nPwdString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            switch (reslut) {
                case USERIDENTIFY_RESULT_SUCCEED:
                    if ([viewController isKindOfClass:[LoginViewController class]]) {
                        [((LoginViewController *)viewController) checkNeedChangeUserName];
                    } else {
                        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"NewPasswordChangeSuccess"]
                                                                             delegate:self];
                    }
                    break;
                    
                default:
                    [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                       andMessage:[[LangCaptain getInstance] getPaswordResultByCode:[@(reslut) stringValue]]
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
