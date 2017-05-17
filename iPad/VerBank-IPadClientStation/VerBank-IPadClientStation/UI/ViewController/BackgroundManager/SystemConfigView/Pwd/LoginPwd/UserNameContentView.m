//
//  UserNameContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/7/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "UserNameContentView.h"
#import "LangCaptain.h"
#import "ShowAlertManager.h"
#import "ClientAPI.h"
#import "CheckUtils.h"
#import "TradeApi.h"
#import "IosLogic.h"
#import "LoginViewController.h"
#import "UIColor+CustomColor.h"
#import "ZLKeyboardView.h"

@interface UserNameContentView() <ZLKeyboardDelegate>

@end

@implementation UserNameContentView

@synthesize userNameField = _userNameField;

- (void)initContent {
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"UserNameInput"]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [_textView setFont:[UIFont systemFontOfSize:18.0f]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.userInteractionEnabled = false;
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"UserNameTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [_textView setText:tempString];
    //    [_textView setText:[[[LangCaptain getInstance] getLangByCode:@"UserNameTextView"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [_userNameLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"UserNameInput"]]];
    //    [_userNameLabel setTextColor:[UIColor whiteColor]];
    
    [_confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Modify"] forState:UIControlStateNormal];
    
    [_confirmButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLoginNumber];
    _userNameField.inputView        = inputView;
    
    [TextFieldUtil removeShortCutItem:_userNameField];
    
    [_userNameField         setDelegate:(id)inputView];
    
    [inputView setKeyboardDelegate:self];
    
    [self.layer setCornerRadius:10.0f];
    
    [self setBackgroundColor:[UIColor grayColor]];
}

//- (void)layoutSubviews {
////    [_textView setTextColor:[UIColor whiteColor]];
//
//    //    [self setBackgroundColor:[UIColor backgroundColor]];
//}

- (void)commitAction {
    //    UIView *superview = [self superview];
    //    if ([superview respondsToSelector:@selector(keyboardReturn)]) {
    //        [superview performSelector:@selector(keyboardReturn) withObject:nil];
    //    }
    //    [ResizeForKeyboard setViewPosition:superview forY:0];
    
    NSString *userNameString = _userNameField.text;
    
    if ([self isNull:userNameString] || [self isNull:userNameString] || [self isNull:userNameString]) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]
                                                            delegate:nil];
        return;
    }
    
    NSString *accid = [@([[ClientAPI getInstance] accountID]) stringValue];
    Boolean passwordIsRight = [CheckUtils isPwdLegal:userNameString accountID:accid];
    
    if (!passwordIsRight) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]
                                                            delegate:nil];
        return;
    }
    
    TradeResult *reslut = [[TradeApi getInstance] changeUserName:userNameString];
    
    if ([reslut succeed]) {
        //
        UIViewController *viewController = [[[IosLogic getInstance] uiWindow] rootViewController];
        if ([viewController isKindOfClass:[LoginViewController class]]) {
            [((LoginViewController *)viewController) login];
        }
    } else {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getPaswordResultByCode:[reslut errCode]]
                                                            delegate:nil];
    }
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

- (void)resetTextField {
    [_userNameField setText:@""];
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

@end
