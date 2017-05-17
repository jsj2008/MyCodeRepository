//
//  UIImage+CustomButton.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UIImage+CustomButton.h"

@implementation UIImage (CustomButton)

+ (UIImage *)SEGButtonSelectedColor:(UIColor *)buttonColor
                               size:(CGSize)size
                        shadowWidth:(CGFloat)shadowWidth
                        shadowColor:(UIColor *)shadowColor
                       cornerRadius:(CGFloat)cornerRadius
                           selected:(Boolean)selected
                         cornerType:(NSInteger)cornerType{
    UIImage *buttonImage;
    
    CGSize smallSize = CGSizeMake(size.width - shadowWidth * 2, size.height - shadowWidth * 2);
    
    UIImage *frontImage = nil;
    
    if (selected) {
        frontImage = [self SEGImageWithColor:shadowColor size:smallSize cornerRadius:cornerRadius cornerType:cornerType];
    } else {
        frontImage = [self SEGImageWithColor:buttonColor size:smallSize cornerRadius:cornerRadius cornerType:cornerType];
    }
    
    UIImage *backImage = [self SEGImageWithColor:shadowColor size:size cornerRadius:cornerRadius cornerType:cornerType];
    
    CGRect rect = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [backImage drawAtPoint:CGPointMake(0, 0)];
    [frontImage drawAtPoint:CGPointMake(shadowWidth, shadowWidth)];
    buttonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return buttonImage;
}


+ (UIImage *) SEGImageWithColor: (UIColor *) color
                           size: (CGSize) size
                   cornerRadius: (CGFloat) cornerRadius
                     cornerType: (NSInteger)cornerType
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0);
    
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                           byRoundingCorners:cornerType
                                 cornerRadii:CGSizeMake(cornerRadius, cornerRadius)] addClip];
    
    [image drawInRect:imageView.bounds];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageView.image;
}

@end
