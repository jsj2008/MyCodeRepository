//
//  SDProveOperatorsController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/8.
//  Copyright © 2017年 tyiti. All rights reserved.
//

//#define _shanYin @"100244"
//
//#ifdef DEBUG
//
//#else
//
//
//#define _shanYin @"100260"
//
//#endif

#import "SDProveOperatorsController.h"
#import "SDInputView.h"
#import "SDProveHeaderView.h"
#import "SDStartProveController.h"
#import "SDUserInfo.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SDForgotOperatorPasswordView.h"
#import "SDNetworkTool.h"

@interface SDProveOperatorsController ()<UIWebViewDelegate>

//手机号
@property (nonatomic, weak) SDInputView *phoneInputView;

//服务密码
@property (nonatomic, weak) SDInputView *phonePasswordInputView;

@property (nonatomic, weak) UIView *labelView;

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, copy) NSString *requestString;

@property (nonatomic, copy) NSString *shanYin;

@end

@implementation SDProveOperatorsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shanYin = @"100260";
    
    if ([SDNetworkTool getManager].baseURL.absoluteString != BaseURLString) {
        
        _shanYin = @"100244";
    }
    
    [self addHeaderWithImage:@"progress-bar2"];
    
//    [self addContent];
    
    [self addWebView];
    
    [self addForgotPasswordButton];
}

- (void)addForgotPasswordButton{
    
    CGFloat width = [@"忘记密码" sizeOfMaxScreenSizeInFont:28 * SCALE].width + 2;

    UIButton *forgotPasswordButton = [UIButton buttonWithTitle:@"忘记密码" titleColor:SDWhiteColor titleFont:28 * SCALE];
    
    forgotPasswordButton.frame = CGRectMake(SCREENWIDTH - width - 20 * SCALE, 20, width, 44);
    
    [self.navBarContainer addSubview:forgotPasswordButton];
    
    [forgotPasswordButton addTarget:self action:@selector(showForgotOperatorPasswordView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showForgotOperatorPasswordView{

    /*
     运营商服务密码获取渠道
     中国电信: 请拨打10000，根据语音提示进行密码重置。
     中国联通: 请发送“MMCZ#6位新密码”到10010。
     中国移动: 发送“2010”到10086。
     */
    
    [SDForgotOperatorPasswordView show];
    
}

- (void)addWebView{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    CGFloat webH = self.blueView.height + 20 * SCALE;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, webH, SCREENWIDTH, SCREENHEIGHT - webH)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    //    https://open.wecash.net/auth/operator/credit_operator.html?custId=18657139770&source=100244&mobile=${mobile}&operatorAuthSuc=${}&operatorParams=${operatorParams}
    
    NSString *requestString = [NSString stringWithFormat:@"https://open.wecash.net/auth/operator/credit_operator.html?custId=%@&source=%@&mobile=%@&operatorAuthSuc=%@/common/loadpagev1&operatorParams=t:Y,u:%@",[FDUserDefaults objectForKey:FDUserAccount],_shanYin,[FDUserDefaults objectForKey:FDUserAccount],BaseURLString,user.ID];
    self.requestString = requestString;
    NSURL* url = [NSURL URLWithString:requestString];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    
    FDLog(@"requestString - %@",requestString);

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestString = [[request URL] absoluteString];
    FDLog(@"requestString - %@",requestString);
    
    
    
    
    if ([requestString containsString:@"queryT?type="]) {
        
        NSString *str = [requestString substringFromIndex:requestString.length - 1];
        
        if ([str isEqualToString:@"1"]) {
            
            [self nextButtonDidClicked];
        }else{
        
            [FDReminderView showWithString:@"认证失败, 请重新认证"];
            
            NSURL* url = [NSURL URLWithString:self.requestString];//创建URL
            NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
            [_webView loadRequest:request];//加载
            
        }
        
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    FDLog(@"--------------------");
}


- (void)addContent{
    
    CGFloat height = 100 * SCALE;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.blueView.height + 20 * SCALE, SCREENWIDTH, 200 * SCALE)];
    
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    //手机号
    SDInputView *phoneInputView = [[SDInputView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height) title:@"手机号" placeholder:@"请输入手机号"];
    self.phoneInputView = phoneInputView;
    [backView addSubview:phoneInputView];
    phoneInputView.inputTextField.enabled = NO;
    
    self.phoneInputView.inputTextField.text = [FDUserDefaults objectForKey:FDUserAccount];
    
    //服务密码
    SDInputView *phonePasswordInputView = [[SDInputView alloc] initWithFrame:CGRectMake(0, height, SCREENWIDTH, height) title:@"服务密码" placeholder:@"请输入手机服务密码"];
    self.phonePasswordInputView = phonePasswordInputView;
    [backView addSubview:phonePasswordInputView];
    
    //虚线
    CGFloat nameX = 30 * SCALE;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(nameX, height, SCREENWIDTH - 2 * nameX, 1 * SCALE)];
    lineView.backgroundColor = FDColor(240, 240, 240);
    [backView addSubview:lineView];
    
    
    
    //下一步
    CGFloat buttonY = CGRectGetMaxY(backView.frame) + 60 * SCALE;
    CGFloat buttonX = 30 * SCALE;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = height;
    
    UIButton *nextButton = [UIButton roundButtonWithTitle:@"下一步" titleColor:[UIColor whiteColor] titleFont:36 * SCALE backgroundColor:FDColor(70, 151, 251) frame:CGRectMake(buttonX,buttonY,buttonW,buttonH)];
    [self.view addSubview:nextButton];
    
    [nextButton addTarget:self action:@selector(nextButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码
    UIButton *forgetPasswordButton = [UIButton buttonWithTitle:@" 忘记密码" titleColor:FDColor(153, 153, 153) titleFont:28 * SCALE imageNamed:@"small_icon_right"];
    
    forgetPasswordButton.width = [@"忘记密码" sizeOfMaxScreenSizeInFont:28 * SCALE].width + 20;
    forgetPasswordButton.height = 30 * SCALE;
    forgetPasswordButton.centerX = SCREENWIDTH/2;
    forgetPasswordButton.y = buttonY + buttonH + 40 * SCALE;
    
    [self.view addSubview:forgetPasswordButton];
    
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //提示文字
    CGFloat labelY = CGRectGetMaxY(nextButton.frame) + 150 * SCALE;
    CGFloat font = 24 * SCALE;
    CGFloat labelX = nameX;
    CGFloat labelW = SCREENWIDTH - labelX - 70 * SCALE;
    CGFloat labelH = [@"运营" sizeOfMaxScreenSizeInFont:font].height;
    CGFloat labelBlank = 16 * SCALE;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, labelY, SCREENWIDTH, 200)];
    self.labelView = labelView;
    labelView.hidden = YES;
    [self.view addSubview:labelView];
    
    UILabel *noticeLabel1 = [UILabel labelWithText:@"运营商服务密码获取渠道" textColor:FDColor(153, 153, 153) font:font textAliment:0];
    noticeLabel1.frame = CGRectMake(labelX, 0, labelW, labelH);
    [labelView addSubview:noticeLabel1];
    
    // 创建一个Label
    UILabel *noticeLabel2 = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:font textAliment:0];
    noticeLabel2.frame = CGRectMake(labelX, labelH + labelBlank, labelW, labelH * 2 + labelBlank);
    [labelView addSubview:noticeLabel2];
    
    // 设置为多行显示
    noticeLabel2.numberOfLines = 0;
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:labelBlank];
    
    
    NSString *oprater = [self.phoneInputView.inputTextField.text getOperators];
    NSString *tel = [oprater getOperatorsTel];
    NSString  *testString = [NSString stringWithFormat:@"%@: 尊敬的用户, 您可以拨打%@, 根据语音提示进行密码重置",oprater,tel];
    NSMutableAttributedString  *setString = [self attributedTextWithColor:FDColor(153, 153, 153) font:font str:testString];
    
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    
    // 设置Label要显示的text
    [noticeLabel2  setAttributedText:setString];
    
}

- (void)nextButtonDidClicked{
    
//    SDStartProveController *startCon = [[SDStartProveController alloc] init];
//    [startCon addContentWithImageNamed:@"bg_icon_OK"];
//    [startCon addHeaderWithImage:@"progress-bar3"];
//    [self.navigationController pushViewController:startCon animated:YES];

    [self leftBtnDidTouch];
    
    [@"运营商认证中, 下拉查看最新结果" showNotice];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phoneInputView.inputTextField endEditing:YES];
    [self.phonePasswordInputView.inputTextField endEditing:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

#pragma mark - 生成一个带有属性的文字
- (NSMutableAttributedString *)attributedTextWithColor:(UIColor *)color font:(NSInteger)font str:(NSString *)str{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str];
    //设置字号
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, str.length)];
    //设置文字颜色
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    
    return attributedText;
    
}

- (void)forgetPasswordButtonDidClicked:(UIButton *)button{

    self.labelView.hidden = NO;
}

- (void)leftBtnDidTouch{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
