//
//  UIFormat.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

@interface UIFormat : NSObject

+ (void)setCorner:(NSUInteger)cornerType WithUIView:(UIView *)view;

+ (void)setCorner:(NSUInteger)cornerType WithUIView:(UIView *)view withCorner:(float)corner;

//+ (void)setComplexBlueButtonColor:(UIButton *)button;
//+ (void)setComplexGrayButtonColor:(UIButton *)button;
//+ (void)setComplexRedButtonColor:(UIButton *)button;
//+ (void)setComplexGrayViewColor:(UIImageView *)view;
//+ (void)setComplexClearViewColor:(UIImageView *)view;

+(void)setViewStyle:(UIView *)mView
withBackgroundColor:(UIColor *)backgroundColor
 andTextNormalColor:(UIColor *)normalColor
   andTextHighColor:(UIColor *)highColor
        andTextFont:(UIFont *)textFont
          andCorner:(NSInteger)cornerValue;

//+ (UIImage*) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType atView:(UIView *)view;
//+ (void)initButtonStyle:(UIButton *)btn;

+ (UIImage *)getComplexGrayImageView;

@end
