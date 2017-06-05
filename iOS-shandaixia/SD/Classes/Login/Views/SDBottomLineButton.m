//
//  SDBottomLineButton.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDBottomLineButton.h"

@interface SDBottomLineButton()

@property (nonatomic, weak) UIImageView *bottomLineImageView;

@end

@implementation SDBottomLineButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = FDRandomColor;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:30 * SCALE];
        
        
        UIImageView *bottomLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_move"]];
        self.bottomLineImageView = bottomLineImageView;
        [self addSubview:bottomLineImageView];
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bottomLineImageView.y = self.height;
    self.bottomLineImageView.centerX = self.width/2;
    
}

- (void)setSelected:(BOOL)selected{

    
    self.bottomLineImageView.hidden = !selected;
    
}

@end









