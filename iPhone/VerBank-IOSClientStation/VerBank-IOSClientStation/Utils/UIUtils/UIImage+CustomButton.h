//
//  UIImage+CustomButton.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomButton)
+ (UIImage *)SEGButtonSelectedColor:(UIColor *)buttonColor
                               size:(CGSize)size
                        shadowWidth:(CGFloat)shadowWidth
                        shadowColor:(UIColor *)shadowColor
                       cornerRadius:(CGFloat)cornerRadius
                           selected:(Boolean)selected
                         cornerType:(NSInteger)cornerType;

+ (UIImage *) SEGImageWithColor: (UIColor *) color
                           size: (CGSize) size
                   cornerRadius: (CGFloat) cornerRadius
                     cornerType: (NSInteger)cornerType
;
@end
