//
//  PhonePinInputView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/13.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "PhonePinInputView.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"
#import "LayoutCenter.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "ShowAlertManager.h"
#import "JumpDataCenter.h"
#import "PhonePinChecker.h"
#import "ZLKeyboardView.h"
#import "IosLogic.h"
#import "TradeActionUtil.h"

@interface PhonePinInputView()<ZLKeyboardDelegate>

@end

@implementation PhonePinInputView

@synthesize titleLabel = _titleLabel;
@synthesize inputLabel = _inputLabel;
@synthesize inputFeild = _inputField;
@synthesize commitButton = _commitButton;
@synthesize cancelButton = _cancelButton;

- (void)initContent {
    [self.titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self setBackgroundColor:[UIColor whiteColor]];
    [_commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
    [_cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    [_inputLabel setText:[[LangCaptain getInstance] getLangByCode:@"PhonePinInput"]];
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"PhonePin"]];
    
    [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    _inputField.keyboardType = UIKeyboardTypePhonePad;
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleSimpleNumber];
    _inputField.inputView        = inputView;
    [TextFieldUtil removeShortCutItem:_inputField];
    [_inputField        setDelegate:(id)inputView];
    [_inputField setSecureTextEntry:true];
    [inputView setKeyboardDelegate:self];
}

#pragma mark action

- (void)cancelAction {
    [_inputField resignFirstResponder];
    [[[LayoutCenter getInstance] mainViewLayoutCenter] removePhonePinView];
}

- (void)commitAction {
    [_inputField resignFirstResponder];
    
    if (_inputField.text == nil || [_inputField.text isEqualToString:@""]) {
        [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                           andMessage:[[LangCaptain getInstance] getLangByCode:@"PleaseInputPWd"]
                                                             delegate:nil];
        return;
    }
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"]
                                                          onView:[[[[IosLogic getInstance] uiWindow] rootViewController] view]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int result = [[TradeApi getInstance] checkAccount:[[ClientAPI getInstance] accountID] phonePin:_inputField.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            if (result == CA_TRADE_SUCCEED) {
                [[JumpDataCenter getInstance] setPhonePin:_inputField.text];
                [[JumpDataCenter getInstance] resetPhonePinErr];
                [[PhonePinChecker getInstance] resetTimeTick];
                
                [[[LayoutCenter getInstance] mainViewLayoutCenter] removePhonePinView];
                [[TradeActionUtil getInstance] doTradeByFunction];
            } else {
                if (result == USERIDENTIFY_RESULT_ERR_NETERR) {
                    [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                       andMessage:[[LangCaptain getInstance] getResultByCode:[@(USERIDENTIFY_RESULT_ERR_NETERR) stringValue]]
                                                                         delegate:nil];
                    return;
                }
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinErr"]
                                                                     delegate:nil];
                [[JumpDataCenter getInstance] phonePinErr];
            }
        });
    });
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

@end
