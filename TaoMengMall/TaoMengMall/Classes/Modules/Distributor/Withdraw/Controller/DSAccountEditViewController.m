//
//  DSAccountEditViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSAccountEditViewController.h"
#import "WithdrawRequest.h"
#import "DistributorHeader.h"

@interface DSAccountEditViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIButton *captchaButton;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UILabel *captchaLabel;
@property (nonatomic, strong) UITextField *captchaTextField;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation DSAccountEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.title = @"修改账户";
    [self render];
    //[self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    //NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self render];
}

- (void)render
{
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView addSubview:self.accountLabel];
    [self.backgroundView addSubview:self.accountTextField];
    [self.backgroundView addSubview:self.line1];
    [self.backgroundView addSubview:self.phoneLabel];
    [self.backgroundView addSubview:self.phoneTextField];
    [self.backgroundView addSubview:self.captchaButton];
    [self.backgroundView addSubview:self.line2];
    [self.backgroundView addSubview:self.captchaLabel];
    [self.backgroundView addSubview:self.captchaTextField];
    
    [self.view addSubview:self.submitButton];
    
    if (self.account) {
        self.accountLabel.text = self.account.name;
        [self.accountLabel sizeToFit];
        
        self.accountTextField.placeholder = [NSString stringWithFormat:@"请输入您的%@账号",self.account.name];
        self.accountTextField.text = self.account.account;
    }
    self.phoneTextField.text = [UserService sharedService].phone;
}


- (void)setCaptchaButtonEnabled: (BOOL)enabled {
    
    if ( enabled ) {
        self.captchaButton.enabled = YES;
        self.captchaButton.backgroundColor = Theme_Color;
    } else {
        self.captchaButton.enabled = NO;
        self.captchaButton.backgroundColor = Color_Gray148;
    }
    
}

- (void)setSubmitButtonEnabled: (BOOL)enabled {
    
    if ( enabled ) {
        self.submitButton.enabled = YES;
        self.submitButton.backgroundColor = Theme_Color;
        self.submitButton.layer.borderColor = Theme_Color.CGColor;
    } else {
        self.submitButton.enabled = NO;
        self.submitButton.backgroundColor = Color_White;
        self.submitButton.layer.borderColor = Color_Gray230.CGColor;
    }
    
}

#pragma mark -SubViews
- (UIView*)backgroundView
{
    if (!_backgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 14, SCREEN_WIDTH, 135)];
        view.backgroundColor = Color_White;
        _backgroundView = view;
    }
    return _backgroundView;
}

- (UILabel*)accountLabel
{
    if (!_accountLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(15);
        label.text = @"支付宝";
        [label sizeToFit];
        label.centerY = 22.5;
        _accountLabel = label;
    }
    return _accountLabel;
}

- (UITextField *)accountTextField {
    
    if ( !_accountTextField ) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 3.5, SCREEN_WIDTH - 80 - 120, 38)];
        _accountTextField.placeholder = @"请输入您的支付宝账号";
        _accountTextField.font = FONT(15);
        _accountTextField.delegate = self;
        _accountTextField.textColor = Color_Gray42;
    }
    return _accountTextField;
}

- (UIView*)line1
{
    if (!_line1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 45;
        _line1 = view;
    }
    return _line1;
}

- (UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(15);
        label.text = @"手机号码";
        [label sizeToFit];
        label.centerY = 45 + 22.5;
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UITextField *)phoneTextField {
    
    if ( !_phoneTextField ) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 45 + 3.5, SCREEN_WIDTH - 80 - 120 - 12, 38)];
        _phoneTextField.placeholder = @" 请输入您的手机号";
        _phoneTextField.font = FONT(15);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.textColor = Color_Gray42;
    }
    return _phoneTextField;
}

- (UIButton *)captchaButton {
    
    if ( !_captchaButton ) {
        _captchaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _captchaButton.frame = CGRectMake(0, 45 + 3.5, 120, 38);
        _captchaButton.right = SCREEN_WIDTH - 12;
        [_captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_captchaButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_captchaButton setTitleColor:Color_Gray245 forState:UIControlStateDisabled];
        _captchaButton.titleLabel.font = FONT(14);
        _captchaButton.layer.masksToBounds = YES;
        _captchaButton.layer.cornerRadius = 4;
        _captchaButton.backgroundColor = Theme_Color;
        [_captchaButton addTarget:self action:@selector(handleCaptchaButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _captchaButton;
}

- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 90;
        _line2 = view;
    }
    return _line2;
}

- (UILabel*)captchaLabel
{
    if (!_captchaLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(15);
        label.text = @"验证码";
        [label sizeToFit];
        label.centerY = 90 + 22.5;
        _captchaLabel = label;
    }
    return _captchaLabel;
}

- (UITextField *)captchaTextField {
    
    if ( !_captchaTextField ) {
        _captchaTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 90 + 3.5, SCREEN_WIDTH - 12 - 80, 38)];
        _captchaTextField.placeholder = @" 请输入验证码";
        _captchaTextField.font = FONT(15);
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
        _captchaTextField.delegate = self;
        _captchaTextField.textColor = Color_Gray42;
    }
    return _captchaTextField;
}

- (UIButton *)submitButton {
    
    if ( !_submitButton ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, self.backgroundView.bottom + 40, SCREEN_WIDTH - 40, 38);
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        [button setTitleColor:Color_Gray148 forState:UIControlStateDisabled];
        button.titleLabel.font = FONT(16);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = Color_Gray230.CGColor;
        button.backgroundColor = Color_White;
        button.enabled = NO;
        [button addTarget:self action:@selector(handleSubmitButton) forControlEvents:UIControlEventTouchUpInside];
        _submitButton = button;
    }
    return _submitButton;
}

#pragma mark - Event Response

- (void)dismissKeyBoard {
    
    [self.phoneTextField resignFirstResponder];
    [self.captchaTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];
}

- (void)handleCaptchaButton {
    
    DBG(@"handleCaptchaButton");
    
    NSString *phoneText = self.phoneTextField.text;
    
    if ( IsEmptyString(phoneText)) {
        
        [self showNotice:@"请输入手机号"];
        
        return;
    }
    [self setCaptchaButtonEnabled:NO];
    
    NSDictionary *params = @{@"phone":phoneText};
    
    weakify(self);
    [WithdrawRequest getAccountCaptchaWithParams:params success:^{
        
        strongify(self);
        
        [self setCaptchaButtonEnabled:NO];
        self.time = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [self.timer fire];
        
    } failure:^(StatusModel *status) {
        [self setCaptchaButtonEnabled:YES];
        [self showNotice:status.msg];
        
    }];
}

- (void)handleSubmitButton {
    
    DBG(@"next %@ %@", self.phoneTextField.text, self.captchaTextField.text);
    [self setSubmitButtonEnabled:NO];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafeObject:[self.phoneTextField.text trim] forKey:@"phone"];
    [params setSafeObject:self.account.method forKey:@"method"];
    [params setSafeObject:[self.captchaTextField.text trim] forKey:@"code"];
    [params setSafeObject:[self.accountTextField.text trim] forKey:@"account"];

    [WithdrawRequest bindAccountWithParams:params success:^{
        [self showNotice:@"修改账户成功"];
        [self setSubmitButtonEnabled:YES];
        self.account.account = [self.accountTextField.text trim];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clickback];
        });
    } failure:^(StatusModel *status) {
        [self setSubmitButtonEnabled:YES];
        [self showNotice:status.msg];
    }];
}

- (void)handleTimer
{
    if (self.time <= 1) {
        [self.timer invalidate];
        [self setCaptchaButtonEnabled:YES];
        [_captchaButton setTitle:@"重发验证码" forState:UIControlStateNormal];
        return;
    }
    
    [self.captchaButton setTitle:[NSString stringWithFormat:@"%lds", (long)self.time] forState:UIControlStateDisabled];
    self.time--;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self handleSubmitButton];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *phoneText = self.phoneTextField.text;
    NSString *captchaText = self.captchaTextField.text;
    NSString *accountText = self.accountTextField.text;

    if ( textField == self.phoneTextField ) {
        phoneText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    } else if ( textField == self.captchaTextField ) {
        captchaText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }else if (textField == self.accountTextField) {
        accountText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    DBG(@"next %@ %@ %@", phoneText, captchaText, string);
    
    if ( !IsEmptyString(phoneText) && !IsEmptyString(captchaText) && !IsEmptyString(accountText)) {
        [self setSubmitButtonEnabled:YES];
    } else {
        [self setSubmitButtonEnabled:NO];
    }
    
    return YES;
}
@end
