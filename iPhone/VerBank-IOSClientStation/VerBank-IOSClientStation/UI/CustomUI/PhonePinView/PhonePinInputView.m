//
//  PhonePinInputView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/13.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "PhonePinInputView.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "LangCaptain.h"

@implementation PhonePinInputView

@synthesize titleLabel = _titleLabel;
@synthesize inputLabel = _inputLabel;
@synthesize inputFeild = _inputField;
@synthesize commitButton = _commitButton;
@synthesize cancelButton = _cancelButton;


+ (PhonePinInputView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PhonePinInputView" owner:self options:nil];
    [[nib objectAtIndex:0] initContent];
    return [nib objectAtIndex:0];
}

- (void)initContent {
    [_commitButton addTarget:self action:@selector(clickCommit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCommit {
    [_inputField resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)layoutSubviews {
    
    self.layer.cornerRadius = 10.0f;
    
    [self.titleLabel setTextColor:[UIColor blueButtonColor]];
    
    //    [_commitButton sizeToFit];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_commitButton];
    [UIFormat setComplexBlueButtonColor:_commitButton];
    //    [_cancelButton sizeToFit];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_cancelButton];
    [UIFormat setComplexGrayButtonColor:_cancelButton];
    
    [_commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_inputLabel setText:[[LangCaptain getInstance] getLangByCode:@"PhonePinInput"]];
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"PhonePin"]];
    [_inputField setKeyboardType:UIKeyboardTypeNumberPad];
    
    [_cancelButton layoutIfNeeded];
    [_commitButton layoutIfNeeded];
}

@end
