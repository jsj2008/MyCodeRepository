//
//  SDResetPasswordLastController.m
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDResetPasswordLastController.h"
#import "SDLoginButton.h"
#import "SDInputView.h"
#import "SDAccount.h"

@interface SDResetPasswordLastController ()<UITextFieldDelegate>

//显示密码
@property (nonatomic, weak) UIButton *showPasswordButton;

@property (nonatomic, weak) SDInputView *phoneView;

@end

@implementation SDResetPasswordLastController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"密码修改"];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [self addUI];
     
}

- (void)addUI{
    
    CGFloat height = 100 * SCALE;

    CGFloat blank = 20 * SCALE;
    //手机号
    CGFloat phoneY = blank + 64;
    SDInputView *phoneView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY, SCREENWIDTH, height) title:@"新登录密码" placeholder:@"请输入6-16位密码"];
    phoneView.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneView.inputTextField.secureTextEntry = YES;
    phoneView.rightButton.hidden = NO;
    [phoneView.rightButton setImage:[UIImage imageNamed:@"icon_eye_open"] forState:UIControlStateSelected];
    [phoneView.rightButton setImage:[UIImage imageNamed:@"icon_eye_close-"] forState:UIControlStateNormal];
    self.phoneView = phoneView;
    [phoneView.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [phoneView.rightButton addTarget:self action:@selector(showPasswordButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:phoneView];
    
    //显示密码
//    UIButton *showPasswordButton = [UIButton buttonWithImage:@"icon_eye_close-" backImageNamed:nil];
//    [showPasswordButton setImage:[UIImage imageNamed:@"icon_eye_open"] forState:UIControlStateSelected];
//    self.showPasswordButton = showPasswordButton;
//    [showPasswordButton sizeToFit];
//    [self.view addSubview:showPasswordButton];
    
    CGFloat x = 20 * SCALE;
    
    CGFloat submitY = 180 * SCALE + 64;
    SDLoginButton *submitButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(x, submitY, SCREENWIDTH - 2 * x, height)];
    [submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

- (void)showPasswordButtonDidClicked:(UIButton *)button{
    
    button.selected = !button.selected;
    
    self.phoneView.inputTextField.secureTextEntry = !button.selected;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    
    return YES;
    
}

- (void)submitButtonDidClicked:(UIButton *)button{
    
    if (self.phoneView.inputTextField.text.length <6 || self.phoneView.inputTextField.text.length > 12){
        
        [FDReminderView showWithString:@"密码格式错误"];
        
        return;
    }

    button.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.enabled = YES;
    });
    
    if (self.massageType == SDMassageTypeChangePassword) {
        
        [SDAccount changePasswordWithAccount:[FDUserDefaults objectForKey:FDUserAccount] verifCode:self.verifyCode pwd:self.phoneView.inputTextField.text oldPassword:self.oldPassword finishedBlock:^(id object) {
            
            if ([object[@"msg"] isEqualToString:@"成功"]) {
                
                [FDReminderView showWithString:@"修改密码成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else{
                
                [FDReminderView showWithString:object[@"msg"]];
                
            }
            
        } failuredBlock:^(id object) {
            
        }];
    }else{
    
        [SDAccount forgotPasswordWithAccount:[FDUserDefaults objectForKey:FDUserAccount] verifCode:self.verifyCode pwd:self.phoneView.inputTextField.text finishedBlock:^(id object) {
            
            NSString *str = object[@"msg"];
            
            if ([str containsString:@"成功"]) {
                
                [FDReminderView showWithString:@"修改密码成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else{
                
                [FDReminderView showWithString:str];
            }
            
        } failuredBlock:^(id object) {
            
        }];
        
    }
    
    
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 15) {
        textField.text = [textField.text substringToIndex:16];
    }
}


@end
