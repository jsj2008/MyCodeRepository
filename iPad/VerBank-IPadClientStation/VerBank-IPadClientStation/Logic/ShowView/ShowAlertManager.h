//
//  ShowAlertManager.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomAlertView.h"

@interface ShowAlertManager : NSObject

@property (nonatomic, strong) CustomAlertView   *customAlertView;
@property (nonatomic, strong) UIAlertView       *systemAlertView;


+ (id)getInstance;

- (void)showCustomAlertViewWithTitle:(NSString *)title
                          andMessage:(NSString *)message
                            delegate:(id<CustomAlertDelegate>)delegate;

- (void)showConfirmAlertViewWithTitle:(NSString *)title
                           andMessage:(NSString *)message
                             delegate:(id<CustomAlertDelegate>)delegate;

- (void)showSystemAlertViewWithTitle:(NSString *)title
                          andMessage:(NSString *)message
                            delegate:(id)delegate;

- (void)showDisappearanceAlertViewWithTitle:(NSString *)title
                                    Message:(NSString *)message;

//---
- (void)showAlertWaitViewWithMessage:(NSString *)message
                              onView:(UIView *)view;
- (void)hidenAlertWaitView;
@end
