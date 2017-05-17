//
//  CertificateChangePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CertificateChangePopView.h"
#import "IosLayoutDefine.h"
#import "TopBarView.h"
#import "LangCaptain.h"
#import "CertificateChangePopContentView.h"
#import "ZLKeyboard.h"
#import "ResizeForKeyboard.h"

@interface CertificateChangePopView() <UITextFieldDelegate> {
    CertificateChangePopContentView *contentView;
    //    ZLKeyboard *_keyboard;
    UITextField *_currentField;
}

@end

@implementation CertificateChangePopView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
        [self initLayout];
        //        [self initKeyboard];
        [self initTextFeild];
        [self addResignFirstResponderAction];
    }
    return self;
}

- (void)initLayout {
    CGRect contentViewRect = CGRectMake(0, SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT);
    [contentView setFrame:contentViewRect];
}

- (void)addResignFirstResponderAction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardReturn)];
    [self addGestureRecognizer:tap];
}

- (void)initTextFeild {
    [contentView.oPinField setSecureTextEntry:true];
    [contentView.oPinField setKeyboardType:UIKeyboardTypeNumberPad];
    [contentView.oPinField setDelegate:self];
    
    [contentView.nPinField setSecureTextEntry:true];
    [contentView.nPinField setKeyboardType:UIKeyboardTypeNumberPad];
    [contentView.nPinField setDelegate:self];
    
    [contentView.nPinAgainField setSecureTextEntry:true];
    [contentView.nPinAgainField setKeyboardType:UIKeyboardTypeNumberPad];
    [contentView.nPinAgainField setDelegate:self];
}

//- (void)initKeyboard{
//    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:TradeNumberKeyboard];
//    keyboard.delegate = self;
//    _keyboard = keyboard;
//    contentView.oPinField.inputView = _keyboard;
//    contentView.nPinField.inputView = _keyboard;
//    contentView.nPinAgainField.inputView = _keyboard;
//
//    contentView.oPinField.delegate = self;
//    contentView.nPinField.delegate = self;
//    contentView.nPinAgainField.delegate = self;
//}

- (void)initComponent {
    [self initTopBar];
    [self initContentView];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)initTopBar{
    TopBarView *topBar = [[TopBarView alloc] init];
    
    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"CertificateChange"] withMidButton:nil];
    [self addSubview:topBar];
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
    CGRect imageRect = CGRectMake(0, 0, 20, 20);
    
    //    [leftButton setFrame:[ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(12, 12, 28, 28)]];
    [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [leftButton addSubview:leftView];
    [leftView setImage:[UIImage imageNamed:@"images/normal/reback.png"]];
    [leftView setCenter:centerPoint];
    
    [topBar addSubview:leftButton];
}

- (void)initContentView {
    contentView = [CertificateChangePopContentView newInstance];
    [self addSubview:contentView];
}

- (void)reback {
    [self removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _currentField = textField;
    //    [_keyboard setIsNeedPwd:false];
    //    [_keyboard resetInputString:textField.text];
    //    [_keyboard setCurrentTextField:_currentField];
    CGFloat currentY = textField.frame.origin.y;
    CGFloat distance = 0.0f;
    if (120 - currentY <= 0.0f) {
        distance = 120 - currentY;
    }
    [ResizeForKeyboard setViewPosition:self forY:distance];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string {
    if ([string isEqualToString:@""]) {
        return true;
    }
    if ([textField.text length] >= 6) {
        return false;
    }
    return true;
}

- (void)keyboardReturn {
    if ([_currentField isFirstResponder]) {
        [_currentField resignFirstResponder];
    }
    _currentField = nil;
    [ResizeForKeyboard setViewPosition:self forY:0];
}

//#pragma keyboardDelegate
//- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
//    _currentField.text = string;
//}
//
//- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string{
//    if ([string isEqualToString:@""]) {
//        _currentField.text = @"";
//    } else {
//        _currentField.text = string;
//    }
//}
//
//- (void)keyboardReturn {
//    [_currentField resignFirstResponder];
//    _currentField = nil;
//    [ResizeForKeyboard setViewPosition:self forY:0];
//}


@end
