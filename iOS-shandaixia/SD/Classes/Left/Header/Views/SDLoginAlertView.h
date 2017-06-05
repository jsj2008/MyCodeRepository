//
//  SDLoginAlertView.h
//  SD
//
//  Created by 余艾星 on 17/3/21.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDLoginAlertView : UIView

//输入框
@property (nonatomic, weak) UITextField *passwordTextField;
//验证登陆密码
@property (nonatomic, weak) UILabel *verifyPasswordLabel;


//登陆
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UIButton *cancelButton;

//背景图
@property (nonatomic,weak) UIButton *shadowView;

- (void)show;
- (void)remove;

@end
