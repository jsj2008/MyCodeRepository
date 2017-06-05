//
//  SDGestureLoginController.m
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDGestureLoginController.h"
#import "HMView.h"
#import "SDLendingAlertView.h"
#import "SDUserInfo.h"
#import "SDLoginButton.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDGestureLoginController ()<HMViewDelegate,SDLendingAlertViewDelegate>

@property (nonatomic, weak) UILabel *noticeLabel;

@property (nonatomic, copy) NSString *gesturePassword;

@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, assign) CGFloat wrongCount;

@end

@implementation SDGestureLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = SDWhiteColor;
    self.wrongCount = 0;
    
    [self addUI];
    
}


- (void)addUI{
        
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    
    [iconImageView sizeToFit];
    iconImageView.y = 176 * SCALE;
    iconImageView.centerX = SCREENWIDTH/2;
    iconImageView.layer.cornerRadius = iconImageView.width/2;
    iconImageView.clipsToBounds = YES;
    
    if ([SDUserInfo getUserInfo].headUrl.length) {
        
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:[SDUserInfo getUserInfo].headUrl]];
        
    }
    
    [self.view addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    NSMutableString *phone = [NSMutableString stringWithFormat:@"%@",[FDUserDefaults objectForKey:FDUserAccount]];
    
    [phone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    UILabel *noticeLabel = [UILabel labelWithText:[NSString stringWithFormat:@"欢迎您, %@",phone] textColor:FDColor(34, 34, 34) font:28 * SCALE textAliment:1];
    self.noticeLabel = noticeLabel;
    [self.view addSubview:noticeLabel];
    
    noticeLabel.frame = CGRectMake(0, CGRectGetMaxY(iconImageView.frame) + 26 * SCALE, SCREENWIDTH, 28 * SCALE);
    
    
    HMView *gestureView = [[HMView alloc] initWithFrame:CGRectMake(0, 400 * SCALE, SCREENWIDTH, SCREENWIDTH)];
    gestureView.delegate = self;
    
    
    [self.view addSubview:gestureView];
    
    //其他账号登录
    CGFloat width = [@"其他账号登录" sizeOfMaxScreenSizeInFont:30 * SCALE].width;
    
    UIButton *newLoginButton = [UIButton buttonWithTitle:@"其他账号登录" titleColor:FDColor(153,153,153) titleFont:30 * SCALE];
    newLoginButton.tag = 0;
    newLoginButton.frame = CGRectMake(86 * SCALE, CGRectGetMaxY(gestureView.frame), width, 40 * SCALE);
    
    [self.view addSubview:newLoginButton];
    
    //忘记手势密码
    UIButton *forgotGestureButton = [UIButton buttonWithTitle:@"忘记手势密码" titleColor:FDColor(153,153,153) titleFont:30 * SCALE];
    forgotGestureButton.tag = 1;
    forgotGestureButton.frame = newLoginButton.frame;
    forgotGestureButton.x = SCREENWIDTH - 86 * SCALE - width;
    
    [newLoginButton addTarget:self action:@selector(loginButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [forgotGestureButton addTarget:self action:@selector(loginButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:forgotGestureButton];
}

- (void)loginButtonDidClicked:(UIButton *)button{

    [self clearData];
    
    if ([self.delegate respondsToSelector:@selector(gestureLoginButtonDidClicked:)]) {
        
        [self.delegate gestureLoginButtonDidClicked:button.tag];
    }
    
    
}

- (void)viewTranslateDataWithView:(HMView * )view  andString:(NSString *)pwd{
    
    FDLog(@"pwd - %@",pwd);
    
    NSString *gesture = [FDUserDefaults objectForKey:SDGusturePassword];
    
    if ([gesture isEqualToString:pwd]) {
        
//        [FDReminderView showWithString:@"登录成功"];
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"登录成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
        if ([self.delegate respondsToSelector:@selector(gestureLoginButtonDidClicked:)]) {
            
            [self.delegate gestureLoginButtonDidClicked:2];
        }
    }else{
    
        [FDReminderView showWithString:@"手势密码错误"];
        
        self.wrongCount += 1;
    }
    
    
    if (self.wrongCount == 5) {
        
        SDLendingAlertView *alert = [SDLendingAlertView sharedLendingAlertView];
        
        alert.delegate = self;
        
        [SDLendingAlertView show];
        
        alert.titleLabel.text = @"提示";
        alert.contentLabel.text = @"您已经5次输错密码, 手势密码已关闭, 请重新登录";
        [alert.knowButton setTitle:@"重新登录" forState:UIControlStateNormal];
        [self clearData];
        
        
    }
}

- (void)clearData{

    [FDUserDefaults setObject:@"0" forKey:SDOpenGusturePassword];
    [FDUserDefaults setObject:nil forKey:SDGusturePassword];
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    userInfo.ID = nil;
    
    [userInfo saveUserInfo];
    
    [SDNotificationCenter postNotificationName:SDLogoutNotification object:nil];
}

- (void)lendingAlertViewKnowButtonDidClicked:(SDLending *)lending{

    if ([self.delegate respondsToSelector:@selector(gestureLoginButtonDidClicked:)]) {
        
        [self.delegate gestureLoginButtonDidClicked:1];
    }
}

@end
