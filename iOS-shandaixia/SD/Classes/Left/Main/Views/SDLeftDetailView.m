//
//  SDLeftDetailView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/18.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLeftDetailView.h"
#import "SDLeftDetailButton.h"
#import "SDImageUpTitleBottomButton.h"
#import "SDUserInfo.h"
#import "SDLeftNavBar.h"

@interface SDLeftDetailView ()

//我的借款
@property (nonatomic, weak) SDLeftDetailButton *myLoanButton;

//我的优惠券
@property (nonatomic, weak) SDLeftDetailButton *myDiscountButton;

//分享好友
@property (nonatomic, weak) SDLeftDetailButton *sharedButton;

//高级认证
@property (nonatomic, weak) SDLeftDetailButton *highProveButton;

//设置
@property (nonatomic, weak) SDImageUpTitleBottomButton *settingButton;

//帮助与反馈
@property (nonatomic, weak) SDImageUpTitleBottomButton *helpAndRespondsButton;



@end

@implementation SDLeftDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //我的借款
        SDLeftDetailButton *myLoanButton = [[SDLeftDetailButton alloc] init];
        self.myLoanButton = myLoanButton;
        [self addSubview:myLoanButton];
        myLoanButton.iconImageView.image = [UIImage imageNamed:@"icon_card"];
        myLoanButton.textsLabel.text = @"我的借款";
        myLoanButton.tag = SDLeftDetailViewButtonTypeMyLoan;
        
        
        //我的优惠券
        SDLeftDetailButton *myDiscountButton = [[SDLeftDetailButton alloc] init];
        self.myDiscountButton = myDiscountButton;
        [self addSubview:myDiscountButton];
        myDiscountButton.iconImageView.image = [UIImage imageNamed:@"icon_order"];
        myDiscountButton.textsLabel.text = @"我的优惠券";
        myDiscountButton.tag = SDLeftDetailViewButtonTypeMyDiscount;
        
        //分享好友
        SDLeftDetailButton *sharedButton = [[SDLeftDetailButton alloc] init];
        self.sharedButton = sharedButton;
        [self addSubview:sharedButton];
        sharedButton.iconImageView.image = [UIImage imageNamed:@"icon_share"];
        sharedButton.textsLabel.text = @"邀请好友";
        sharedButton.tag = SDLeftDetailViewButtonTypeShared;
        
        //高级认证
        SDLeftDetailButton *highProveButton = [[SDLeftDetailButton alloc] init];
        self.highProveButton = highProveButton;
        [self addSubview:highProveButton];
        highProveButton.iconImageView.image = [UIImage imageNamed:@"icon_dh_gjrz"];
        highProveButton.textsLabel.text = @"高级认证";
        highProveButton.tag = SDLeftDetailViewButtonTypeHighProve;
        
        //设置
        SDImageUpTitleBottomButton *settingButton = [[SDImageUpTitleBottomButton alloc] init];
        self.settingButton = settingButton;
        [self addSubview:settingButton];
        [settingButton.iconButton setImage:[UIImage imageNamed:@"-icon_set-up"] forState:UIControlStateNormal];
        settingButton.title.text = @"设置";
        settingButton.tag = SDLeftDetailViewButtonTypeSetting;
        
        //帮助与反馈
        SDImageUpTitleBottomButton *helpAndRespondsButton = [[SDImageUpTitleBottomButton alloc] init];
        self.helpAndRespondsButton = helpAndRespondsButton;
        [self addSubview:helpAndRespondsButton];
        [helpAndRespondsButton.iconButton setImage:[UIImage imageNamed:@"icon_help"] forState:UIControlStateNormal];
        helpAndRespondsButton.title.text = @"帮助与反馈";
        helpAndRespondsButton.tag = SDLeftDetailViewButtonTypeHelpAndResponds;
        
        //统一添加点击事件
        [myLoanButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [myDiscountButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [sharedButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [settingButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [helpAndRespondsButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [highProveButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [SDNotificationCenter addObserver:self selector:@selector(loginSuccess) name:SDLoginSuccessNotification object:nil];
        
        [SDNotificationCenter addObserver:self selector:@selector(logout) name:SDLogoutNotification object:nil];
        
    }
    
    return self;
    
}

- (void)loginSuccess{

    
    
}

- (void)logout{

    self.myDiscountButton.noticeLbel.hidden = YES;
}


//点击左侧细节按钮
- (void)detailButtonDidClicked:(UIButton *)button{

    
    [SDNotificationCenter postNotificationName:SDDetailButtonDidClickedNotification object:nil userInfo:@{SDDetailButtonDidClickedWithTag:@(button.tag)}];
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = 50;
    
    self.myLoanButton.frame = CGRectMake(0, 0, width, height);
    self.myDiscountButton.frame = CGRectMake(0, height, width, height);
    self.sharedButton.frame = CGRectMake(0, 2 * height, width, height);
    self.highProveButton.frame = CGRectMake(0, 3 * height, width, height);
    
    //设置
    CGFloat setH = 84 * SCALE;
    CGFloat setW = self.width/4;
    CGFloat setY = self.height - setH - 30 * SCALE;
    CGFloat setX = setW/2;
    
    self.settingButton.frame = CGRectMake(setX, setY, setW, setH);
    
    //帮助与反馈
    self.helpAndRespondsButton.frame = CGRectMake(setX * 4.7, setY, setW, setH);
    
    
    
    
    
    
}

- (void)setLeftNavBar:(SDLeftNavBar *)leftNavBar{

    _leftNavBar = leftNavBar;
    
    
    if ([leftNavBar.discountSum isEqual:@(0)]) {
        
        self.myDiscountButton.noticeLbel.hidden = YES;
    }else{
        
        self.myDiscountButton.noticeLbel.hidden = NO;
        
        self.myDiscountButton.noticeLbel.text = [NSString stringWithFormat:@"%@",leftNavBar.discountSum];
        
    }
    
}

@end











