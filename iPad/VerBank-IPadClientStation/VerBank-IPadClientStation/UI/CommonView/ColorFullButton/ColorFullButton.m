//
//  ColorFullButton.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ColorFullButton.h"


@implementation ColorFullButton

// 可以在Xib中用 keyPath設置
@synthesize style;
@synthesize corner;

- (void)drawRect:(CGRect)rect {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width,rect.size.height), NO, 0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray *gradientColors = nil;
    switch (self.style) {
        case ButtonGray:
            gradientColors = [self getComplexGrayColors];
            break;
        case ButtonRed:
            gradientColors = [self getComplexRedColors];
            break;
        case ButtonBlue:
            gradientColors = [self getComplexBlueColors];
            break;
        case ButtonCealer:
            gradientColors = [self getComplexClearColors];
            break;
        default:
            break;
    }
    CGFloat gradientLocations[] = {0, 0.5, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.corner];
    CGContextSaveGState(context);
    [roundedRectanglePath fill];
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, rect.size.height), 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:im forState:UIControlStateNormal];
}

- (NSArray *)getComplexGrayColors {
    return  [NSArray arrayWithObjects:
             (id)[UIColor colorWithRed:203.0 / 255.0 green:203.0 / 255.0 blue:203.0 / 255.0 alpha:1.0].CGColor,
             (id)[UIColor colorWithRed:167.0 / 255.0 green:167.0 / 255.0 blue:167.0 / 255.0 alpha:1.0].CGColor,
             (id)[UIColor colorWithRed:135.0 / 255.0 green:135.0 / 255.0 blue:135.0 / 255.0 alpha:1.0].CGColor,nil];
    
}

- (NSArray *)getComplexBlueColors {
    return [NSArray arrayWithObjects:
            (id)[UIColor colorWithRed:40.0 / 255.0 green:128.0 / 255.0 blue:251.0 / 255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:31.0 / 255.0 green:104.0 / 255.0 blue:206.0 / 255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:23.0 / 255.0 green:84.0 / 255.0 blue:167.0 / 255.0 alpha:1.0].CGColor,nil];
}

- (NSArray *)getComplexRedColors {
    return [NSArray arrayWithObjects:
            (id)[UIColor colorWithRed:175.0 / 255.0 green:20.0 / 255.0 blue:24.0 / 255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:145.0 / 255.0 green:9.0 / 255.0 blue:11.0 / 255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:122.0 / 255.0 green:2.0 / 255.0 blue:2.0 / 255.0 alpha:1.0].CGColor,nil];
}

- (NSArray *)getComplexClearColors {
    return [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, nil];
}


@end
