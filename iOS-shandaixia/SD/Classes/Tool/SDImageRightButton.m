//
//  SDImageRightButton.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDImageRightButton.h"

@implementation SDImageRightButton

- (instancetype)initWithFrame:(CGRect)frame blank:(CGFloat)blank title:(NSString *)title font:(CGFloat)font titleColor:(UIColor *)titleColor imageNamed:(NSString *)imageNamed
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //名字
        UILabel *titles = [UILabel labelWithText:title textColor:titleColor font:font textAliment:2];
        
        self.titles = titles;

        [self addSubview:titles];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        
        [image sizeToFit];
        
        self.image = image;
        
        [self addSubview:image];
        
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    
    CGFloat nameX = 0;
    CGFloat nameW = [@"中国工商银行" sizeOfMaxScreenSizeInFont:30 * SCALE].width + 10;
    CGFloat nameH = 30 * SCALE;
    
    
    self.titles.frame = CGRectMake(nameX, 0, nameW, nameH);
    self.titles.centerY = self.height/2;
    
    self.image.x = nameW + 20 * SCALE;
    
    self.image.centerY = self.titles.centerY;
    
    
}

@end








