//
//  ShowAlert.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAlert : NSObject

+ (id)getInstance;

@property (nonatomic, strong)UIAlertView *alertView;
@property (nonatomic, strong)UIAlertView *chooseableAlertView;
@property (nonatomic, strong) UIAlertView *jumpAlertView;

- (void)    showAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message;
- (void)    showChooseableAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message delegate:(id)delegate;

- (void)    showActivityIndicator;
- (void)    hideActivityIndicator;
- (void)    showAlertWaitViewWithMessage:(NSString *)message onView:(UIView *)view;
- (void)    showDisMissAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message;
- (void)    hidenAlertWaitView;

- (void)    showJumpAlertView:(NSString *)title andMessage:(NSString *)message delegate:(id)delegate;

@end
