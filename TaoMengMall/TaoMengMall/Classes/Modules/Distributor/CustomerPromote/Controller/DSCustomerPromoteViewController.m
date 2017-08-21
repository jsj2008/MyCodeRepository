//
//  DSCustomerPromoteViewController.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSCustomerPromoteViewController.h"
#import "CustomerPromoteRequest.h"
#import "DistributorHeader.h"
#import "XMShareView.h"

@interface DSCustomerPromoteViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *captchaTextField;
@property (nonatomic, strong) UIButton *captchaButton;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) XMShareView *shareView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;


@property (nonatomic, strong) ShareInfoModel *shareInfo;
@property (nonatomic, strong) NSString *tips;
@end

@implementation DSCustomerPromoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_White;
    [self addNavigationBar];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 32);
    rightButton.titleLabel.font = FONT(18);
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = rightButton;
    
    self.title = @"分销拓展";
    [self initData];
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [CustomerPromoteRequest getCustomerPromoteDataWithParams:params success:^(DSCustomerPromoteResultModel *resultModel) {
        self.shareInfo = resultModel.share;
        self.tips = resultModel.content;
        [self render];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

- (void)render
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.iconImageView];
    [self.scrollView addSubview:self.phoneTextField];
    [self.scrollView addSubview:self.captchaTextField];
    [self.scrollView addSubview:self.captchaButton];
    [self.scrollView addSubview:self.submitButton];
    [self.scrollView addSubview:self.tipsLabel];
    
    //self.tips = @"1、销售控价别低于价格区间里面的最低价，具体的可以参考价 格表，严格按照控价执行，切勿乱价优惠券。\n2、分销商等级折扣规则，具体采购价视后期划分时定。\n";
    self.tipsLabel.text = self.tips;
    CGSize size = [self.tips?self.tips:@"" boundingRectWithSize:CGSizeMake( SCREEN_WIDTH-40, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(12)} context:nil].size;
    self.tipsLabel.size = size;
    if (self.submitButton.bottom + 40 + size.height + 12 > self.scrollView.height) {
        self.tipsLabel.top = self.submitButton.bottom + 40;
        CGSize contentSize = self.scrollView.contentSize;
        contentSize.height = self.submitButton.bottom + 40 + size.height + 12;
        self.scrollView.contentSize = contentSize;
    }else{
        self.tipsLabel.bottom = self.scrollView.height - 20;
    }
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
#pragma mark -
- (void)handleRightButton
{
    if (!self.shareInfo) {
        [self showNotice:@"分享信息获取失败，请稍后再试"];
        return;
    }
    self.shareView.shareInfo = self.shareInfo;
    [self.shareView show];

    //UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信好友", @"微信朋友圈", nil];
    //[actionSheet showInView:self.view];
}

#pragma mark - Subviews
- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT,SCREEN_WIDTH , SCREEN_HEIGHT-NAVBAR_HEIGHT)];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*2/3)];
        imageView.image = [UIImage imageNamed:@"icon_distributor_tree"];
        imageView.centerX = SCREEN_WIDTH/2;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UITextField *)phoneTextField {
    
    if ( !_phoneTextField ) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(52, self.iconImageView.bottom + 20, SCREEN_WIDTH - 52 - 52, 38)];
        _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneTextField.placeholder = @" 请输入客户手机号";
        _phoneTextField.font = FONT(14);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.textColor = Color_Gray42;
    }
    return _phoneTextField;
}

- (UITextField *)captchaTextField {
    
    if ( !_captchaTextField ) {
        _captchaTextField = [[UITextField alloc] initWithFrame:CGRectMake(52, self.iconImageView.bottom + 68, SCREEN_WIDTH - 52 - 132 - 52, 38)];
        _captchaTextField.borderStyle = UITextBorderStyleRoundedRect;
        _captchaTextField.placeholder = @" 请输入验证码";
        _captchaTextField.font = FONT(14);
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
        _captchaTextField.delegate = self;
        _captchaTextField.textColor = Color_Gray42;
    }
    return _captchaTextField;
}

- (UIButton *)captchaButton {
    
    if ( !_captchaButton ) {
        _captchaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _captchaButton.frame = CGRectMake(0, self.iconImageView.bottom + 68, 120, 38);
        _captchaButton.right = SCREEN_WIDTH - 52;
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

- (UIButton *)submitButton {
    
    if ( !_submitButton ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(52, self.iconImageView.bottom + 116, SCREEN_WIDTH - 104, 38);
        [button setTitle:@"提交" forState:UIControlStateNormal];
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

- (UILabel*)tipsLabel
{
    if (!_tipsLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 0, 0)];
        label.font = FONT(12);
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.textColor = Color_Gray153;
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (XMShareView*)shareView
{
    if (!_shareView) {
        _shareView = [[XMShareView alloc]init];
    }
    return _shareView;
}

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
    [self setCaptchaButtonEnabled:NO];
    
    NSDictionary *params = @{@"phone":phoneText};
    
    weakify(self);
    [CustomerPromoteRequest getCustomerCaptchaWithParams:params success:^{
        
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
    [params setSafeObject:[self.captchaTextField.text trim] forKey:@"code"];
    
    [CustomerPromoteRequest inviteCustomerWithParams:params success:^{
        [self showNotice:@"邀请客户成功"];
        [self setSubmitButtonEnabled:YES];
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
    
    if ( textField == self.phoneTextField ) {
        phoneText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    } else if ( textField == self.captchaTextField ) {
        captchaText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    DBG(@"next %@ %@ %@", phoneText, captchaText, string);
    
    if ( !IsEmptyString(phoneText) && !IsEmptyString(captchaText) ) {
        [self setSubmitButtonEnabled:YES];
    } else {
        [self setSubmitButtonEnabled:NO];
    }
    
    return YES;
}
@end
