//
//  SDNumberView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDNumberView : UIView

//金额
@property (nonatomic,weak) UILabel *numberLabel;

//解释
@property (nonatomic,weak) UIButton *descriptionButton;


+ (SDNumberView *)numberViewWithNumberFont:(CGFloat)numberFont numberColor:(UIColor *)numberColor desFont:(CGFloat)desFont desColor:(UIColor *)desColor;

@end
