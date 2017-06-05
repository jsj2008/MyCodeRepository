//
//  SDSSQProtocolController.m
//  SD
//
//  Created by LayZhang on 2017/5/12.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDSSQProtocolController.h"

@interface SDSSQProtocolController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView* webView;

@end

@implementation SDSSQProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SDWhiteColor;
    [self createNavBarWithTitle:@"借款协议"];
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    NSString *requestString = self.url;
    NSURL* url = [NSURL URLWithString:requestString];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载

}

#pragma mark - uiwebview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
    FDLog(@"start --------");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    FDLog(@"--------------------");
}

@end
