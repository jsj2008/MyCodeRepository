//
//  SDLoanSSQSignViewController.m
//  SD
//
//  Created by LayZhang on 2017/5/11.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDLoanSSQSignViewController.h"
#import "SDSSQStatus.h"

@interface SDLoanSSQSignViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) NSString *pushSignid;



@end

@implementation SDLoanSSQSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavBarWithTitle:@"签署协议"];
    //    [self loadSignid];
    [self loadWebView];
    [self loadSignPageSignimagePc];
}



- (void)loadSignPageSignimagePc {
    
    [SDSSQStatus getSignPageSignimagePc:self.signid
                          finishedBlock:^(id object) {
                              NSString *requestString = object;
                              NSURL* url = [NSURL URLWithString:requestString];//创建URL
                              NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
                              [self.webView loadRequest:request];//加载
                          } failuredBlock:^(id object) {
                              
                          }];
}

- (void)loadWebView {
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    
    //    https://open.wecash.net/auth/operator/credit_operator.html?custId=18657139770&source=100244&mobile=${mobile}&operatorAuthSuc=${}&operatorParams=${operatorParams}
    
    //    NSString *requestString = [NSString stringWithFormat:@"https://open.wecash.net/auth/operator/credit_operator.html?custId=%@&source=%@&mobile=%@&operatorAuthSuc=%@/common/loadpagev1&operatorParams=t:Y,u:%@",[FDUserDefaults objectForKey:FDUserAccount],_shanYin,[FDUserDefaults objectForKey:FDUserAccount],BaseURLString,user.ID];
}

#pragma mark - uiwebview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
    FDLog(@"start --------");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestString = [[request URL] absoluteString];
    FDLog(@"requestString - %@",requestString);
    if ([requestString containsString:@"code="]) {
        if ([requestString containsString:@"code=100000"]) {
            self.pushSignid = self.signid;
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [@"签署协议失败，请稍后再试" showNotice];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    FDLog(@"--------------------");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SDNotificationCenter postNotificationName:SDSSQManualNoticifation
                                        object:self.pushSignid];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
