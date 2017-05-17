//
//  ShowAlertManager.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ShowAlertManager.h"
#import "IosLogic.h"
#import "LangCaptain.h"
#import "MActivityIndicatorView.h"

static ShowAlertManager *alertManger = nil;

@interface ShowAlertManager()<CustomAlertDelegate> {
    UIWindow *_mWindow;
}

@property (nonatomic, strong) UIAlertView               *disappearanceAlertView;
@property (nonatomic, strong) MActivityIndicatorView    *mIndicatorView;

@end

@implementation ShowAlertManager

@synthesize customAlertView;
@synthesize systemAlertView;
@synthesize disappearanceAlertView;
@synthesize mIndicatorView;

+ (id)getInstance {
    if (alertManger == nil) {
        alertManger = [[ShowAlertManager alloc] init];
    }
    return alertManger;
}

- (id)init {
    if (self = [super init]) {
        // uiwindow 未用到
        _mWindow = [[IosLogic getInstance] uiWindow];
    }
    return self;
}

// ------ customAlertView ------
- (void)showCustomAlertViewWithTitle:(NSString *)title
                          andMessage:(NSString *)message
                            delegate:(id<CustomAlertDelegate>)delegate {
    if(self.customAlertView != nil){
        [self.customAlertView setDelegate:nil];
        [self.customAlertView dismiss];
    }
    
    self.customAlertView = [[CustomAlertView alloc] initWithTitle:title
                                                   contentMessage:message
                                                     cancelButton:[[LangCaptain getInstance] getLangByCode:@"Cancel"]
                                                         okButton:[[LangCaptain getInstance] getLangByCode:@"YES"]];
    [self.customAlertView setDelegate:delegate];
    [self.customAlertView show];
}

// ------ customAlertView ------
- (void)showConfirmAlertViewWithTitle:(NSString *)title
                           andMessage:(NSString *)message
                             delegate:(id<CustomAlertDelegate>)delegate {
    if(self.customAlertView != nil){
        [self.customAlertView setDelegate:nil];
        [self.customAlertView dismiss];
    }
    
    if ([message containsString:@"AppStore"]) {
        self.customAlertView = [[CustomAlertView alloc] initWithTitle:title
                                                       contentMessage:message
                                                         cancelButton:[[LangCaptain getInstance] getLangByCode:@"Update"]
                                                             okButton:nil];
        [self.customAlertView setDelegate:self];
    } else {
        self.customAlertView = [[CustomAlertView alloc] initWithTitle:title
                                                       contentMessage:message
                                                         cancelButton:[[LangCaptain getInstance] getLangByCode:@"YES"]
                                                             okButton:nil];
        [self.customAlertView setDelegate:delegate];
    }
    [self.customAlertView show];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [self callAppStoreURL];
//    [alertView setDelegate:nil];
//}

- (void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index {
    [self callAppStoreURL];
    [alertView setDelegate:nil];
}

- (void)callAppStoreURL {
    NSURL *appStoreURL = [NSURL URLWithString: [[LangCaptain getInstance] getLangByCode:@"AppStoreUrl"]];
    //    Boolean isOpen = [[UIApplication sharedApplication] openURL:myURL];
    [[UIApplication sharedApplication] openURL:appStoreURL];
}

// ------ systemAlertView ------
- (void)showSystemAlertViewWithTitle:(NSString *)title
                          andMessage:(NSString *)message
                            delegate:(id)delegate {
    if (self.systemAlertView != nil) {
        [self.systemAlertView setDelegate:nil];
        [self.systemAlertView dismissWithClickedButtonIndex:self.systemAlertView.cancelButtonIndex animated:NO];
    }
    
    self.systemAlertView = [[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:delegate
                                            cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                                            otherButtonTitles:nil];
    [self.systemAlertView show];
}

// ------ disappearanceAlertView ------
- (void)showDisappearanceAlertViewWithTitle:(NSString *)title
                                    Message:(NSString *)message {
    if (self.disappearanceAlertView != nil) {
        return;
    }
    
    self.disappearanceAlertView = [[UIAlertView alloc]initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:nil, nil];
    [self.disappearanceAlertView show];
    
    [self performSelector:@selector(dimissAlert:)
               withObject:self.disappearanceAlertView
               afterDelay:0.5f];
}

- (void) dimissAlert:(UIAlertView *)alert {
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex]
                                animated:YES];
}

// ------ waitView ------
- (void) showAlertWaitViewWithMessage:(NSString *)message
                               onView:(UIView *)view {
    if (self.mIndicatorView == nil){
        self.mIndicatorView = [[MActivityIndicatorView alloc] init];
        [self.mIndicatorView showCustomAlertViewOnView:view withTitle:message withType:CustomAlertTypeWaiting];
    }
}

- (void)hidenAlertWaitView{
    [self.mIndicatorView hideCustomAlert];
    self.mIndicatorView = nil;
}

@end
