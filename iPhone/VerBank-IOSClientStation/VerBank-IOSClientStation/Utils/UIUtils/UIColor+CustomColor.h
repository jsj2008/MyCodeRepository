//
//  UIColor+CustomColor.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)

+ (UIColor *)backgroundColor;
+ (UIColor *)titleColor;
+ (UIColor *)blueButtonColor;
+ (UIColor *)blueSegmentColor;
+ (UIColor *)floatPLStatusBarColor;
+ (UIColor *)bluePriceBackgroundViewColor;
+ (UIColor *)loginBackgroundColor;

+ (UIColor *)blueUpColor;
+ (UIColor *)redDownColor;
+ (UIColor *)greenUpColor;
+ (UIColor *)buySellLabelColor;
+ (UIColor *)closePositionPopCellColor;

+ (UIColor *)marginCallViewTitleColor;
+ (UIColor *)orderStop;
+ (UIColor *)orderLimit;

+ (UIColor *)lowColor;
+ (UIColor *)highColor;
+ (UIColor *)middleColor;

+ (NSArray *)blueButtonColorArray;

+ (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor;



@end
