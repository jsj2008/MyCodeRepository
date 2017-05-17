//
//  UserNameChangeView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/13.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "UserNameChangePopContentView.h"
#import "LangCaptain.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "PasswordChangePopView.h"
#import "ResizeForKeyboard.h"
#import "ShowAlert.h"
#import "PWDCheckUtil.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "IosLogic.h"
#import "LoginViewController.h"

@implementation UserNameChangePopContentView

@synthesize userNameField = _userNameField;

+ (UserNameChangePopContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UserNameChangePopContentView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:18.0f]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.userInteractionEnabled = false;
    NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[LangCaptain getInstance] getLangByCode:@"UserNameTextView"]];
    [tempString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [tempString replaceOccurrencesOfString:@"." withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [tempString length])];
    [_textView setText:tempString];
//    [_textView setText:[[[LangCaptain getInstance] getLangByCode:@"UserNameTextView"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [_userNameLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"UserNameInput"]]];
    [_userNameLabel setTextColor:[UIColor whiteColor]];
    
    [_confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Modify"] forState:UIControlStateNormal];
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
    
    NSString *userNameString = _userNameField.text;
    
    if ([self isNull:userNameString] || [self isNull:userNameString] || [self isNull:userNameString]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]];
        return;
    }
    
    NSString *accid = [@([[ClientAPI getInstance] getAccount]) stringValue];
    Boolean passwordIsRight = [PWDCheckUtil isPwdLegal:userNameString accountID:accid];
    
    if (!passwordIsRight) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PasswordIllegal"]];
        return;
    }
    
    TradeResult *reslut = [[TradeApi getInstance] changeUserName:userNameString];
    
    if ([reslut succeed]) {
        //
        UIViewController *viewController = [[[IosLogic getInstance] getWindow] rootViewController];
        if ([viewController isKindOfClass:[LoginViewController class]]) {
            [((LoginViewController *)viewController) login];
        }
    } else {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getPaswordResultByCode:[reslut errCode]]];
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


@end
