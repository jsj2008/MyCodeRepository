//
//  SDChangePasswordView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/23.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDVerifyPasswordView.h"
#import "SDAccount.h"

@interface SDVerifyPasswordView ()

//验证登陆密码
@property (nonatomic, weak) UILabel *verifyPasswordLabel;


@property (nonatomic, weak) UIView *passwordBackView;
@property (nonatomic, weak) UIView *passwordBackView2;

//取消
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIView *cancelBackView;

//登陆
@property (nonatomic, weak) UIButton *sureButton;

//背景图
@property (nonatomic,weak) UIButton *shadowView;

@end

@implementation SDVerifyPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        //验证登陆密码
        UILabel *verifyPasswordLabel = [UILabel labelWithText:@"验证登录密码" textColor:FDColor(34,34,34) font:36 * SCALE textAliment:NSTextAlignmentCenter];
        
        self.verifyPasswordLabel = verifyPasswordLabel;
        [self addSubview:verifyPasswordLabel];
        
        
        //输入框
        UIView *passwordBackView = [[UIView alloc] init];
        self.passwordBackView = passwordBackView;
        [self addSubview:passwordBackView];
        passwordBackView.backgroundColor = FDColor(240, 240, 240);
        UIView *passwordBackView2 = [[UIView alloc] init];
        self.passwordBackView2 = passwordBackView2;
        [passwordBackView addSubview:passwordBackView2];
        passwordBackView2.backgroundColor = [UIColor whiteColor];
        
        
        UITextField *passwordTextField = [[UITextField alloc] init];
        passwordTextField.backgroundColor = [UIColor whiteColor];
        self.passwordTextField = passwordTextField;
        [passwordBackView addSubview:passwordTextField];
        passwordTextField.textAlignment = NSTextAlignmentCenter;
        passwordTextField.secureTextEntry = YES;
        passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        //取消
        UIView *cancelBackView = [[UIView alloc] init];
        self.cancelBackView = cancelBackView;
        [self addSubview:cancelBackView];
        cancelBackView.backgroundColor = FDColor(52, 133, 233);
        
        UIButton *cancelButton = [UIButton buttonWithTitle:@"取消" titleColor:FDColor(52, 133, 233) titleFont: 30 * SCALE];
        cancelButton.backgroundColor = [UIColor whiteColor];
        [cancelBackView addSubview:cancelButton];
        self.cancelButton = cancelButton;
        
        
        
        //确定
        UIButton *sureButton = [UIButton buttonWithTitle:@"确定" titleColor:[UIColor whiteColor] titleFont: 30 * SCALE];
        [self addSubview:sureButton];
        self.sureButton = sureButton;
        sureButton.backgroundColor = FDColor(70, 151, 251);
        
        [cancelButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [sureButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //验证登陆密码
    CGFloat verifyY = 49 * SCALE;
    CGFloat verifyH = 36 * SCALE;
    
    self.verifyPasswordLabel.frame = CGRectMake(0, verifyY, self.width, verifyH);
    
    //输入框
    CGFloat passY = CGRectGetMaxY(self.verifyPasswordLabel.frame) + 54 * SCALE;
    CGFloat passH = 92 * SCALE;
    CGFloat passW = 432 * SCALE;
    CGFloat passX = (self.width - passW)/2;
    
    self.passwordBackView.frame = CGRectMake(passX, passY, passW, passH);
    
    self.passwordTextField.frame = CGRectMake(1, passH/4, passW - 2, passH/2);
    self.passwordBackView2.frame = CGRectMake(1, 1, passW - 2, passH - 2);
    
    //取消
    CGFloat cancelX = 30 * SCALE;
    CGFloat cancelY = CGRectGetMaxY(self.passwordBackView.frame) + 38 * SCALE;
    CGFloat cancelH = 84 * SCALE;
    CGFloat cancelW = (self.width - 3 * cancelX)/2;
    
    self.cancelBackView.frame = CGRectMake(cancelX, cancelY, cancelW, cancelH);
    self.cancelBackView.layer.cornerRadius = cancelH/2;
    self.cancelBackView.clipsToBounds = YES;
    self.cancelButton.frame = CGRectMake(1, 1, cancelW - 2, cancelH - 2);
    self.cancelButton.layer.cornerRadius = (cancelH - 2)/2;
    self.cancelButton.clipsToBounds = YES;
    
    
    
    //登陆
    self.sureButton.frame = self.cancelBackView.frame;
    self.sureButton.x = self.width - cancelW - cancelX;
    self.sureButton.layer.cornerRadius = cancelH/2;
    self.sureButton.clipsToBounds = YES;
}

- (void)show{
    
    //    SDLog(@"show - ------------");
    
    
    
    //背景图
    UIButton *shadowView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    [shadowView addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    shadowView.backgroundColor = [UIColor blackColor];
    
    shadowView.alpha = 0.7;
    
    self.shadowView = shadowView;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:shadowView];
    
    
    
    CGFloat height = self.height;
    
    self.y = SCREENHEIGHT;
    
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.y = (SCREENHEIGHT - height)/2.2;
        
    } completion:^(BOOL finished) {
        
        [self.passwordTextField becomeFirstResponder];
    }];
}

- (void)remove{
    
    
    
    
    
//    [self.shadowView removeFromSuperview];
//    
//    [self removeFromSuperview];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.y = SCREENHEIGHT;
        
    } completion:^(BOOL finished) {
        
        [self.passwordTextField endEditing:YES];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
//
        [self.shadowView removeFromSuperview];
        
    });
    
}

- (void)submit:(UIButton *)button{

    button.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.enabled = YES;
    });
    
    [SDAccount loginWithAccount:[FDUserDefaults objectForKey:FDUserAccount] verifCode:@"" pwd:self.passwordTextField.text loginType:0 finishedBlock:^(id object) {
        
        
        NSString *str = object[@"msg"];
        
        if ([str isEqualToString:@"成功"]) {
            
            
            [self remove];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if ([self.delegate respondsToSelector:@selector(verifyViewPasswordSuccess:)]) {
                    
                    [self.delegate verifyViewPasswordSuccess:self.passwordTextField.text];
                }
            });
            
        }else{
            
            
            
            [self remove];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [FDReminderView showWithString:str];
            });
        }
        
        
        
    } failuredBlock:^(id object) {
        
        [FDReminderView showWithString:@"验证失败"];
    }];

}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 15) {
        textField.text = [textField.text substringToIndex:16];
    }

}


@end






















