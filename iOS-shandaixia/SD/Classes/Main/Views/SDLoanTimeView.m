//
//  SDLoanTimeView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/18.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoanTimeView.h"

@interface SDLoanTimeView ()

//借款时间文本
@property (nonatomic,weak) UIButton *loanTimeButton;

//7天
@property (nonatomic,weak) UIButton *sevenDayButton;

//14天
@property (nonatomic,weak) UIButton *fourteenDayButton;

@end

@implementation SDLoanTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //借款时间文本
        UIButton *loanTimeButton = [UIButton buttonWithTitle:@" 借款时间" titleColor:FDColor(34,34,34) titleFont:28 * SCALE imageNamed:@"icon_clock"];
        loanTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.loanTimeButton = loanTimeButton;
        [self addSubview:loanTimeButton];
        
        //7天
        UIButton *sevenDayButton = [UIButton buttonWithTitle:@"7天" titleColor:FDColor(153, 153, 153) titleFont:28 * SCALE backImageNamed:nil];
        [sevenDayButton setTitleColor:FDColor(153, 108, 0) forState:UIControlStateSelected];
        self.sevenDayButton = sevenDayButton;
        [self addSubview:sevenDayButton];
        
//        sevenDayButton.backgroundColor = FDColor(245, 245, 245);
        [sevenDayButton setBackgroundImage:[UIImage imageWithBgColor:FDColor(245, 245, 245)] forState:UIControlStateNormal];
        [sevenDayButton setBackgroundImage:[UIImage imageWithBgColor:FDColor(252, 214, 51)] forState:UIControlStateSelected];
        
        //14天
        UIButton *fourteenDayButton = [UIButton buttonWithTitle:@"14天" titleColor:FDColor(153, 153, 153) titleFont:28 * SCALE backImageNamed:nil];
        [fourteenDayButton setTitleColor:FDColor(153, 108, 0) forState:UIControlStateSelected];
        
        self.fourteenDayButton = fourteenDayButton;
        [self addSubview:fourteenDayButton];
        
        fourteenDayButton.selected = YES;
        
//        fourteenDayButton.backgroundColor = FDColor(152, 214, 51);
        [fourteenDayButton setBackgroundImage:[UIImage imageWithBgColor:FDColor(245, 245, 245)] forState:UIControlStateNormal];
        [fourteenDayButton setBackgroundImage:[UIImage imageWithBgColor:FDColor(252, 214, 51)] forState:UIControlStateSelected];
        
        
        
        
        //监听点击的天数
        [sevenDayButton addTarget:self action:@selector(dayButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [fourteenDayButton addTarget:self action:@selector(dayButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//天数被点击
- (void)dayButtonDidClicked:(UIButton *)button{

    self.sevenDayButton.selected = self.fourteenDayButton.selected = NO;
    
    button.selected = YES;
    
    NSInteger day = 0;
    
    if ([button.titleLabel.text containsString:@"7"]) {
        
        day = 7;
    }else{
    
        day = 14;
    }
    
    [SDNotificationCenter postNotificationName:SDChoosenDayNotification object:nil userInfo:@{SDChoosenDay:@(day)}];
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat leftBlank = 30 * SCALE;
    
    //借款时间文本
    CGFloat timeH = 40 * SCALE;
    self.loanTimeButton.frame = CGRectMake(leftBlank, 0, 200, timeH);
    
    //七天
    CGFloat sevenH = 70 * SCALE;
    CGFloat sevenW = 200 * SCALE;
    CGFloat sevenX = 110 * SCALE;
    CGFloat sevenY = 76 * SCALE;
    self.sevenDayButton.frame = CGRectMake(sevenX, sevenY, sevenW, sevenH);
    
    //14天
    self.fourteenDayButton.frame = CGRectMake(SCREENWIDTH - sevenX - sevenW, sevenY, sevenW, sevenH);
    
    self.sevenDayButton.layer.cornerRadius = self.fourteenDayButton.layer.cornerRadius = sevenH/2;
    
    self.sevenDayButton.clipsToBounds = self.fourteenDayButton.clipsToBounds = YES;
    
}

@end






