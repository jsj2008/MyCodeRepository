//
//  UIColor+CustomColor.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)backgroundColor{
    //    return [UIColor colorWithRed:43.0 / 255.0 green:43.0 / 255.0 blue:43.0 / 255.0 alpha:1.0].copy;
    return [UIColor blackColor].copy;
}

+ (UIColor *)loginBackgroundColor {
    return [UIColor colorWithRed:43.0 / 255.0 green:43.0 / 255.0 blue:43.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)leftTableViewBackgroundColor {
    return [UIColor colorWithRed:55.0 / 255.0 green:55.0 / 255.0 blue:55.0 / 255.0 alpha:1.0].copy;
}


+ (UIColor *)mainBackgroundColor {
    return [UIColor colorWithRed:40.0 / 255.0 green:40.0 / 255.0 blue:40.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)tabBackgroundColor {
    return [UIColor colorWithRed:75.0 / 255.0 green:75.0 / 255.0 blue:75.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)titleColor{
    return [UIColor colorWithRed:134.0 / 255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)blueButtonColor{
    return [UIColor colorWithRed:34.0 / 255.0 green:112.0 / 255.0 blue:220.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)blueSegmentColor{
    return [UIColor colorWithRed:24.0 / 255.0 green:82.0 / 255.0 blue:164.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)floatPLStatusBarColor{
    return [UIColor colorWithRed:50.0 / 255.0 green:51.0 / 255.0 blue:53.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)bluePriceBackgroundViewColor{
    return [UIColor colorWithRed:24.0 / 255.0 green:82.0 / 255.0 blue:164.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)blueUpColor{
    return [UIColor colorWithRed:3.0 / 255.0 green:153.0 / 255.0 blue:221.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)redDownColor{
    return [UIColor colorWithRed:192.0 / 255.0 green:19.0 / 255.0 blue:1.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)greenUpColor{
    return [UIColor colorWithRed:64.0 / 255.0 green:169.0 / 255.0 blue:129.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)buySellLabelColor{
    return [UIColor colorWithRed:237.0 / 255.0 green:158.0 / 255.0 blue:3.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)closePositionPopCellColor{
    return [UIColor colorWithRed:71.0 / 255.0 green:69.0 / 255.0 blue:70.0 / 255.0 alpha:1.0].copy;
}

+ (UIColor *)marginCallViewTitleColor {
    return [UIColor colorWithRed:24.0f / 255.0f green:82.0f / 255.0f blue:164.0f / 255.0f alpha:1.0].copy;
}

+ (UIColor *)orderStop {
    return [UIColor colorWithRed:255.0/255.0
                           green:75.0/255.0
                            blue:82.0/255.0
                           alpha:1.0f];
}

+ (UIColor *)orderLimit {
    return [UIColor colorWithRed:80.0/255.0
                           green:201.0/255.0
                            blue:255.0/255.0
                           alpha:1.0f];
}

+ (NSArray *)blueButtonColorArray{
    return [NSArray arrayWithObjects:(id)[UIColor colorWithRed:40.0 / 255.0 green:128.0 / 255.0 blue:251.0 / 255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:31.0 / 255.0 green:104.0 / 255.0 blue:206.0 / 255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:23.0 / 255.0 green:84.0 / 255.0 blue:167.0 / 255.0 alpha:1.0].CGColor, nil].copy;
}

+ (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}
+ (UIColor *)lowColor {
    return [UIColor colorWithRed:80.0/255.0
                           green:179.0/255.0
                            blue:65.0/255.0
                           alpha:1.0f];
}

+ (UIColor *)highColor {
    return [UIColor colorWithRed:238.0/255.0
                           green:63.0/255.0
                            blue:46.0/255.0
                           alpha:1.0f];
}

+ (UIColor *)middleColor {
    return [UIColor colorWithRed:179.0/255.0
                           green:141.0/255.0
                            blue:6.0/255.0
                           alpha:1.0f];
}
@end
