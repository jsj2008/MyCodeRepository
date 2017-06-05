//
//  SDIDCardHeaderView.m
//  SD
//
//  Created by 余艾星 on 17/3/1.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDIDCardHeaderView.h"

@implementation SDIDCardHeaderView

- (instancetype)initWithFrame:(CGRect)frame imageNamed:(NSString *)named
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(70, 151, 251);
        
        
        //进度条
        
        UIImageView *progressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
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
