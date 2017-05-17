//
//  ReviewView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ReviewView.h"
#import "NJKWebViewProgress.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface ReviewView()<UIWebViewDelegate, NJKWebViewProgressDelegate> {
    NJKWebViewProgress *_progressProxy;
}

@end

@implementation ReviewView

@synthesize reviewWebView;
@synthesize progressView;

- (void)initContent {
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    reviewWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
   
}

- (void)loadWebView{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.feib.com.tw/foreignexchange/detail4.aspx"]];
    [reviewWebView loadRequest:request];
}


#pragma override
- (void)reloadPageData {
    [super reloadPageData];
    [self loadWebView];
}

- (void)pageUnSelect {
    [super pageUnSelect];
}

- (void)pageSelect {
    [super pageSelect];
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_FOREGIN subType:APP_OPT_TYPE_FOREGIN_ITEM_3];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    reviewWebView.scalesPageToFit = YES;
    [reviewWebView setMultipleTouchEnabled:true];
    [progressView setProgress:progress animated:YES];
//    self.title = [reviewWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
