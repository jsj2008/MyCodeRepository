//
//  SDRefundNumberView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/4.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRefundNumberView : UIView

//金额
@property (nonatomic,weak) UILabel *numberLabel;

//解释
@property (nonatomic,weak) UIButton *descriptionButton;


+ (SDRefundNumberView *)numberViewWithNumberFont:(CGFloat)numberFont numberColor:(UIColor *)numberColor desFont:(CGFloat)desFont desColor:(UIColor *)desColor imageNamed:(NSString *)imageNamed;

@end
