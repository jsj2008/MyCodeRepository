//
//  PasswordChangePopContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PasswordChangePopContentView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "ShowAlert.h"
#import "LangCaptain.h"
#import "PWDCheckUtil.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "MTP4CommDataInterface.h"
#import "ResizeForKeyboard.h"
#import "PasswordChangePopView.h"
#import "IosLogic.h"
#import "LoginViewController.h"

@implementation PasswordChangePopContentView

@synthesize oPasswordField = _oPasswordField;
@synthesize nPasswordField = _nPasswordField;
@synthesize nPasswordAgainField = _nPasswordAgainField;

+ (PasswordChangePopContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PasswordChangePopContentView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:18.0f]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.userInteractionEnabled = false;
    
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"PasswordChangeTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [_textView setText:tempString];
    
    [_oPasswordLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"CurrentPassword"]]];
    [_oPasswordLabel setTextColor:[UIColor whiteColor]];
    
    [_nPasswordLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPassword"]]];
    [_nPasswordLabel setTextColor:[UIColor whiteColor]];
    
    [_nPasswordAgainLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPasswordAgain"]]];
    [_nPasswordAgainLabel setTextColor:[UIColor whiteColor]];
    
    [_confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Comfirm"] forState:UIControlStateNormal];
    [UIFormat setViewStyle:_confirmButton
       withBackgroundColor:nil
        andTextNormalColor:[UIColor whiteColor]
          andTextHighColor:[UIColor whiteColor]
               andTextFont:nil
                 andCorner:UIRectCornerAllCorners];
    [UIFormat setComplexBlueButtonColor:_confirmButton];
    [_confirmButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setBackgroundColor:[UIColor backgroundColor]];
}

- (void)commitAction {
    UIView *superview = [self superview];
    if ([superview respondsToSelector:@selector(keyboardReturn)]) {
        [superview performSelector:@selector(keyboardReturn) withObject:nil];
    }
    [ResizeForKeyboard setViewPosition:superview forY:0];
    
    
    NSString *oPasswordString = _oPasswordField.text;
    NSString *nPasswordString = _nPasswordField.text;
    NSString *nPasswordAgainString = _nPasswordAgainField.text;
    
    if ([self isNull:oPasswordString] || [self isNull:nPasswordString] || [self isNull:nPasswordAgainString]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]];
        return;
    }
    
    if (![nPasswordAgainString.uppercaseString isEqualToString:nPasswordString.uppercaseString]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordUnsame"]];
        return;
    }
    
    NSString *accid = [@([[ClientAPI getInstance] getAccount]) stringValue];
    Boolean passwordIsRight = [PWDCheckUtil isPwdLegal:_nPasswordField.text accountID:accid];
    
    if (!passwordIsRight) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]];
        return;
    }
    
    int reslut = [[TradeApi getInstance] changePassword:oPasswordString newPassword:nPasswordString];
    UIViewController *viewController = [[[IosLogic getInstance] getWindow] rootViewController];
    switch (reslut) {
        case USERIDENTIFY_RESULT_SUCCEED:
            
            if ([viewController isKindOfClass:[LoginViewController class]]) {
                [((LoginViewController *)viewController) checkNeedChangeUserName];
            } else {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"NewPasswordChangeSuccess"]];
//                [self.superview removeFromSuperview];
            }
            [self resetTextField];
            break;
            
        default:
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getPaswordResultByCode:[@(reslut) stringValue]]];
            break;
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
    [_oPasswordField setText:@""];
    [_nPasswordField setText:@""];
    [_nPasswordAgainField setText:@""];
}

@end
