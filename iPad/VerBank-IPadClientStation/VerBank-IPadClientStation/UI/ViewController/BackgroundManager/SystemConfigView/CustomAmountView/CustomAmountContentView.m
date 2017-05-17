//
//  CustomAmountContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CustomAmountContentView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "JumpDataCenter.h"
#import "ClientSystemConfig.h"
#import "ShowAlertManager.h"
#import "DecimalUtil.h"
#import "LayoutCenter.h"
#import "ZLKeyboardView.h"

@interface CustomAmountContentView() <ZLKeyboardDelegate>

@end

@implementation CustomAmountContentView

@synthesize titleLabel;
@synthesize amountLabel;
@synthesize amountTextField;
@synthesize commitButton;
@synthesize cancelButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"CustomAmount"]];
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [amountLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]]];
    
    [commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Comfirm"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
//    amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleSimpleNumber];
    self.amountTextField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.amountTextField];
    [self.amountTextField  setDelegate:(id)inputView];
    [inputView setKeyboardDelegate:self];
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)resetContentView {
    NSInteger index = [[JumpDataCenter getInstance] customAmountIndex];
    [amountTextField setText:[[[ClientSystemConfig getInstance] amountCustomArray] objectAtIndex:index]];
    [amountTextField selectAll:amountTextField];
}

- (void)commitAction {
    NSInteger index = [[JumpDataCenter getInstance] customAmountIndex];
    double replaceValue = [self getDoubleValue:amountTextField.text];
    if (replaceValue < 200000 || replaceValue > 3000000) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"CustomAmountNotice"]
                                                            delegate:nil];
        return;
    }
    
    NSString *replaceString = [DecimalUtil formatNumber:[self getDoubleValue:amountTextField.text]];
    
    NSMutableArray *array = [[ClientSystemConfig getInstance] amountCustomArray];
    
    [array replaceObjectAtIndex:index withObject:replaceString];
    [[ClientSystemConfig getInstance] saveConfigData];
    
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];

}

- (void)cancelAction {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
}

- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

@end
