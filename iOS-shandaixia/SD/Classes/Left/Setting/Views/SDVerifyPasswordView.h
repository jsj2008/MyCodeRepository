//
//  SDChangePasswordView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/23.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDVerifyPasswordViewDelegate <NSObject>

- (void)verifyViewPasswordSuccess:(NSString *)password;

@end

@interface SDVerifyPasswordView : UIView

//输入框
@property (nonatomic, weak) UITextField *passwordTextField;

@property (nonatomic, weak) id<SDVerifyPasswordViewDelegate> delegate;

- (void)show;


@end
