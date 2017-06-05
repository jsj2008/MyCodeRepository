//
//  FDAlertView.m
//  FuDai
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import "FDAlertView.h"

#define FONT (SCREENWIDTH>370?15:13)

@interface FDAlertView ()

//背景图
@property (nonatomic,weak) UIButton *shadowView;

//虚线
@property (nonatomic,weak) UIView *lineView;

@end

@implementation FDAlertView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 440 * SCALE, (156 + 86) * SCALE);
        
        self.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 16*SCALE;
        self.clipsToBounds = YES;
        
        //标题
        UILabel *titleLabel = [UILabel labelWithText:@"" textColor:FDColor(51, 51, 51) font:FONT textAliment:NSTextAlignmentCenter];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        titleLabel.numberOfLines = 0;
        
        //左边按钮
        UIButton *leftButton = [UIButton buttonWithTitle:@"" titleColor:[UIColor whiteColor] titleFont:FONT];
        self.leftButton = leftButton;
        [self addSubview:leftButton];
        leftButton.backgroundColor = FDColor(70, 151, 251);
        
        //右边按钮
        UIButton *rightButton = [UIButton buttonWithTitle:@"" titleColor:[UIColor clearColor] titleFont:FONT];
        self.rightButton = rightButton;
        [self addSubview:rightButton];
        [rightButton setTitleColor:FDColor(51, 51, 51) forState:UIControlStateNormal];
        
        //虚线
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        self.lineView = lineView;
        lineView.backgroundColor = FDColor(240, 240, 240);
        
        self.titleLabel.frame = CGRectMake(self.width * 0.1, 0, self.width * 0.8, self.height * 2/3);
        self.lineView.frame = CGRectMake(0, self.height * 2/3, self.width, 1);
        
        self.leftButton.frame = CGRectMake(0, self.height * 2/3, self.width/2, self.height/3);
        self.rightButton.frame = CGRectMake(self.width/2, self.height * 2/3, self.width/2, self.height/3);
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    
}

- (void)show{

    //背景图
    UIButton *shadowView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    
    
    
    
    shadowView.backgroundColor = [UIColor blackColor];
    
    shadowView.alpha = 0.7;
    
    self.shadowView = shadowView;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowView];
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)dismiss{

    [self.shadowView removeFromSuperview];
    
    [self removeFromSuperview];
}

@end
