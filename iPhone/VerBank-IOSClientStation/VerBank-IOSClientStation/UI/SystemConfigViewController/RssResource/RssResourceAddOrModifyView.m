//
//  RssResourceAddOrModifyView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/16.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "RssResourceAddOrModifyView.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "LangCaptain.h"
#import "ClientSystemConfig.h"
//#import "ZLKeyboard.h"

@interface RssResourceAddOrModifyView()<UITextFieldDelegate>{
    // 为了更新
    RssResourcePopView *_rssResourcePopView;
//    ZLKeyboard *_keyboard;
}

@end


@implementation RssResourceAddOrModifyView

@synthesize index = _index;
@synthesize titleString = _titleString;

- (void)setTarget:(RssResourcePopView *)rssResourcePopView {
    _rssResourcePopView = rssResourcePopView;
}

+ (RssResourceAddOrModifyView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"RssResourceAddOrModifyView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:10.0f];
    
//    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"RssModify"]];
    [_titleLabel setText:_titleString];
    [_titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_rssLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"RssURL"]]];
    
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
    
    if (_index != -1) {
        _inputTextField.text = [[[ClientSystemConfig getInstance] rssResourceArray] objectAtIndex:_index];
    } else {
        _inputTextField.text = @"";
    }
    
    //    _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //    [_inputTextField setInputView:<#(UIView * _Nullable)#>]
//    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:LoginNumberKeyboard];
//    _keyboard = keyboard;
//    _keyboard.delegate = self;
//    _inputTextField.inputView = _keyboard;
    [_inputTextField setDelegate:self];
    [_inputTextField selectAll:self];
//    //    _inputTextField.keyboardType = UIKeyboardTypePhonePad;
    [_inputTextField becomeFirstResponder];
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_keyboard setCurrentTextField:textField];
//    [_keyboard resetInputString:textField.text];
//}

- (IBAction)confirmAction:(id)sender{
    
    //    NSString *replaceString = [DecimalUtil formatNumber:[self getDoubleValue:_inputTextField.text]];
    
    NSMutableArray *array = [[ClientSystemConfig getInstance] rssResourceArray];
    
    if (_index == -1) {
        [array addObject:_inputTextField.text];
    } else {
        [array replaceObjectAtIndex:_index withObject:_inputTextField.text];
    }
    
    //    [array replaceObjectAtIndex:_index withObject:replaceString];
    [[ClientSystemConfig getInstance] saveConfigData];
    
    //    [_systemConfigView tableUpdate];
    [_rssResourcePopView updateTable];
    
    [self.superview removeFromSuperview];
}

- (IBAction)cancelAction:(id)sender{
    [self.superview removeFromSuperview];
}

- (void)returnKeyboard {
    [_inputTextField resignFirstResponder];
}

//#pragma keyboardDelegate
//
//- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string{
//    _keyboard.currentTextField.text = string;
//}
//
//- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string {
//}

//- (void)keyboardReturn {
//    [_keyboard.currentTextField resignFirstResponder];
//}

@end
