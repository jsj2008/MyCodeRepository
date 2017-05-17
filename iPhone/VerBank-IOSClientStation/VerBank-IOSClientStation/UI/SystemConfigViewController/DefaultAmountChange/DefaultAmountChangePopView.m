//
//  DefaultAmountChangePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "DefaultAmountChangePopView.h"
#import "UIFormat.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "ClientSystemConfig.h"
#import "DecimalUtil.h"
#import "SystemConfigContentView.h"
#import "ShowAlert.h"

@interface DefaultAmountChangePopView(){
    // 为了更新
    SystemConfigContentView *_systemConfigView;
}

@end

@implementation DefaultAmountChangePopView

//@synthesize _yesButton;
//@synthesize _noButton;

@synthesize index = _index;

- (void)setTarget:(SystemConfigContentView *)systemConfigView {
    _systemConfigView = systemConfigView;
}

+ (DefaultAmountChangePopView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DefaultAmountChangePopView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:10.0f];
    
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"CustomAmount"]];
    [_titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_priceLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]]];
    
    [_yesButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Comfirm"] forState:UIControlStateNormal];
    [UIFormat setViewStyle:_yesButton
       withBackgroundColor:nil
        andTextNormalColor:[UIColor whiteColor]
          andTextHighColor:[UIColor whiteColor]
               andTextFont:nil
                 andCorner:UIRectCornerAllCorners];
    [UIFormat setComplexBlueButtonColor:_yesButton];
    
    [_noButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    [UIFormat setViewStyle:_noButton
       withBackgroundColor:nil
        andTextNormalColor:[UIColor whiteColor]
          andTextHighColor:[UIColor whiteColor]
               andTextFont:nil
                 andCorner:UIRectCornerAllCorners];
    [UIFormat setComplexBlueButtonColor:_noButton];
    
    _inputTextField.text = [[[ClientSystemConfig getInstance] amountCustomArray] objectAtIndex:_index];
    _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_inputTextField selectAll:self];
    //    _inputTextField.keyboardType = UIKeyboardTypePhonePad;
    [_inputTextField becomeFirstResponder];
}

- (IBAction)confirmAction:(id)sender{
    
    double replaceValue = [self getDoubleValue:_inputTextField.text];
    if (replaceValue < 200000 || replaceValue > 3000000) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"CustomAmountNotice"]];
        return;
    }
    
    NSString *replaceString = [DecimalUtil formatNumber:[self getDoubleValue:_inputTextField.text]];
    
    
    
    NSMutableArray *array = [[ClientSystemConfig getInstance] amountCustomArray];
    
    [array replaceObjectAtIndex:_index withObject:replaceString];
    //    [[ClientSystemConfig getInstance] setAmountCustomArray:array];
    [[ClientSystemConfig getInstance] saveConfigData];
    
    [_systemConfigView tableUpdate];
    
    [self.superview removeFromSuperview];
}

- (IBAction)cancelAction:(id)sender{
    [self.superview removeFromSuperview];
}

- (void)returnKeyboard {
    [_inputTextField resignFirstResponder];
}

- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

@end
