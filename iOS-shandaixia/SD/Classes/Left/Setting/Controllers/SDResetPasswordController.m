//
//  SDResetPasswordController.m
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDResetPasswordController.h"
#import "SDInputView.h"
#import "SDLoginButton.h"
#import "SDAccount.h"
#import "SDResetPasswordLastController.h"

@interface SDResetPasswordController ()

@property (nonatomic, weak) SDInputView *phoneView;
@property (nonatomic, weak) SDInputView *verifyCodeView;

//时间
@property (nonatomic, assign) NSInteger timeCount;

//定时器
@property (nonatomic, strong) NSTimer *timer;

//获取验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

@property (nonatomic, copy) NSString *verifyCode;

@end

@implementation SDResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [self createNavBarWithTitle:@"密码修改"];
    
    [self addUI];
    
}

- (void)addUI{
    
    CGFloat height = 100 * SCALE;

    //手机号
    CGFloat phoneY = 20 * SCALE + 64;
    SDInputView *phoneView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY, SCREENWIDTH, height) title:@"手机号" placeholder:@""];
    phoneView.inputTextField.text = [FDUserDefaults objectForKey:FDUserAccount];
    phoneView.inputTextField.enabled = NO;
    //small_white_image
    phoneView.titlesButton.hidden = NO;
    
    [phoneView.titlesButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [phoneView.titlesButton setTitleColor:FDColor(153, 153, 153) forState:UIControlStateDisabled];
    [phoneView.titlesButton setTitleColor:FDColor(70, 153, 253) forState:UIControlStateNormal];
    
    
    self.phoneView = phoneView;
    [self.view addSubview:phoneView];
    
    //验证码
    SDInputView *verifyCodeView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY + height, SCREENWIDTH, height) title:@"验证码" placeholder:@"请输入验证码"];
    self.verifyCodeView = verifyCodeView;
    [self.view addSubview:verifyCodeView];
    verifyCodeView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    verifyCodeView.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //提交按钮
    CGFloat x = 20 * SCALE;
    
    CGFloat submitY = CGRectGetMaxY(verifyCodeView.frame) + 60 * SCALE;
    SDLoginButton *submitButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(x, submitY, SCREENWIDTH - 2 * x, height)];
    [submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    [phoneView.titlesButton addTarget:self action:@selector(getCodeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, phoneY + height, SCREENWIDTH - 2 * x, 1 * SCALE)];
    line.backgroundColor = FDColor(240, 240, 240);
    
    [self.view addSubview:line];
}

- (void)submitButtonDidClicked:(UIButton *)button{
    
    button.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.enabled = YES;
    });
    
    NSString *str = self.verifyCodeView.inputTextField.text;
    
    if (str.length) {
        
        if ([str isEqualToString:self.verifyCode]) {
            
            SDResetPasswordLastController *reset = [[SDResetPasswordLastController alloc] init];
            reset.oldPassword = self.oldPassword;
            reset.verifyCode = self.verifyCode;
            reset.massageType = self.massageType;
            
            [self.navigationController pushViewController:reset animated:YES];
        }else{
        
            [FDReminderView showWithString:@"验证码错误"];
        }
        
    }else{
    
        [@"请输入验证码" showNotice];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_verifyCodeView.inputTextField endEditing:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_verifyCodeView.inputTextField endEditing:YES];
    
    return YES;
    
}


#pragma mark - 点击获取验证码
- (void)getCodeButtonDidClicked{
    //
    //    if (![self.addBankCardView.phoneView.inputTextField.text isMobileNumber]){
    //
    //        [@"请输入正确的手机号码" showNotice];
    //
    //        return;
    //    }
    //
    self.timeCount = 60;
    
    
    
    [SDAccount getCodeWithPhone:[FDUserDefaults objectForKey:FDUserAccount] type:self.massageType finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        NSString *code = dict[@"verifCode"];
        
        FDLog(@"验证码 - %@,msg - %@",code,object[@"msg"]);
        
        if (code.length > 0) {
            
            [FDReminderView showWithString:[NSString stringWithFormat:@"验证码已发送至%@",[FDUserDefaults objectForKey:FDUserAccount]]];
            
            self.phoneView.titlesButton.enabled = NO;
            
            self.verifyCode = code;
            
            [self addTimer];
            
        }else{
            
            [FDReminderView showWithString:object[@"msg"]];
            
        }
        
        
        
        
    } failuredBlock:^(id object) {
        
        [FDReminderView showWithString:@"验证码发送失败"];
        
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
        
        self.phoneView.titlesButton.enabled = YES;
        
        [self.phoneView.titlesButton setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        
    }else{
        
        [self.phoneView.titlesButton setTitle:[NSString stringWithFormat:@"重新获取(%@)",@(self.timeCount)] forState:UIControlStateNormal];
    }
    
    
    
}



@end






