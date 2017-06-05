//
//  SDLeftDetailButton.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/18.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLeftDetailButton.h"

@interface SDLeftDetailButton ()



//下划线
@property (nonatomic,weak) UIView *bottomView;

@end

@implementation SDLeftDetailButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.backgroundColor = FDRandomColor;
        
        //图标
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_order"]];
        [iconImageView sizeToFit];
        self.iconImageView = iconImageView;
        [self addSubview:iconImageView];
        
        
        //文字
        UILabel *textsLabel = [UILabel labelWithText:@"" textColor:FDColor(34, 34, 34) font:30 * SCALE textAliment:NSTextAlignmentLeft];
        self.textsLabel = textsLabel;
        [self addSubview:textsLabel];
        
        
        //提示
        UILabel *noticeLbel = [UILabel labelWithText:@"" textColor:[UIColor whiteColor] font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.noticeLbel = noticeLbel;
        [self addSubview:noticeLbel];
        noticeLbel.backgroundColor = FDColor(237, 70, 47);
        noticeLbel.hidden = YES;
        
        //下划线
        UIView *bottomView = [[UIView alloc] init];
        self.bottomView = bottomView;
        [self addSubview:bottomView];
        bottomView.backgroundColor = FDColor(231, 231, 231);
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
//    CGFloat leftBlank 
    
    //图标
    CGFloat iconW = self.iconImageView.width;
    CGFloat iconH = self.iconImageView.height;
    CGFloat iconX = 30 * SCALE;
    CGFloat iconY = (self.height - iconH)/2;
    
//    self.iconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImageView.x = iconX;
    self.iconImageView.y = iconY;
    
    //文本
    self.textsLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + iconX, iconY, 200, iconH);
    
    //提示
    self.noticeLbel.centerY = self.textsLabel.centerY;
    self.noticeLbel.width = 28 * SCALE;
    self.noticeLbel.height = self.noticeLbel.width;
    self.noticeLbel.x = self.width - self.noticeLbel.width - iconX;
    

    
    self.noticeLbel.layer.cornerRadius = self.noticeLbel.width/2;
    self.noticeLbel.clipsToBounds = YES;
    
    //下划线
    self.bottomView.frame = CGRectMake(self.textsLabel.x, 49, self.width - self.textsLabel.x - iconX, 1 * SCALE);
    
    
}

@end



