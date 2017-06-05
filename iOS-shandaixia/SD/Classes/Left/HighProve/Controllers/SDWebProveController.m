//
//  SDWebProveController.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDWebProveController.h"
#import "SDUserInfo.h"
#import "MoxieSDK.h"

@interface SDWebProveController ()<UIWebViewDelegate,MoxieSDKDelegate>




@end

@implementation SDWebProveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SDWhiteColor;
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)startType:(NSString *)type{
    
    
    
    
}

- (void)addWebViewWithUrlString:(NSString *)urlString{
    
    CGFloat webH = 64;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, webH, SCREENWIDTH, SCREENHEIGHT - webH)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    //    https://open.wecash.net/auth/operator/credit_operator.html?custId=18657139770&source=100244&mobile=${mobile}&operatorAuthSuc=${}&operatorParams=${operatorParams}
    
//    [NSString stringWithFormat:@"https://open.wecash.net/auth/operator/credit_operator.html?custId=18657139770&source=100244&mobile=%@&operatorAuthSuc=http://116.62.26.225:8080/common/loadpage&operatorParams=t:Y,u:%@",[FDUserDefaults objectForKey:FDUserAccount],user.ID]
    
    
    NSURL* url = [NSURL URLWithString:urlString];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    
}

#pragma MoxieSDK Delegate 
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *searchId = resultDictionary[@"searchId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,searchId:%@,message:%@,account:%@",code,taskType,taskId,searchId,message,account); //假如code是2则继续查询该任务进展
    if(code == 2){
    } //假如code是1则成功
    else if(code == 1){
    } // 户没有做任何操作
    else if(code == -1){
    } //该任务失败按失败处
    else{
    }
}

@end
