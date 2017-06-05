//
//  SDRefundNumberView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/4.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDRefundNumberView.h"



@implementation SDRefundNumberView

#define textFont (SCREENWIDTH>370?14:12)


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

+ (SDRefundNumberView *)numberViewWithNumberFont:(CGFloat)numberFont numberColor:(UIColor *)numberColor desFont:(CGFloat)desFont desColor:(UIColor *)desColor imageNamed:(NSString *)imageNamed{
    
    SDRefundNumberView *numberView = [[SDRefundNumberView alloc] init];
    
    numberView.numberLabel.font = [UIFont systemFontOfSize:numberFont];
    numberView.numberLabel.textColor = numberColor;
    [numberView.descriptionButton setTitleColor:desColor forState:UIControlStateNormal];
    numberView.descriptionButton.titleLabel.font = [UIFont systemFontOfSize:desFont];
    
    if (imageNamed) {
        
        [numberView.descriptionButton setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    }
    
    return numberView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //        self.backgroundColor = [UIColor redColor];
        
        CGFloat font = 24 * SCALE;
        
        //金额
        UILabel *numberLabel = [[UILabel alloc] init];
        self.numberLabel = numberLabel;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLabel];
        numberLabel.textColor = FDColor(34, 34, 34);
        numberLabel.font = [UIFont systemFontOfSize:font];
        
        //解释
        UIButton *descriptionButton = [[UIButton alloc] init];
        self.descriptionButton = descriptionButton;
        [self addSubview:descriptionButton];
        [descriptionButton setTitleColor:FDColor(102, 102, 102) forState:UIControlStateNormal];
        descriptionButton.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.numberLabel.width = self.descriptionButton.width = self.width;
    
    self.numberLabel.x  = 0;
    
    self.numberLabel.height = (self.height - 18 * SCALE)/1.8;
    
    self.descriptionButton.height = self.numberLabel.height;
    
    self.descriptionButton.y = 0;
    
    self.numberLabel.y = self.height - self.numberLabel.height;
    
}

@end




