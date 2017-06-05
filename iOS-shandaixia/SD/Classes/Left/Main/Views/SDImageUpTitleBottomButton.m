//
//  FDOrderDetailView.m
//  FuDai
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import "SDImageUpTitleBottomButton.h"

@implementation SDImageUpTitleBottomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //图片
        UIButton *iconButton = [[UIButton alloc] init];
        self.iconButton = iconButton;
        [self addSubview:iconButton];
        iconButton.userInteractionEnabled = NO;
        
        //标题
        UILabel *titleLabel = [UILabel labelWithText:@"" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.title = titleLabel;
        [self addSubview:titleLabel];
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //图片
    CGFloat iconW = 42 * SCALE;
    CGFloat iconH = 42 * SCALE;
    CGFloat iconX = self.width/2 - iconW/2;
    CGFloat iconY = 0;
    
    self.iconButton.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //标题
    CGFloat titleW = self.width;
    CGFloat titleH = self.height * 0.25;
    CGFloat titleX = 0;
    CGFloat titleY = self.height - titleH;
    
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //    self.titleLabel.text = @"手机";
    
}

@end
