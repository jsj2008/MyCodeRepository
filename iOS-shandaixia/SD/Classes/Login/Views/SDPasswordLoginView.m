//
//  SDPasswordLoginView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDPasswordLoginView.h"

@interface SDPasswordLoginView ()<UITextFieldDelegate>



//虚线1
@property (nonatomic, weak) UIImageView *lineOne;



//虚线2
@property (nonatomic, weak) UIImageView *lineTwo;





@end

@implementation SDPasswordLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //账号
        UITextField *accountTextField = [[UITextField alloc] init];
        accountTextField.placeholder = @"请输入手机号码";
        self.accountTextField = accountTextField;
        [self addSubview:accountTextField];
        accountTextField.delegate = self;
        accountTextField.returnKeyType = UIReturnKeyDone;
        accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //密码
        UITextField *passwordTextField = [[UITextField alloc] init];
        passwordTextField.placeholder = @"请输入密码";
        self.passwordTextField = passwordTextField;
        [self addSubview:passwordTextField];
        passwordTextField.secureTextEntry = YES;
        passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        passwordTextField.delegate = self;
        passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [accountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        accountTextField.font = passwordTextField.font = [UIFont systemFontOfSize:30 * SCALE];
        self.accountTextField.width = SCREENWIDTH - 160 * SCALE;
        
        //显示密码
        UIButton *showPasswordButton = [UIButton buttonWithImage:@"icon_eye_close-" backImageNamed:nil];
        [showPasswordButton setImage:[UIImage imageNamed:@"icon_eye_open"] forState:UIControlStateSelected];
        self.showPasswordButton = showPasswordButton;
        [showPasswordButton sizeToFit];
        [self addSubview:showPasswordButton];
        
        [showPasswordButton addTarget:self action:@selector(showPasswordButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //获取验证码
        UIButton *sendCodeButton = [UIButton buttonWithTitle:@"获取验证码" titleColor:FDColor(178, 178, 178) titleFont:26 * SCALE];
        self.sendCodeButton = sendCodeButton;
        [self addSubview:sendCodeButton];
        [sendCodeButton setTitleColor:FDColor(178, 178, 178) forState:UIControlStateDisabled];
        
//        [sendCodeButton addTarget:self action:@selector(sendCodeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //虚线1
        UIImageView *lineOne = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
        
        self.lineOne = lineOne;
        [self addSubview:lineOne];
        
        //虚线2
        UIImageView *lineTwo = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
        
        self.lineTwo = lineTwo;
        [self addSubview:lineTwo];
        
        //垂直的虚线
        UIImageView *verticalImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
        self.verticalImageView = verticalImageView;
        [self addSubview:verticalImageView];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat lineX = 80 * SCALE;
    CGFloat lineW = SCREENWIDTH - 2 * lineX;
    CGFloat lineY = 150 * SCALE;
    
    self.lineOne.frame = CGRectMake(lineX, lineY, lineW, 1 * SCALE);
    self.lineTwo.frame = self.lineOne.frame;
    self.lineTwo.y = lineY + 100 * SCALE;
    
    CGFloat accountH = 100 * SCALE;
    CGFloat accountY = lineY - accountH;
//    self.accountTextField.frame = CGRectMake(lineX, accountY, lineW, accountH);
    self.accountTextField.x = lineX;
    self.accountTextField.y = accountY;
    self.accountTextField.height = accountH;
    
    self.passwordTextField.frame = self.accountTextField.frame;
    self.passwordTextField.centerY = lineY + 50 * SCALE;
    self.passwordTextField.width = self.width - lineX * 2.5;
    self.showPasswordButton.centerY = self.passwordTextField.centerY;
    self.showPasswordButton.x = CGRectGetMaxX(self.lineOne.frame) - self.showPasswordButton.width;
    
    CGFloat codeW = [@"重新获取(60))" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
    CGFloat codeX = CGRectGetMaxX(self.lineOne.frame) - codeW;
    self.sendCodeButton.frame = CGRectMake(codeX, 0, codeW, 26 * SCALE);
    self.sendCodeButton.centerY = self.accountTextField.centerY;
    
    CGFloat verticalX = codeX - 20 * SCALE;
    self.verticalImageView.frame = CGRectMake(verticalX, 0, 1 * SCALE, 26 * SCALE);
    self.verticalImageView.centerY = self.sendCodeButton.centerY;
    
}

- (void)showPasswordButtonDidClicked:(UIButton *)button{

    button.selected = !button.selected;
    
    self.passwordTextField.secureTextEntry = !button.selected;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    
    return YES;
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.accountTextField) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField == self.passwordTextField){
    
        if (textField.text.length > 15) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{

    
    
    return YES;
}

@end











