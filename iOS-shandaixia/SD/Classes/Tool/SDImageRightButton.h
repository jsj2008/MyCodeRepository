//
//  SDImageRightButton.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDImageRightButton : UIButton

@property (nonatomic, weak) UILabel *titles;

@property (nonatomic, weak) UIImageView *image;

- (instancetype)initWithFrame:(CGRect)frame blank:(CGFloat)blank title:(NSString *)title font:(CGFloat)font titleColor:(UIColor *)titleColor imageNamed:(NSString *)imageNamed;

@end













