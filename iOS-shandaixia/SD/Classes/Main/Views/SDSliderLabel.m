//
//  SDSliderLabel.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSliderLabel.h"



@implementation SDSliderLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UILabel *sliderLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:22 * SCALE textAliment:NSTextAlignmentCenter];
        [self addSubview:sliderLabel];
        self.sliderLabel = sliderLabel;

        UIView *iconView = [[UIView alloc] init];
        self.iconView = iconView;
        [self addSubview:iconView];
        iconView.backgroundColor = FDColor(194, 194, 194);
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat iconH = 10 * SCALE;
    CGFloat blank = 4 * SCALE;
    self.iconView.frame = CGRectMake(self.width/2, 0, 1, iconH);
    
    CGFloat labelH = 20 * SCALE;
    CGFloat labelW = self.width;
    self.sliderLabel.frame = CGRectMake(0, iconH + blank, labelW, labelH);
    
}

@end
