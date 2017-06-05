//
//  SDRefundSuccessView.m
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDWaitRefundView.h"

@interface SDWaitRefundView ()

@property (nonatomic, weak) UIImageView *headerImageView;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *dealLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *bankCardLabel;

@property (nonatomic, weak) UILabel *successLabel;
@property (nonatomic, weak) UILabel *successTimeLabel;
@property (nonatomic, weak) UILabel *delayLabel;

@property (nonatomic,weak) UIView *backView;

@property (nonatomic, weak) UIImageView *leftImageView;

@end


@implementation SDWaitRefundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = SDWhiteColor;
        
        //顶部虚线
        UIView *backView = [[UIView alloc] init];
        self.backView = backView;
        [self addSubview:backView];
        backView.backgroundColor = FDColor(243, 245, 249);
        
        UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refund_wait_back"]];
        [headerImageView sizeToFit];
        [self addSubview:headerImageView];
        
        self.headerImageView = headerImageView;
        
        UILabel *headerLabel = [UILabel labelWithText:@"还款结果确认中" textColor:SDBlackColor font:30 * SCALE textAliment:1];
        [self addSubview:headerLabel];
        self.headerLabel = headerLabel;
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small-progress-bar"]];
        
        self.leftImageView = leftImageView;
        
        [self addSubview:leftImageView];
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //顶部阴影
    CGFloat topHeight = 20 * SCALE;
    
    self.backView.frame = CGRectMake(0, 0, SCREENWIDTH, topHeight);
    
    
    self.headerImageView.y = 44 * SCALE + topHeight;
    self.headerImageView.centerX = self.width/2;
    
    CGFloat headerY = CGRectGetMaxY(self.headerImageView.frame) + 40 * SCALE;
    CGFloat headerH = 30 * SCALE;
    self.headerLabel.frame = CGRectMake(0, headerY, self.width, headerH);
    
    self.leftImageView.x = 144 * SCALE;
    self.leftImageView.y = headerY + 100 * SCALE;
    
}


@end
