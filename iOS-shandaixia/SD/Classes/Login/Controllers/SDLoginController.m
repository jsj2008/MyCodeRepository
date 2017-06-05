//
//  SDLoginController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoginController.h"
#import "SDLoginBackView.h"
#import "SDPasswordLoginView.h"
#import "SDBottomLineButton.h"
#import "SDPasswordLoginView.h"
#import "SDLoginButton.h"
#import "SDRegistButton.h"
#import "SDRegisterController.h"
#import "SDAccount.h"

@interface SDLoginController ()

//背景
@property (nonatomic, weak) SDLoginBackView *backView;

//密码登陆
@property (nonatomic, weak) SDBottomLineButton *passwordButton;

//密码登陆
@property (nonatomic, weak) SDBottomLineButton *quickLoginButton;

//账号 密码
@property (nonatomic, weak) SDPasswordLoginView *passwordView;

//时间
@property (nonatomic, assign) NSInteger timeCount;

//定时器
@property (nonatomic, strong) NSTimer *timer;

//获取验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

@property (nonatomic, weak) SDLoginButton *loginButton;

@property (nonatomic, weak) UIView *blueBackView;

@end

@implementation SDLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self addContent];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

- (void)addContent{

    
    
    
    //顶部背景
    CGFloat blueH = 440 * SCALE;
    UIView *blueBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, blueH)];
    self.blueBackView = blueBackView;
    blueBackView.backgroundColor = FDColor(70, 151, 251);
    [self.view addSubview:blueBackView];
    
    // 左侧按钮(固定)
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:@"icon_black_move_normal"] forState:UIControlStateNormal];
    
    leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [leftBtn addTarget:self action:@selector(leftBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.backgroundColor = [UIColor blackColor];
    //图标
    CGFloat iconY = 130 * SCALE;
    CGFloat iconW = 120 * SCALE;
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white"]];
    iconImageView.frame = CGRectMake((SCREENWIDTH - iconW)/2, iconY, iconW, iconW);
    [self.view addSubview:iconImageView];
    
    //密码登录
    CGFloat passW = [@"快速登录 " sizeOfMaxScreenSizeInFont:30 * SCALE].width;
    CGFloat passX = 158 * SCALE;
    CGFloat passH = 44 * SCALE;
    CGFloat passY = blueH - 20 * SCALE - passH;
    SDBottomLineButton *passwordButton = [[SDBottomLineButton alloc] initWithFrame:CGRectMake(passX, passY, passW, passH)];
    [passwordButton setTitle:@"密码登录" forState:UIControlStateNormal];
    [blueBackView addSubview:passwordButton];
    self.passwordButton = passwordButton;
    [passwordButton addTarget:self action:@selector(changeLoginWay:) forControlEvents:UIControlEventTouchUpInside];
    passwordButton.selected = YES;
    
    //快速登录
    CGFloat quickX = SCREENWIDTH - passW - passX;
    SDBottomLineButton *quickLoginButton = [[SDBottomLineButton alloc] initWithFrame:CGRectMake(quickX, passY, passW, passH)];
    [quickLoginButton setTitle:@"快速登录" forState:UIControlStateNormal];
    [blueBackView addSubview:quickLoginButton];
    quickLoginButton.selected = NO;
    self.quickLoginButton = quickLoginButton;
    
    [quickLoginButton addTarget:self action:@selector(changeLoginWay:) forControlEvents:UIControlEventTouchUpInside];
    
    //账号 密码
    CGFloat passwordH = 250 * SCALE;
    SDPasswordLoginView *passwordView = [[SDPasswordLoginView alloc] initWithFrame:CGRectMake(0, blueH, SCREENWIDTH, passwordH)];
    passwordView.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:passwordView];
    self.passwordView = passwordView;
    self.sendCodeButton = passwordView.sendCodeButton;
    [self.sendCodeButton setTitleColor:FDColor(153, 153, 153) forState:UIControlStateDisabled];
    [self.sendCodeButton setTitleColor:FDColor(70, 153, 253) forState:UIControlStateNormal];
    [self.sendCodeButton addTarget:self action:@selector(getCodeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.passwordView.verticalImageView.hidden = self.passwordView.sendCodeButton.hidden = YES;
    
    //判断是否登陆过
    if ([FDUserDefaults objectForKey:FDUserAccount]) {
        
        self.passwordView.accountTextField.text = [FDUserDefaults objectForKey:FDUserAccount];
    }
    
    //登陆
    CGFloat loginY = self.passwordView.height + self.passwordView.y + 100 * SCALE;
    CGFloat loginH = 100 * SCALE;
    SDLoginButton *loginButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(80 * SCALE, loginY, SCREENWIDTH - 160 * SCALE, loginH)];
    
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton = loginButton;
    
    //忘记密码
    CGFloat forW = [@"忘记密码？" sizeOfMaxScreenSizeInFont:24 * SCALE].width;
    CGFloat forY = CGRectGetMaxY(loginButton.frame) + 30 * SCALE;
    CGFloat forX = SCREENWIDTH - 100 * SCALE - forW;
    UIButton *forgotButton = [UIButton buttonWithTitle:@"忘记密码?" titleColor:FDColor(70, 151, 251) titleFont:24 * SCALE];
    forgotButton.frame = CGRectMake(forX, forY, forW, 24 * SCALE);
    [self.view addSubview:forgotButton];
    [forgotButton addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
    forgotButton.tag = 0;
    
    //注册
    CGFloat forgotW = 198 * SCALE;
    CGFloat forgotH = 60 * SCALE;
    CGFloat forgotX = (SCREENWIDTH - forgotW)/2;
    CGFloat forgotY = CGRectGetMaxY(loginButton.frame) + 100 * SCALE;
    SDRegistButton *registButton = [[SDRegistButton alloc] initWithFrame:CGRectMake(forgotX, forgotY, forgotW, forgotH)];
    registButton.tag = 1;
    [registButton.registButton addTarget:self action:@selector(registButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registButton];
    
    //底部背景
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back_image"]];
    backImageView.frame = CGRectMake(0, SCREENHEIGHT - 190 * SCALE, SCREENWIDTH, 190 * SCALE);
    [self.view addSubview:backImageView];
}

- (void)forgotPassword{


    SDRegisterController *regist = [[SDRegisterController alloc] init];
    
    regist.registTitle = @"确认修改";
   
    
    [regist createNavBarWithTitle:@"忘记密码" titleColor:FDColor(34, 34, 34) backImageNamed:@"icon_white_move_normal" backGroundColor:[UIColor clearColor]];
    
    
    
    [self.navigationController pushViewController:regist animated:YES];
    
}

- (void)registButtonDidClicked:(UIButton *)button{
    
 
    SDRegisterController *regist = [[SDRegisterController alloc] init];

    
    regist.registTitle = @"注册";
    

    [regist createNavBarWithTitle: @"注册" titleColor:FDColor(34, 34, 34) backImageNamed:@"icon_white_move_normal" backGroundColor:[UIColor clearColor]];
    
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)changeLoginWay:(SDBottomLineButton *)button{

    self.passwordButton.selected = self.quickLoginButton.selected = NO;
    
    button.selected = YES;
    
    self.passwordView.passwordTextField.text = @"";
    
    if (button == self.passwordButton) {
        
        
//        self.quickLoginButton.selected = NO;
        self.passwordView.showPasswordButton.hidden = NO;
        self.passwordView.verticalImageView.hidden = self.passwordView.sendCodeButton.hidden = YES;
        self.passwordView.passwordTextField.placeholder = @"请输入登录密码";
        
        
        self.passwordView.passwordTextField.keyboardType = UIKeyboardTypeDefault;
        self.passwordView.passwordTextField.secureTextEntry = YES;
        
        self.passwordView.accountTextField.width = SCREENWIDTH - 160 * SCALE;
    }else{
        
        
        
        [@"请使用绑定银行卡在银行预留的手机号码进行登录，否则将无法收到借款款项" showNotice];
        
//        self.passwordButton.selected = NO;
        
        self.passwordView.showPasswordButton.hidden = YES;
        self.passwordView.verticalImageView.hidden = self.passwordView.sendCodeButton.hidden = NO;
        self.passwordView.passwordTextField.placeholder = @"请输入验证码";
        
        self.passwordView.passwordTextField.secureTextEntry = NO;
        self.passwordView.passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        
        self.passwordView.accountTextField.width = SCREENWIDTH - 180 * SCALE - [@"重新获取(60))" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
    }
    
}

#pragma mark - Private
- (void)leftBtnDidTouch
{
//    [self dismissViewControllerAnimated:YES completion:nil];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击获取验证码
- (void)getCodeButtonDidClicked{
    
    if (![self.passwordView.accountTextField.text isMobileNumber]){
        
        [@"请输入正确的手机号码" showNotice];
        
        return;
    }
    
    
    
    self.sendCodeButton.enabled = NO;
    
    
    [SDAccount getCodeWithPhone:self.passwordView.accountTextField.text type:1 finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        NSString *code = dict[@"verifCode"];
        
        FDLog(@"dict - %@,msg - %@",dict,object[@"msg"]);
        
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

#pragma mark - 点击登录按钮
- (void)loginButtonDidClicked{
    
    self.loginButton.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.loginButton.userInteractionEnabled = YES;
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
    
    if (!self.passwordView.passwordTextField.text.length) {
        
        if (self.passwordView.sendCodeButton.hidden) {
            
            [@"请输入密码" showNotice];
            
            return;
            
        }else{
        
            [@"请输入验证码" showNotice];
            
            return;
        }
    }else{
    
        if (self.passwordButton.selected) {
            
            if (self.passwordView.passwordTextField.text.length <6 || self.passwordView.passwordTextField.text.length > 12){
                
                [FDReminderView showWithString:@"密码错误"];
                
                return;
            }
            
        }
    }
    
    NSString *verifCode = nil;
    NSString *pwd = nil;
    NSInteger loginType = 0;
    
    if (!self.passwordView.sendCodeButton.hidden) {
        
        if (self.passwordView.passwordTextField.text.length == 0){
            
            [FDReminderView showWithString:@"请输入验证码"];
            
            return;
        }
        
        verifCode = self.passwordView.passwordTextField.text;
        loginType = 1;
        
    }else{
    
        if (self.passwordView.passwordTextField.text.length == 0){
            
            [FDReminderView showWithString:@"请输入密码"];
            
            return;
        }
        
        pwd = self.passwordView.passwordTextField.text;
        loginType = 0;
        
        
    }
    
    
    
    FDLog(@"loginType - %@",@(loginType));
    
    [SDAccount loginWithAccount:self.passwordView.accountTextField.text verifCode:verifCode pwd:pwd loginType:loginType finishedBlock:^(id object) {
        
        
        NSString *str = object[@"msg"];
        
        
        
        if ([str isEqualToString:@"成功"]) {
            
//            [FDReminderView showWithString:@"登录成功"];
            
            [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"登录成功"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
                [SDNotificationCenter postNotificationName:SDLoginSuccessNotification object:nil];
            });
            
            
            
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                
            });
        }else{
        
            [FDReminderView showWithString:str];
        }
        
        
        
    } failuredBlock:^(id object) {
        
        [FDReminderView showWithString:@"登录失败"];
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.passwordView.accountTextField endEditing:YES];
    [self.passwordView.passwordTextField endEditing:YES];
    
}



@end


















