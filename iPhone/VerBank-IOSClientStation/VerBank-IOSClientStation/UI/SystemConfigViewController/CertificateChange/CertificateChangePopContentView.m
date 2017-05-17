//
//  CertificateChangePopContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CertificateChangePopContentView.h"
#import "LangCaptain.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "ShowAlert.h"
#import "ClientAPI.h"
#import "PhonePinCheckUtil.h"
#import "TradeApi.h"
#import "ResizeForKeyboard.h"
#import "CertificateChangePopView.h"

@implementation CertificateChangePopContentView

@synthesize oPinField = _oPinField;
@synthesize nPinField = _nPinField;
@synthesize nPinAgainField = _nPinAgainField;

+ (CertificateChangePopContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CertificateChangePopContentView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:18.0f]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.userInteractionEnabled = false;
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"CertificateChangeTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [_textView setText:tempString];
    //    [_textView setText:[[[LangCaptain getInstance] getLangByCode:@"CertificateChangeTextView"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [_oPinLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"CurrentPin"]]];
    [_oPinLabel setTextColor:[UIColor whiteColor]];
    
    [_nPinLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPin"]]];
    [_nPinLabel setTextColor:[UIColor whiteColor]];
    
    [_nPinAgainLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"NewPinAgain"]]];
    [_nPinAgainLabel setTextColor:[UIColor whiteColor]];
    
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
    
    NSString *oPinString = _oPinField.text;
    NSString *nPinString = _nPinField.text;
    NSString *nPinAgainString = _nPinAgainField.text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self isNull:oPinString] || [self isNull:nPinString] || [self isNull:nPinAgainString]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]];
            return;
        }
        
        if (![nPinAgainString.uppercaseString isEqualToString:nPinString.uppercaseString]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordUnsame"]];
            return;
        }
        
        Boolean PinIsRight = [PhonePinCheckUtil isPhonePinLegal:nPinString];
        
        if (!PinIsRight) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]];
            return;
        }
        
        int result = [[TradeApi getInstance] changePhonePinAccount:[[ClientAPI getInstance] getAccount]
                                                       oldPhonePin:oPinString
                                                       newPhonePin:nPinString];
        switch (result) {
            case USERIDENTIFY_RESULT_SUCCEED:
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"NewPinChangeSuccess"]];
                [self.superview removeFromSuperview];
                [self resetTextField];
                break;
                
            default:
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:[[LangCaptain getInstance] getPaswordResultByCode:[@(result) stringValue]]];
                break;
        }
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

- (void)resetTextField {
    [_oPinField setText:@""];
    [_nPinField setText:@""];
    [_nPinAgainField setText:@""];
}


@end
