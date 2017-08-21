//
//  RegisterStepOneViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/4.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BindingViewController.h"
#import "RegisterStepTwoViewController.h"
#import "UserRequest.h"
#import "XMAppThemeHelper.h"
#import "WXApiManager.h"
#import "ThirdPartLoginView.h"


@interface BindingViewController () <UITextFieldDelegate,WXApiManagerDelegate>

@property (nonatomic, strong) UIView *headBackgroundView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *zoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *lineView1;


@property (nonatomic, strong) UITextField *captchaTextField;
@property (nonatomic, strong) UIButton *captchaButton;
@property (nonatomic, strong) UIView *lineView2;


@property (nonatomic, strong) UIButton *nextButton;
//@property (nonatomic, strong) UILabel *tipsLabel;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) NSString *imageURL;

@end

@implementation BindingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_White;
    
    [self addNavigationBar];
    
    self.title = @"绑定手机号";
    
    [self render];
    
    //[WXApiManager sharedManager].delegate = self;
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.avatar] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [UserRequest uploadImageWithParams:nil image:image success:^(ImageUploadResultModel *resultModel) {
            self.imageURL = resultModel.url;
        } failure:^(StatusModel *status) {
            
        }];
    }];
}

#pragma mark - Private Methods

- (void) render
{
    [self.view addSubview:self.headBackgroundView];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.zoneLabel];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.lineView1];
    
    [self.view addSubview:self.captchaTextField];
    [self.view addSubview:self.captchaButton];
    [self.view addSubview:self.lineView2];
    
    [self.view addSubview:self.nextButton];
    // [self.view addSubview:self.tipsLabel];
}

- (void)setCaptchaButtonEnabled: (BOOL)enabled {
    
    if ( enabled ) {
        self.captchaButton.enabled = YES;
        self.captchaButton.backgroundColor = Theme_Color;
    } else {
        self.captchaButton.enabled = NO;
        self.captchaButton.backgroundColor = Color_Gray(235);
    }
    
}

- (void)setNextButtonEnabled: (BOOL)enabled {
    
    if ( enabled ) {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [XMAppThemeHelper defaultTheme].mainThemeColor;
        //self.nextButton.layer.borderColor = [XMAppThemeHelper defaultTheme].mainThemeColor.CGColor;
    } else {
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = Color_Gray(235);
        //self.nextButton.layer.borderColor = Color_Gray230.CGColor;
    }
    
}

#pragma mark - Getters And Setters
- (UIView*)headBackgroundView
{
    if (!_headBackgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH,IS_IPHONE4?120: 160)];
        view.backgroundColor = Color_White;
        _headBackgroundView = view;
    }
    return _headBackgroundView;
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.image = [UIImage imageNamed:@"login_head_icon"];
        imageView.centerX = SCREEN_WIDTH/2;
        imageView.top = 102;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel *)zoneLabel {
    
    if ( !_zoneLabel ) {
        _zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _zoneLabel.textColor = Color_Gray42;
        _zoneLabel.font = FONT(16);
        _zoneLabel.text = @"+86";
        [_zoneLabel sizeToFit];
        _zoneLabel.left = 50 + 25;
        _zoneLabel.bottom = self.lineView1.top - 4;
    }
    
    return _zoneLabel;
}

- (UITextField *)phoneTextField {
    
    if ( !_phoneTextField ) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, SCREEN_WIDTH - 40 - 90, 32)];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.font = FONT(14);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.textColor = Color_Gray42;
        _phoneTextField.left = self.zoneLabel.right + 40;
        _phoneTextField.centerY = self.zoneLabel.centerY;
        _phoneTextField.width = self.lineView1.right - _phoneTextField.left;
    }
    
    return _phoneTextField;
    
}

- (UIView *)lineView1 {
    
    if ( !_lineView1 ) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake( 50, 13,SCREEN_WIDTH - 50*2, 1)];
        _lineView1.backgroundColor = Color_Gray(229);
        _lineView1.top = self.headBackgroundView.bottom + (IS_IPHONE4?32:56);
    }
    
    return _lineView1;
}

- (UITextField *)captchaTextField {
    
    if ( !_captchaTextField ) {
        _captchaTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40 - 154 - 40, 32)];
        _captchaTextField.borderStyle = UITextBorderStyleNone;
        _captchaTextField.placeholder = @"请输入验证码";
        _captchaTextField.font = FONT(14);
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
        _captchaTextField.delegate = self;
        _captchaTextField.textColor = Color_Gray42;
        _captchaTextField.bottom = self.lineView2.bottom;
        _captchaTextField.left = 50;
        _captchaTextField.width = self.lineView1.width - 62 - 12;
    }
    
    return _captchaTextField;
    
}

- (UIButton *)captchaButton {
    
    if ( !_captchaButton ) {
        _captchaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _captchaButton.frame = CGRectMake(0, 110 + NAVBAR_HEIGHT, 97, 35);
        _captchaButton.right = SCREEN_WIDTH - 20;
        [_captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_captchaButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_captchaButton setTitleColor:Color_Gray(178) forState:UIControlStateDisabled];
        _captchaButton.titleLabel.font = FONT(16);
        _captchaButton.layer.masksToBounds = YES;
        _captchaButton.layer.cornerRadius = 4;
        _captchaButton.backgroundColor = Color_Gray(235);
        [_captchaButton addTarget:self action:@selector(handleCaptchaButton) forControlEvents:UIControlEventTouchUpInside];
        _captchaButton.enabled = NO;
        _captchaButton.bottom = self.lineView2.top - 4;
        _captchaButton.right = self.lineView2.right - 12;
    }
    
    return _captchaButton;
}

- (UIView *)lineView2 {
    
    if ( !_lineView2 ) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake( 50, 12,SCREEN_WIDTH - 50*2, 1)];
        _lineView2.backgroundColor = Color_Gray(229);
        _lineView2.top = self.lineView1.bottom + 48;
    }
    
    return _lineView2;
}

- (UIButton *)nextButton {
    
    if ( !_nextButton ) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(30, 270 + NAVBAR_HEIGHT, SCREEN_WIDTH - 30*2, 44);
        [_nextButton setTitle:@"绑定" forState:UIControlStateNormal];
        [_nextButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_nextButton setTitleColor:Color_Gray(178) forState:UIControlStateDisabled];
        _nextButton.titleLabel.font = FONT(18);
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 4;
        //_nextButton.layer.borderWidth = 1;
        //_nextButton.layer.borderColor = RGB(186, 189, 193).CGColor;
        _nextButton.backgroundColor = RGB(235, 235, 235);
        _nextButton.enabled = NO;
        [_nextButton addTarget:self action:@selector(handleNextButton) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.top = self.lineView2.bottom + 28;
        
    }
    
    return _nextButton;
}


//- (UILabel*)tipsLabel
//{
//    if (!_tipsLabel) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 0)];
//        label.font = FONT(14);
//        label.lineBreakMode = NSLineBreakByCharWrapping;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.numberOfLines = 2;
//        label.text = @"绑定手机后，家人发布的内容您将可以第一时间看到。";
//        [label sizeToFit];
//        label.centerX = SCREEN_WIDTH/2;
//        label.top = self.nextButton.bottom + 18;
//        _tipsLabel = label;
//    }
//    return _tipsLabel;
//}

#pragma mark - Event Response

- (void)dismissKeyBoard {
    
    [self.phoneTextField resignFirstResponder];
    [self.captchaTextField resignFirstResponder];
    
}

- (void)handleCaptchaButton {
    
    DBG(@"handleCaptchaButton");

    NSString *phoneText = self.phoneTextField.text;
    
    if ( IsEmptyString(phoneText)) {
        
        [self showNotice:@"请输入手机号"];
        
        return;
    }
    
    NSDictionary *params = @{@"phone":phoneText};
    
    weakify(self);
    [self setCaptchaButtonEnabled:NO];
    [UserRequest getCaptchaWithParams:params success:^{
        
        strongify(self);
        
        self.time = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [self.timer fire];
        
    } failure:^(StatusModel *status) {
        [self setCaptchaButtonEnabled:YES];
        [self showNotice:status.msg];
        
    }];
}

- (void)handleNextButton {
    
    [self dismissKeyBoard];
    
    DBG(@"next %@ %@", self.phoneTextField.text, self.captchaTextField.text);

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setSafeObject:[self.phoneTextField.text trim] forKey:@"phone"];
    [params setSafeObject:[self.captchaTextField.text trim] forKey:@"code"];
    
//    [params setSafeObject:self.thirdpartType forKey:@"type"];
//    [params setSafeObject:self.name forKey:@"name"];
//    [params setSafeObject:self.openId forKey:@"openId"];
//    [params setSafeObject:self.imageURL forKey:@"avatar"];
//    [params setSafeObject:self.gender forKey:@"gender"];
    
    weakify(self);
    [self setNextButtonEnabled:NO];
    
    [UserRequest checkRegisterWithParams:params success:^(NSDictionary *result) {
        [self setNextButtonEnabled:YES];

        if ([result[@"isReg"] intValue] == 1) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setSafeObject:[self.phoneTextField.text trim] forKey:@"phone"];
            [params setSafeObject:[self.captchaTextField.text trim] forKey:@"code"];
            
            [params setSafeObject:self.thirdpartType forKey:@"type"];
            [params setSafeObject:self.name forKey:@"name"];
            [params setSafeObject:self.openId forKey:@"openId"];
            [params setSafeObject:self.imageURL?self.imageURL:self.avatar forKey:@"avatar"];
            [params setSafeObject:self.gender forKey:@"gender"];
            
            [UserRequest thirdBindingWithParams:params success:^(LRUserInfoResultModel *resultModel) {
                [self setNextButtonEnabled:YES];
                
                strongify(self);
                BDUserInfoModel *model = resultModel.user;
                [UserService sharedService].userId = model.userId;
                [UserService sharedService].name = model.name;
                [UserService sharedService].avatar = model.avatar;
                [UserService sharedService].phone = model.phone;
                [UserService sharedService].sign = model.sign;
                [UserService sharedService].gender = model.gender;
                [UserService sharedService].isLogin = YES;
                [[UserService sharedService] saveLoginInfo];
                
                [self showNotice:@"登录成功"];
                
                NSMutableDictionary *p = [NSMutableDictionary dictionary];
                [p setSafeObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"deviceToken"];
                [UserRequest uploadPushTokenWithParams:p success:^{
                    NSLog(@"success upload");
                    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lastUploadToken"];
                } failure:^(StatusModel *status) {
                    NSLog(@"failed upload");
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lastUploadToken"];
                }];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } failure:^(StatusModel *status) {
                [self setNextButtonEnabled:YES];
                [self showNotice:@"登录失败"];
            }];

        }else{
            TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
            RegisterStepTwoViewController *vc = [[RegisterStepTwoViewController alloc] init];
            vc.phone = [self.phoneTextField.text trim];
            vc.code = [self.captchaTextField.text trim];
            
            vc.thirdpartType = self.thirdpartType;
            vc.openId = self.openId;
            vc.name = self.name;
            vc.avatar = self.imageURL?self.imageURL:self.avatar;
            vc.gender = self.gender;
            [navigationController pushViewController:vc animated:YES];
        }
    } failure:^(StatusModel *status) {
        [self setNextButtonEnabled:YES];
        [self showNotice:status.msg];
    }];

    
}

- (void)handleTimer
{
    if (self.time <= 1) {
        [self.timer invalidate];
        [self setCaptchaButtonEnabled:YES];
        [_captchaButton setTitle:@"重新获取" forState:UIControlStateNormal];
        return;
    }
    
    [self.captchaButton setTitle:[NSString stringWithFormat:@"%lds", (long)self.time] forState:UIControlStateDisabled];
    self.time--;
}


- (void)checkNextButton
{
    NSString *phoneText = self.phoneTextField.text;
    NSString *captchaText = self.captchaTextField.text;
    if ( !IsEmptyString(phoneText) && !IsEmptyString(captchaText)) {
        [self setNextButtonEnabled:YES];
    } else {
        [self setNextButtonEnabled:NO];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self handleNextButton];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *phoneText = self.phoneTextField.text;
    NSString *captchaText = self.captchaTextField.text;
    
    if ( textField == self.phoneTextField ) {
        phoneText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (!self.captchaButton.enabled&&!IsEmptyString(phoneText)) {
            [self setCaptchaButtonEnabled:YES];
        }

    } else if ( textField == self.captchaTextField ) {
        captchaText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    DBG(@"next %@ %@ %@", phoneText, captchaText, string);
    
    if ( !IsEmptyString(phoneText) && !IsEmptyString(captchaText)) {
        [self setNextButtonEnabled:YES];
    } else {
        [self setNextButtonEnabled:NO];
    }
    return YES;
}


@end
