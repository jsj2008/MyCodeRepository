//
//  UIView+AddLine.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/1.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat addLineTopHeight;
extern const CGFloat addLineBottomHeight;

@interface UIView (AddLine)

- (void)addBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;
- (void)addTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;

- (void)addHeaderBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;
- (void)addHeaderTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color;

//- (UIView *)addVerticalLineWithWidth:(CGFloat)width bgColor:(UIColor *)color atX:(CGFloat)x;


@end
