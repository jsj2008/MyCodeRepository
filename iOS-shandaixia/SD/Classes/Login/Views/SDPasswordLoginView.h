//
//  SDPasswordLoginView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPasswordLoginView : UIView

//账号
@property (nonatomic, weak) UITextField *accountTextField;

//显示密码
@property (nonatomic, weak) UIButton *showPasswordButton;

//发送验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

//垂直的虚线
@property (nonatomic, weak) UIImageView *verticalImageView;

//密码
@property (nonatomic, weak) UITextField *passwordTextField;

@end
