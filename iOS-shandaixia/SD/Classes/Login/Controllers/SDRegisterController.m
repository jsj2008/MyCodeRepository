//
//  SDRegisterController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/15.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDRegisterController.h"
#import "SDPasswordLoginView.h"
#import "SDLoginButton.h"
#import "SDAccount.h"
#import "SDRegisterProtocolController.h"

@interface SDRegisterController ()

//账号 密码
@property (nonatomic, weak) SDPasswordLoginView *passwordView;

//获取验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

@property (nonatomic, assign) NSInteger timeCount;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) UITextField *passwordTextField;


@property (nonatomic, weak) UILabel *agreeLabel;

@property (nonatomic, weak) UIButton *agreeButton;

@end

@implementation SDRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self addContent];
    
    if ([self.registTitle isEqualToString:@"注册"]) {
        
        [@"请使用绑定银行卡在银行预留的手机号码进行注册，否则将无法收到借款款项" showNotice];
    }else{
    
        self.agreeLabel.hidden = self.agreeButton.hidden = YES;
        
    }
    
}


- (void)addContent{


    //账号 密码
    CGFloat passwordH = 250 * SCALE;
    SDPasswordLoginView *passwordView = [[SDPasswordLoginView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, passwordH)];
    passwordView.accountTextField.keyboardType = UIKeyboardTypeNumberPad; 
    [self.view addSubview:passwordView];
    self.passwordView = passwordView;
    self.passwordView.accountTextField.width = SCREENWIDTH - 180 * SCALE - [@"重新获取(60))" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
    self.sendCodeButton = passwordView.sendCodeButton;
    [self.sendCodeButton setTitleColor:FDColor(153, 153, 153) forState:UIControlStateDisabled];
    [self.sendCodeButton setTitleColor:FDColor(70, 153, 253) forState:UIControlStateNormal];
    [self.sendCodeButton addTarget:self action:@selector(getCodeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.passwordView.verticalImageView.hidden = self.passwordView.sendCodeButton.hidden = YES;
    
    self.passwordView.showPasswordButton.hidden = YES;
    self.passwordView.verticalImageView.hidden = self.passwordView.sendCodeButton.hidden = NO;
    self.passwordView.accountTextField.placeholder = @"请输入手机号码";
    self.passwordView.passwordTextField.placeholder = @"请输入验证码";
    self.passwordView.passwordTextField.secureTextEntry = NO;
    self.passwordView.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordView.passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //密码
    CGFloat lineX = 80 * SCALE;
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(lineX, 0, self.view.width - lineX * 3, 100 * SCALE)];
    passwordTextField.centerY = CGRectGetMaxY(self.passwordView.frame) + 50 * SCALE;
    passwordTextField.placeholder = @"请输入6-16位新密码";
    self.passwordTextField = passwordTextField;
    [self.view addSubview:passwordTextField];
    passwordTextField.secureTextEntry = YES;
    [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    passwordTextField.font = [UIFont systemFontOfSize:30 * SCALE];
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //虚线2
    UIImageView *lineTwo = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
    lineTwo.frame = CGRectMake(lineX, CGRectGetMaxY(self.passwordView.frame) + 100 * SCALE, SCREENWIDTH - 2 * lineX,1.5 * SCALE);
    
    [self.view addSubview:lineTwo];
    
    //显示密码
    UIButton *showPasswordButton = [UIButton buttonWithImage:@"icon_eye_close-" backImageNamed:nil];
    [showPasswordButton setImage:[UIImage imageNamed:@"icon_eye_open"] forState:UIControlStateSelected];
    
    [showPasswordButton sizeToFit];
    [self.view addSubview:showPasswordButton];
    showPasswordButton.x = SCREENWIDTH - lineX - showPasswordButton.width;
    showPasswordButton.centerY = passwordTextField.centerY;
    
    [showPasswordButton addTarget:self action:@selector(showPasswordButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //同意协议
    CGFloat labelH = 24 * SCALE;
    NSString *text = @"点击注册即视为同意";
    UILabel *agreeLabel = [UILabel labelWithText:text textColor:FDColor(102,102,102) font:labelH textAliment:0];
    CGFloat labelW = [text sizeOfMaxScreenSizeInFont:labelH].width;
    CGFloat labelY = CGRectGetMaxY(lineTwo.frame) + 20 * SCALE;
    agreeLabel.frame = CGRectMake(lineX, labelY, labelW, labelH);
    self.agreeLabel = agreeLabel;
    
    [self.view addSubview:agreeLabel];
    
    //协议按钮
    NSString *agreeString = @"《闪贷侠借款服务协议》";
    UIButton *agreeButton = [UIButton buttonWithTitle:agreeString titleColor:FDColor(55,140,244) titleFont:labelH];
    CGFloat agreeW = [agreeString sizeOfMaxScreenSizeInFont:labelH].width;
    CGFloat agreeX = CGRectGetMaxX(agreeLabel.frame);
    agreeButton.frame = CGRectMake(agreeX, labelY, agreeW, labelH);
    self.agreeButton = agreeButton;
    
    [agreeButton addTarget:self action:@selector(agreeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:agreeButton];
    
    //注册
    CGFloat loginY = CGRectGetMaxY(lineTwo.frame) + 100 * SCALE;
    CGFloat loginH = 100 * SCALE;
    SDLoginButton *registButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(80 * SCALE, loginY, SCREENWIDTH - 160 * SCALE, loginH)];
    [registButton setTitle:self.registTitle forState:UIControlStateNormal];
    self.registButton = registButton;
    [self.view addSubview:registButton];
    [registButton addTarget:self action:@selector(registButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)registButtonDidClicked:(UIButton *)button{
    
    button.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.enabled = YES;
    });
    
    if (self.passwordView.accountTextField.text.length == 0){
        
        
        [@"请输入手机号码" showNotice];
        
        return;
    }
    
    //判断手机号是否输入正确
    if (![self.passwordView.accountTextField.text isMobileNumber]){
        
        [@"请输入正确的手机号码" showNotice];
        
        return;
        
    }

    
    if (self.passwordView.passwordTextField.text.length == 0 || self.passwordView.passwordTextField.text == nil) {
        
        [FDReminderView showWithString:@"请输入验证码"];
        
        return;
    }
    
    if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 12) {
        
        [FDReminderView showWithString:@"请输入6-16位密码"];
        
        return;
    }
    
    
    if ([self.registTitle isEqualToString:@"注册"]) {
        
        [SDAccount registWithAccount:self.passwordView.accountTextField.text verifCode:self.passwordView.passwordTextField.text pwd:self.passwordTextField.text channelType:nil userType:2 finishedBlock:^(id object) {
            
            FDLog(@"msg - %@",object[@"msg"]);
            
            NSString *str = object[@"msg"];
            
            if ([str containsString:@"成功"]) {
                
//                [FDReminderView showWithString:@"注册成功"];
                [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"注册成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else if([str containsString:@"手机号码不能重复"]){
                
                [FDReminderView showWithString:@"该手机号已注册,请登录"];
                
                [self leftBtnDidTouch];
            }else{
                
                [FDReminderView showWithString:str];
            }
            
            
            
        } failuredBlock:^(id object) {
            
            [FDReminderView showWithString:@"注册失败"];
        }];
        
    }else{
    
        [SDAccount forgotPasswordWithAccount:self.passwordView.accountTextField.text verifCode:self.passwordView.passwordTextField.text pwd:self.passwordTextField.text finishedBlock:^(id object) {
            
            NSString *str = object[@"msg"];
            
            if ([str containsString:@"成功"]) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                
                [FDReminderView showWithString:str];
            }
            
        } failuredBlock:^(id object) {
            
        }];
    }

    
    
}

- (void)showPasswordButtonDidClicked:(UIButton *)button{
    
    button.selected = !button.selected;
    
    self.passwordTextField.secureTextEntry = !button.selected;
    
}

#pragma mark - 点击获取验证码
- (void)getCodeButtonDidClicked{
    
    if (![self.passwordView.accountTextField.text isMobileNumber]){
        
        [@"请输入正确的手机号码" showNotice];
        
        return;
    }
    
    
    
    
    
    
    self.sendCodeButton.enabled = NO;
    
    //    self.sendCodeButton.width = [@"重新获取(60)" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
    //    [self.passwordView setNeedsLayout];
    
    
    NSInteger userType;
    if ([self.registTitle isEqualToString:@"注册"]) {
        
        userType = SDMassageTypeRegist;
    }else{
        
        userType = SDMassageTypeForgotPassword;
    }
    
    
    [SDAccount getCodeWithPhone:self.passwordView.accountTextField.text type:userType finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        NSString *code = dict[@"verifCode"];
        
        FDLog(@"验证码 - %@,msg - %@",code,object[@"msg"]);
        
        if (code.length > 0) {
            
            [FDReminderView showWithString:[NSString stringWithFormat:@"验证码已发送至%@",self.passwordView.accountTextField.text]];
            
            self.timeCount = 60;
            
            [self addTimer];
            
        }else{
            
            [FDReminderView showWithString:object[@"msg"]];
            
            self.sendCodeButton.enabled = YES;
            
        }
        
    } failuredBlock:^(id object) {
        
        [FDReminderView showWithString:@"验证码发送失败"];
        
        self.sendCodeButton.enabled = YES;
    }];
    

    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self removeTimer];
    
}

// 添加定时器
- (void)addTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
    
    
}

// 删除定时器
- (void)removeTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeButtonTitle{
    
    self.timeCount --;
    
    if (self.timeCount == 0) {
        
        [self removeTimer];
        
        self.sendCodeButton.enabled = YES;
        
        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        
    }else{
        
        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"重新获取(%@)",@(self.timeCount)] forState:UIControlStateNormal];
        
    }
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    if (self.passwordTextField.isEditing) {
        
        [self.passwordTextField endEditing:YES];
    }else if(self.passwordView.accountTextField.isEditing){
    
        [self.passwordView.accountTextField endEditing:YES];
        
    }else if (self.passwordView.passwordTextField){
    
        [self.passwordView.passwordTextField endEditing:YES];
    }
    
}

- (void)dealloc {
    
    [SDNotificationCenter removeObserver:self];
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 15) {
        textField.text = [textField.text substringToIndex:16];
    }
    
}

- (void)agreeButtonDidClicked{
    
    [self.navigationController pushViewController:[[SDRegisterProtocolController alloc] init] animated:YES];
}


@end
