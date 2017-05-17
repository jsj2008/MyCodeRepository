//
//  UserNameChangePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/13.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "UserNameChangePopView.h"
#import "ZLKeyboard.h"
#import "UserNameChangePopContentView.h"
#import "IosLayoutDefine.h"
#import "TopBarView.h"
#import "LangCaptain.h"
#import "ResizeForKeyboard.h"

@interface UserNameChangePopView()<ZLKeyboardDelegate, UITextFieldDelegate> {
    UserNameChangePopContentView *contentView;
    ZLKeyboard *_keyboard;
    UITextField *_currentField;
    Boolean _isShow;
}

@end

@implementation UserNameChangePopView

- (id)initWithFrame:(CGRect)frame leftButton:(Boolean)isShow{
    if (self = [super initWithFrame:frame]) {
        _isShow = isShow;
        [self initComponent];
        [self initLayout];
        [self initKeyboard];
    }
    return self;
}

- (void)initLayout {
    CGRect contentViewRect = CGRectMake(0, SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT);
    [contentView setFrame:contentViewRect];
}

- (void)initKeyboard{
    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:LoginNumberKeyboard];
    keyboard.delegate = self;
    _keyboard = keyboard;
    contentView.userNameField.inputView = _keyboard;
    contentView.userNameField.delegate = self;
}

- (void)initComponent {
    [self initTopBar];
    [self initContentView];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)initTopBar{
    TopBarView *topBar = [[TopBarView alloc] init];
    
    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"UserNameSet"] withMidButton:nil];
    [self addSubview:topBar];
    
    //    [leftButton setFrame:[ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(12, 12, 28, 28)]];
    
    if (_isShow) {
        CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
        CGRect imageRect = CGRectMake(0, 0, 20, 20);
        UIButton *leftButton = [[UIButton alloc] init];
        [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        [leftButton addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
        [leftButton addSubview:leftView];
        [leftView setImage:[UIImage imageNamed:@"images/normal/reback.png"]];
        [leftView setCenter:centerPoint];
        
        [topBar addSubview:leftButton];
    }
    
}

- (void)initContentView {
    contentView = [UserNameChangePopContentView newInstance];
    [self addSubview:contentView];
}

- (void)reback {
    [self removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //    [self rebackOriginSender:nil];
    _currentField = textField;
    [_keyboard setIsNeedPwd:false];
    [_keyboard resetInputString:textField.text];
    [_keyboard setCurrentTextField:_currentField];
    //    currentY = [[textField superview] superview].frame.origin.y;
    CGFloat currentY = textField.frame.origin.y;
    CGFloat distance = 0.0f;
    if (120 - currentY <= 0.0f) {
        distance = 120 - currentY;
    }
    [ResizeForKeyboard setViewPosition:self forY:distance];
}

#pragma keyboardDelegate
- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
    _currentField.text = string;
}

- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string{
    if ([string isEqualToString:@""]) {
        _currentField.text = @"";
    } else {
        _currentField.text = string;
    }
}

- (void)keyboardReturn {
    [_currentField resignFirstResponder];
    _currentField = nil;
    [ResizeForKeyboard setViewPosition:self forY:0];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    contentView = nil;
}


@end
