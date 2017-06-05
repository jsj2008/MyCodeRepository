//
//  SDJDController.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//
//#define shanYin @"100244"
//
//#ifdef DEBUG
//
//#else
//
//
//#define shanYin @"100260"
//
//#endif

#import "SDJDController.h"
#import "SDNetworkTool.h"
#import "SDUserInfo.h"

@interface SDJDController ()

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) NSString *shanYin;

@end

@implementation SDJDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavBarWithTitle:@"京东认证"];
    
    _shanYin = @"100260";
    
    if ([SDNetworkTool getManager].baseURL.absoluteString != BaseURLString) {

        _shanYin = @"100244";
    }
    
    
    NSString *returnUrl = [NSString stringWithFormat:@"%@/common/loadpage?t=J&u=%@",BaseURLString,[SDUserInfo getUserInfo].ID];
    
    returnUrl = [returnUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)returnUrl,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    
    FDLog(@"encodedString - %@",encodedString);
    
    NSString *urlString = [NSString stringWithFormat:@"https://open.wecash.net/auth/genui/index.html#login/jingdong/%@/%@?returnUrl=%@",_shanYin,[FDUserDefaults objectForKey:FDUserAccount],encodedString];
    
    self.urlString = urlString;
    
    [self addWebViewWithUrlString:urlString];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString - %@",requestString);
    
    if ([requestString containsString:@"queryT?type="]) {
        
        NSString *str = [requestString substringFromIndex:requestString.length - 1];
        
        if ([str isEqualToString:@"1"]) {
            
            [FDReminderView showWithString:@"认证成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [SDNotificationCenter postNotificationName:SDHighProveSuccessNotification object:nil userInfo:@{SDHighProveSpeedCount:@"20"}];
            
        }else{
            
            [FDReminderView showWithString:@"认证失败, 请重新认证"];
            
            NSURL* url = [NSURL URLWithString:self.urlString];//创建URL
            NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
            [self.webView loadRequest:request];//加载
            
        }
        
    }
    
    return YES;
}
@end
