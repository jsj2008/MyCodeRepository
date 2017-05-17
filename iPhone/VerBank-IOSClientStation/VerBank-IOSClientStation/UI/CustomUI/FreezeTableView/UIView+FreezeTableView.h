//
//  UIView+FreezeTableView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FreezeTableView)

- (void)addBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;
- (void)addTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;
- (void)addHeaderBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;

- (UIView *)addVerticalLineWithWidth:(CGFloat)width bgColor:(UIColor *)color atX:(CGFloat)x;
- (void)addHeaderTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;
@end
