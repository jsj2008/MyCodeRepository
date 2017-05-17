//
//  ZLKeyboardTool.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/30.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ZLKeyboardTool.h"

@implementation ZLKeyboardTool

#pragma mark - 添加基础按钮
+ (void)setupBasicButtonsWithTitle:(NSString *)title
                             image:(UIImage *)image
                         highImage:(UIImage *)highImage
                        titleColor:(UIColor *)color
                            button:(UIButton *)button {
    
    if ([title length] > 1) {
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
    } else {
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:16.0f];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
}

@end
