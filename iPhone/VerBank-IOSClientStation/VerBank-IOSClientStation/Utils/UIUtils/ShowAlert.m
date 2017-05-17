//
//  ShowAlert.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ShowAlert.h"
#import "IosLogic.h"
#import "MActivityIndicatorView.h"
#import "LangCaptain.h"
#import "UnderLineLabel.h"

static ShowAlert *showAlert = nil;

@interface ShowAlert()<UIAlertViewDelegate>{
    UIWindow *_uiWindow;
    UIAlertView *_alertView;
    UIAlertView *_chooseableAlertView;
    UIAlertView *_jumpAlertView;
    UIAlertView *_dismissionAlertView;
    UIActivityIndicatorView *_indicatorView;
    MActivityIndicatorView *_mIndicatorView;
    
    NSLock *jumpViewLock;
}



@end

@implementation ShowAlert

@synthesize alertView = _alertView;
@synthesize chooseableAlertView = _chooseableAlertView;
@synthesize jumpAlertView = _jumpAlertView;

+ (id)getInstance{
    if (showAlert == nil) {
        showAlert = [[ShowAlert alloc] init];
    }
    return showAlert;
}

- (id)init{
    if (self = [super init]) {
        _uiWindow = [[IosLogic getInstance] getWindow];
        jumpViewLock = [[NSLock alloc] init];
    }
    return self;
}

- (void)showJumpAlertView:(NSString *)title andMessage:(NSString *)message delegate:(id)delegate{
    @synchronized(jumpViewLock) {
        if(_jumpAlertView != nil){
            NSLog(@".............. dis missing ..");
            [_jumpAlertView setDelegate:nil];
            //            [_jumpAlertView dismissWithClickedButtonIndex:[_jumpAlertView cancelButtonIndex] animated:NO];
            [_jumpAlertView removeFromSuperview];
            _jumpAlertView = nil;
        }
        
        _jumpAlertView = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                                          otherButtonTitles:nil];
        [_jumpAlertView show];
        //        [_jumpAlertView setFrame:[delegate frame]];
        //        [delegate addSubview:_jumpAlertView];
        
    }
    
}

// normal
- (void)showAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message {
    @synchronized(_alertView) {
        if(_alertView != nil){
            [_alertView setDelegate:nil];
            //            [_alertView dismissWithClickedButtonIndex:[_alertView cancelButtonIndex] animated:NO];
            [_alertView removeFromSuperview];
            _alertView = nil;
        }
        
        //暂时这么写
        if ([message containsString:@"809"]) {
            _alertView = [[UIAlertView alloc] initWithTitle:title
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                                          otherButtonTitles:nil];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 50)];
            //        [view setBackgroundColor:[UIColor blackColor]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneNumber)];
            [view addGestureRecognizer:tap];
            
            //        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 40)];
            //        [label setText:message];
            //        [view addSubview:label];
            //        [label sizeToFit];
            UILabel *label = [[UILabel alloc] init];
            [label setText:message];
            [label setNumberOfLines:0];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            
            CGSize constraint = CGSizeMake(250, 20000.0f);
            
            CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:14.0f]
                              constrainedToSize:constraint
                                  lineBreakMode:NSLineBreakByWordWrapping];
            
            [label setFrame:CGRectMake(10, 0, size.width, size.height)];
            
            [view addSubview:label];
            
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
                [_alertView setValue:view forKey:@"accessoryView"];
            }else{
                [_alertView addSubview:view];
            }
        } if ([message containsString:@"AppStore"]) {
            _alertView = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"Update"]
                                          otherButtonTitles:nil];
            [_alertView setDelegate:self];
        }else {
            _alertView = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                                         otherButtonTitles:nil, nil];
        }
        [_alertView show];
    }
}

- (void)callPhoneNumber {
    if(_alertView != nil){
        [_alertView setDelegate:nil];
        //        [_alertView dismissWithClickedButtonIndex:[_alertView cancelButtonIndex] animated:NO];
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    NSString *phoneNumber = [[LangCaptain getInstance] getLangByCode:@"PhoneNumber"];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]];
    
    UIWebView * webView = [[UIWebView alloc] init];
    [[[IosLogic getInstance] getWindow].rootViewController.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self callAppStoreURL];
    [alertView setDelegate:nil];
}

- (void)callAppStoreURL {
    NSURL *appStoreURL = [NSURL URLWithString: [[LangCaptain getInstance] getLangByCode:@"AppStoreUrl"]];
    //    Boolean isOpen = [[UIApplication sharedApplication] openURL:myURL];
    [[UIApplication sharedApplication] openURL:appStoreURL];
}


// chooseable
- (void)showChooseableAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message delegate:(id)delegate{
    @synchronized(_chooseableAlertView) {
        if(_chooseableAlertView != nil){
            //            [_chooseableAlertView dismissWithClickedButtonIndex:[_chooseableAlertView cancelButtonIndex] animated:NO];
            [_chooseableAlertView setDelegate:nil];
            [_chooseableAlertView removeFromSuperview];
            _chooseableAlertView = nil;
        }
        
        _chooseableAlertView = [[UIAlertView alloc]initWithTitle:title
                                                         message:message
                                                        delegate:delegate
                                               cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"]
                                               otherButtonTitles:[[LangCaptain getInstance] getLangByCode:@"YES"], nil];
        [_chooseableAlertView show];
    }
}

- (void)showDisMissAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message {
    @synchronized(_dismissionAlertView) {
        if(_dismissionAlertView != nil){
            //            [_dismissionAlertView dismissWithClickedButtonIndex:[_dismissionAlertView cancelButtonIndex] animated:NO];
            [_dismissionAlertView setDelegate:nil];
            [_dismissionAlertView removeFromSuperview];
            _dismissionAlertView = nil;
        }
        
        _dismissionAlertView = [[UIAlertView alloc]initWithTitle:title
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:nil
                                               otherButtonTitles:nil, nil];
        [_dismissionAlertView show];
        
        [self performSelector:@selector(dimissAlert:)  withObject:_dismissionAlertView afterDelay:0.5f];
    }
}


- (void) dimissAlert:(UIAlertView *)alert {
    //    @synchronized(_dismissionAlertView) {
    //        NSLog(@"dissmissAlert;=========");
    //        if(_dismissionAlertView != nil)     {
    //            NSLog(@"dissmissAlert;---------");
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    //            NSLog(@"dissmissAlert;---------+");
    //        }
    //    }
}

- (void)showActivityIndicator{
    
    if (_uiWindow == nil || _uiWindow.rootViewController == nil) {
        return;
    }
    
    if(_indicatorView == nil){
        _indicatorView = [[UIActivityIndicatorView alloc]
                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    
    UIView * showInView = _uiWindow.rootViewController.view;
    CGRect frame = showInView.frame;
    
    [_indicatorView setCenter:CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2)];
    
    [showInView addSubview:_indicatorView];
    [_indicatorView startAnimating];
}

- (void)hidenAlertWaitView{
    [_mIndicatorView hideCustomAlert];
    _mIndicatorView = nil;
}

- (void)hideActivityIndicator{
    if(_indicatorView != nil){
        [_indicatorView stopAnimating];
        [_indicatorView removeFromSuperview];
    }
}

- (void) showAlertWaitViewWithMessage:(NSString *)message onView:(UIView *)view{
    if (_mIndicatorView == nil){
        _mIndicatorView = [[MActivityIndicatorView alloc] init];
        [_mIndicatorView showCustomAlertViewOnView:view withTitle:message withType:CustomAlertTypeWaiting];
    }
}


@end
