//
//  SDProveHeaderView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDProveHeaderView.h"

@interface SDProveHeaderView ()



@end

@implementation SDProveHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(70, 151, 251);
        
        
        //进度条
        
        UIImageView *progressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"progress-bar1"]];
        [progressImageView sizeToFit];
        
        self.progressImageView = progressImageView;
        
        [self addSubview:progressImageView];
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat progressY = 168 * SCALE;
    self.progressImageView.y = progressY;
    self.progressImageView.centerX = SCREENWIDTH/2;
    
}

@end






