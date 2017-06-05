//
//  SDLeftHeaderView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/18.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLeftHeaderView.h"
#import "SDNumberView.h"
#import "SDUserInfo.h"
#import "SDLeftDetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDLeftNavBar.h"

@interface SDLeftHeaderView ()

//背景
@property (nonatomic,weak) UIImageView *backImageView;

@property (nonatomic,weak) UIImageView *iconImageView;

//借款总额
@property (nonatomic,weak) SDNumberView *loanNumberView;

//虚线
@property (nonatomic,weak) UIView *lineView;

//急救次数
@property (nonatomic,weak) SDNumberView *rescueNumberView;

//登录按钮
@property (nonatomic, weak) UIButton *loginButton;

//头像
@property (nonatomic,weak) UIButton *iconButton;

@end

@implementation SDLeftHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        self.backImageView = backImageView;
        [self addSubview:backImageView];
        backImageView.userInteractionEnabled = YES;
        
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_bg"]];
        self.iconImageView = iconImageView;
        [self addSubview:iconImageView];
        iconImageView.userInteractionEnabled = YES;
        [iconImageView sizeToFit];
        
        //头像
        UIButton *iconButton = [[UIButton alloc] init];
        self.iconButton = iconButton;
        [self addSubview:iconButton];
        [iconButton setImage:[UIImage imageNamed:@"small_head-0"] forState:UIControlStateNormal];
        iconButton.tag = SDLeftDetailViewButtonTypeHeader;
        
        SDUserInfo *userInfo = [SDUserInfo getUserInfo];
        
        
        if (userInfo.ID.length && userInfo.image) {
            
            [self.iconButton setImage:userInfo.image forState:UIControlStateNormal];
            

        }

        
        
        [iconButton addTarget:self action:@selector(iconButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //借款总额
        SDNumberView *loanNumberView = [[SDNumberView alloc] init];
        self.loanNumberView = loanNumberView;
        [self addSubview:loanNumberView];
        
        //虚线
        UIView *lineView  = [[UIView alloc] init];
        self.lineView = lineView;
        [self addSubview:lineView];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.alpha = 0.3;
        
        //急救次数
        SDNumberView *rescueNumberView = [[SDNumberView alloc] init];
        self.rescueNumberView = rescueNumberView;
        [self addSubview:rescueNumberView];
        
        loanNumberView.numberLabel.textColor = rescueNumberView.numberLabel.textColor = [UIColor whiteColor];
        
        loanNumberView.descriptionButton.titleLabel.font = rescueNumberView.descriptionButton.titleLabel.font = loanNumberView.numberLabel.font = rescueNumberView.numberLabel.font = [UIFont systemFontOfSize:24 * SCALE];
        
        [self.rescueNumberView.descriptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loanNumberView.descriptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        

        
        
        
        
        UIButton *personalCenterButton = [UIButton buttonWithImage:@"btn_personal-center" backImageNamed:nil];
        [self addSubview:personalCenterButton];
        self.personalCenterButton = personalCenterButton;
        [personalCenterButton sizeToFit];
        
        personalCenterButton.tag = SDLeftDetailViewButtonTypeHeader;
        
        [personalCenterButton addTarget:self action:@selector(iconButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *loginButton = [UIButton buttonWithImage:@"btn_login" backImageNamed:nil];
        [self addSubview:loginButton];
        self.loginButton = loginButton;
        [loginButton sizeToFit];
        [loginButton addTarget:self action:@selector(iconButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [SDNotificationCenter addObserver:self selector:@selector(logout) name:SDLogoutNotification object:nil];
        
        [SDNotificationCenter addObserver:self selector:@selector(loginSuccess) name:SDLoginSuccessNotification object:nil];
        
        [SDNotificationCenter addObserver:self selector:@selector(headerChanged) name:SDHeadImageChangedNotification object:nil];
        
        self.loginButton.hidden = NO;
        self.personalCenterButton.hidden = self.loanNumberView.hidden = self.lineView.hidden = self.rescueNumberView.hidden = YES;
        
        if (userInfo.ID.length) {
            
            [self loginSuccess];
        }
    }
    return self;
}

- (void)iconButtonDidClicked:(UIButton *)button{

    [SDNotificationCenter postNotificationName:SDDetailButtonDidClickedNotification object:nil userInfo:@{SDDetailButtonDidClickedWithTag:@(button.tag)}];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //背景
    self.backImageView.frame = self.bounds;
    
    //图标
    CGFloat iconW = 88 * SCALE;
    CGFloat iconH = 88 * SCALE;
    CGFloat iconX = 30 * SCALE;
    CGFloat iconY = 174 * SCALE;
    
    
    self.iconButton.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.iconButton.width = self.iconImageView.width - 12 * SCALE;
    self.iconButton.height = self.iconImageView.height - 12 * SCALE;
    
    self.iconImageView.center = self.iconButton.center;
    
    self.iconButton.layer.cornerRadius = self.iconButton.height/2;
    self.iconButton.clipsToBounds = YES;
    
    //借款总额
    self.loanNumberView.y = iconY + 6 * SCALE;
    self.loanNumberView.height = 76 * SCALE;
    self.loanNumberView.width = 150 * SCALE;
    self.loanNumberView.x = 172 * SCALE;
    
//    self.loanNumberView.backgroundColor = FDRandomColor;
    
    //虚线
    CGFloat lineW = 1 * SCALE;
    CGFloat lineH = 40 * SCALE;
    CGFloat lineX = 50 * SCALE + CGRectGetMaxX(self.loanNumberView.frame);
    CGFloat lineY = 198 * SCALE;
    
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    //急救次数
    self.rescueNumberView.frame = self.loanNumberView.frame;
    self.rescueNumberView.x = self.lineView.x + 48 * SCALE;
    
    [self.loanNumberView.descriptionButton setTitle:@"借款总额(元)" forState:UIControlStateNormal];
    
    [self.rescueNumberView.descriptionButton setTitle:@"救急次数" forState:UIControlStateNormal];
    
    self.personalCenterButton.x = self.width - 40 * SCALE - self.personalCenterButton.width;
    self.personalCenterButton.y = self.height - 18 * SCALE - self.personalCenterButton.height;
    
    self.loginButton.centerY = self.iconButton.centerY;
    
    self.loginButton.x = CGRectGetMaxX(self.iconImageView.frame) + 40 * SCALE;
    
}

- (void)loginSuccess{
    
    self.loginButton.hidden = YES;
    self.personalCenterButton.hidden = self.loanNumberView.hidden = self.lineView.hidden = self.rescueNumberView.hidden = NO;
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];

    if (user.headUrl.length > 0 && user.ID) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:user.headUrl]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.iconButton setImage:imageView.image forState:UIControlStateNormal];
        });
        
    }
    
    
    
    
    
    
    
}

- (void)logout{
    
    self.loginButton.hidden = NO;
    self.personalCenterButton.hidden = self.loanNumberView.hidden = self.lineView.hidden = self.rescueNumberView.hidden = YES;

    [_iconButton setImage:[UIImage imageNamed:@"small_head-0"] forState:UIControlStateNormal];
    
    
}

- (void)headerChanged{
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    [self.iconButton setImage:userInfo.image forState:UIControlStateNormal];
    
    
}


- (void)setLeftNavBar:(SDLeftNavBar *)leftNavBar{
    
    _leftNavBar = leftNavBar;
    
    
    
    NSString *borrowingAmountSum;
    if (leftNavBar.borrowingAmountSum) {
        
        borrowingAmountSum = [NSString stringWithFormat:@"%@",leftNavBar.borrowingAmountSum];
    }else{
        
        borrowingAmountSum = @"0";
    }
    
    self.loanNumberView.numberLabel.text = borrowingAmountSum;
    
    NSString *passSum;
    if (leftNavBar.passSum) {
        
        passSum = [NSString stringWithFormat:@"%@",leftNavBar.passSum];
    }else{
        
        passSum = @"0";
    }
    
    self.rescueNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",leftNavBar.passSum];
}

@end












