//
//  ReviewViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/18.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ReviewViewController.h"
#import "IosLayoutDefine.h"
#import "TopBarView.h"
#import "LangCaptain.h"
#import "IosLogic.h"

#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface ReviewViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate> {
    UIWebView *_webView;
    TopBarView *_topBar;
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self initPreData];
    [self initLayout];
    [self initWebView];
}

- (void)initWebView {
    CGRect webViewRect = CGRectMake(0,
                                    SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,
                                    SCREEN_WIDTH,
                                    SCREEN_HEIGHT - SCREEN_TOPST_HEIGHT - SCREEN_STATUS_BAR);
    _webView = [[UIWebView alloc] initWithFrame:webViewRect];
    _webView.scalesPageToFit = YES;
    [_webView setMultipleTouchEnabled:true];
    [self.view addSubview:_webView];
    [_webView setBackgroundColor:[UIColor blackColor]];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
//    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barBounds = _topBar.bounds;
    CGRect barFrame = CGRectMake(0, barBounds.size.height - progressBarHeight, barBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    [_topBar addSubview:_progressView];

    
    [self loadWebView];
}

- (void)initLayout{
    [self initTopBar];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [self initWebView];
    
    if (IOS7_OR_LATER) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)loadWebView{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.feib.com.tw/foreignexchange/detail4.aspx"]];
    [_webView loadRequest:request];
}

- (void)initTopBar{
    _topBar = [[TopBarView alloc] init];
    
    [_topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"ForexDailyReview"] withMidButton:nil];
    [self.view addSubview:_topBar];
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
    CGRect imageRect = CGRectMake(0, 0, 20, 20);
    
    //    [leftButton setFrame:[ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(12, 12, 28, 28)]];
    [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton addTarget:self action:@selector(rebackToForexNewsViewController) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [leftButton addSubview:leftView];
    [leftView setImage:[UIImage imageNamed:@"images/normal/reback.png"]];
    [leftView setCenter:centerPoint];
    
    [_topBar addSubview:leftButton];
}

- (void)rebackToForexNewsViewController {
    [[IosLogic getInstance] gotoForexNewsViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    _webView.scalesPageToFit = YES;
    [_webView setMultipleTouchEnabled:true];
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
