//
//  ZLKeyboardTool.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/30.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLKeyboardTool : NSObject

#pragma mark - 添加基础按钮
+ (void)setupBasicButtonsWithTitle:(NSString *)title
                             image:(UIImage *)image
                         highImage:(UIImage *)highImage
                        titleColor:(UIColor *)color
                            button:(UIButton *)button;

@end
