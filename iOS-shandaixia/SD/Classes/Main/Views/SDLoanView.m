//
//  SDLoanView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoanView.h"
#import "SDShouldRefundView.h"
#import "SDReceivedView.h"
#import "SDLoanTimeView.h"

@interface SDLoanView ()

//顶部阴影
@property (nonatomic,weak) UIView *topShadowView;

//数据明细
@property (nonatomic,weak) SDShouldRefundView *shouldRefundView;

//底部阴影
@property (nonatomic,weak) UIView *bottomShadowView;

//用户操作视图
@property (nonatomic,weak) SDReceivedView *receivedView;

//选择天数
@property (nonatomic,weak) SDLoanTimeView *loanTimeView;

@end

@implementation SDLoanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //顶部虚线
        UIView *topShadowView = [[UIView alloc] init];
        self.topShadowView = topShadowView;
        [self addSubview:topShadowView];
        self.topShadowView.backgroundColor = FDColor(243, 245, 249);
        
        //数据明细
        SDShouldRefundView *shouldRefundView = [[SDShouldRefundView alloc] init];
        self.shouldRefundView = shouldRefundView;
        [self addSubview:shouldRefundView];
        
        //顶部虚线
        UIView *bottomShadowView = [[UIView alloc] init];
        self.bottomShadowView = bottomShadowView;
        [self addSubview:bottomShadowView];
        self.bottomShadowView.backgroundColor = FDColor(231, 231, 231);
        
        //用户操作视图
        SDReceivedView *receivedView = [[SDReceivedView alloc] init];
        self.receivedView = receivedView;
        [self addSubview:receivedView];
        
        //选择天数
        SDLoanTimeView *loanTimeView = [[SDLoanTimeView alloc] init];
        self.loanTimeView = loanTimeView;
        [self addSubview:loanTimeView];
        
        //立即借钱
        UIButton *loanButton = [UIButton buttonWithTitle:@"  立即借款" titleColor:[UIColor whiteColor] titleFont:36 * SCALE imageNamed:@"home_borrow-money_icon"];
        
        loanButton.backgroundColor = FDColor(69, 151, 251);
        self.loanButton = loanButton;
        [self addSubview:loanButton];
        
        [loanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [loanButton setBackgroundImage:[UIImage imageWithBgColor:FDColor(170, 170, 170)] forState:UIControlStateDisabled];
        
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //顶部阴影
    CGFloat topHeight = 20 * SCALE;
    
    self.topShadowView.frame = CGRectMake(0, 0, SCREENWIDTH, topHeight);
    
    //数据明细
    CGFloat detailH = 288 * SCALE;
    
    self.shouldRefundView.frame = CGRectMake(0, topHeight, SCREENWIDTH, detailH);
    
    //底部阴影
    self.bottomShadowView.frame = CGRectMake(30 * SCALE, detailH + topHeight + 1, SCREENWIDTH - 60 * SCALE, 1 * SCALE);
    
    //用户操作视图
    CGFloat receivedH = 328 * SCALE;
    
    self.receivedView.frame = CGRectMake(0, self.bottomShadowView.y + self.bottomShadowView.height, SCREENWIDTH, receivedH);
    
    //选择天数
    CGFloat loanTimeY = CGRectGetMaxY(self.receivedView.frame);
    self.loanTimeView.frame = CGRectMake(0, loanTimeY, SCREENWIDTH, self.height - loanTimeY - 100 * SCALE);
    
    CGFloat height = 100 * SCALE;
    
    self.loanButton.frame = CGRectMake(0, self.height - height, SCREENWIDTH, height);
    
}


- (void)setLending:(SDLending *)lending{

    _lending = lending;
    
    
}

@end



