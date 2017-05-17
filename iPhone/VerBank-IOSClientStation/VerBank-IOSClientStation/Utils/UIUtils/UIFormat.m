//
//  UIFormat.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UIFormat.h"

#define SEGBUTTONLEFT -1
#define SEGBUTTONRIGHT 1
#define SEGBUTTONMIDDLE 0

#define DEFAULT_CORNER_RADIUS 8.0f

@implementation UIFormat

+ (void)setCorner:(NSUInteger)cornerType WithUIView:(UIView *)view{
    [self setCorner:cornerType WithUIView:view withCorner:DEFAULT_CORNER_RADIUS];
}

+ (void)setCorner:(NSUInteger)cornerType WithUIView:(UIView *)view withCorner:(float)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:cornerType
                                                         cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    view.layer.masksToBounds = YES;
}

+(void)setViewStyle:(UIView *)mView
withBackgroundColor:(UIColor *)backgroundColor
 andTextNormalColor:(UIColor *)normalColor
   andTextHighColor:(UIColor *)highColor
        andTextFont:(UIFont *)textFont
          andCorner:(NSInteger)cornerValue{
    if ([mView isKindOfClass:[UILabel class]])
    {
        UILabel *mLabel = (UILabel *)mView;
        [mLabel setBackgroundColor:backgroundColor];
        [mLabel setTextColor:normalColor];
        [mLabel setFont:textFont];
        [self setCorner:cornerValue WithUIView:mLabel];
    }
    
    if ([mView isKindOfClass:[UITextField class]]) {
        UITextField *mTextField = (UITextField *)mView;
        [mTextField setBackgroundColor:backgroundColor];
        [mTextField setTextColor:normalColor];
        [mTextField setFont:textFont];
        [self setCorner:cornerValue WithUIView:mTextField];
    }
    
    if ([mView isKindOfClass:[UIButton class]]) {
        UIButton *mButton = (UIButton *)mView;
        [mButton setBackgroundColor:backgroundColor];
        [mButton setTitleColor:normalColor forState:UIControlStateNormal];
        [mButton setTitleColor:highColor forState:UIControlStateHighlighted];
        [mButton.titleLabel setFont:textFont];
        [self setCorner:cornerValue WithUIView:mButton];
    }
    
    if ([mView isKindOfClass:[UIImageView class]]) {
        UIImageView *mImageView = (UIImageView *)mView;
        [mImageView setBackgroundColor:backgroundColor];
        [self setCorner:cornerValue WithUIView:mImageView];
    }
    
    if ([mView isKindOfClass:[UITextView class]]) {
        UITextView *mTextView =(UITextView *)mView;
        [mTextView setBackgroundColor:backgroundColor];
        [mTextView setTextColor:normalColor];
    }
    
    if ([mView isKindOfClass:[UITableView class]]) {
        UITableView *mTableView = (UITableView *)mView;
        [mTableView setBackgroundColor:backgroundColor];
    }
}

+ (void)setComplexBlueButtonColor:(UIButton *)button{
    NSArray *normalColorArray = [NSArray arrayWithObjects:
                                 (id)[UIColor colorWithRed:40.0 / 255.0 green:128.0 / 255.0 blue:251.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:31.0 / 255.0 green:104.0 / 255.0 blue:206.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:23.0 / 255.0 green:84.0 / 255.0 blue:167.0 / 255.0 alpha:1.0],nil];
    UIImage *normalBackImage = [UIFormat buttonImageFromColors:normalColorArray ByGradientType:topToBottom atView:button];
    
    [button setBackgroundImage:normalBackImage forState:UIControlStateNormal];
}

+ (void)setComplexGrayButtonColor:(UIButton *)button {
    NSArray *normalColorArray = [NSArray arrayWithObjects:
                                 (id)[UIColor colorWithRed:203.0 / 255.0 green:203.0 / 255.0 blue:203.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:167.0 / 255.0 green:167.0 / 255.0 blue:167.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:135.0 / 255.0 green:135.0 / 255.0 blue:135.0 / 255.0 alpha:1.0],nil];
    UIImage *normalBackImage = [UIFormat buttonImageFromColors:normalColorArray ByGradientType:topToBottom atView:button];
    
    [button setBackgroundImage:normalBackImage forState:UIControlStateNormal];
}

+ (void)setComplexRedButtonColor:(UIButton *)button {
    NSArray *normalColorArray = [NSArray arrayWithObjects:
                                 (id)[UIColor colorWithRed:175.0 / 255.0 green:20.0 / 255.0 blue:24.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:145.0 / 255.0 green:9.0 / 255.0 blue:11.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:122.0 / 255.0 green:2.0 / 255.0 blue:2.0 / 255.0 alpha:1.0],nil];
    UIImage *normalBackImage = [UIFormat buttonImageFromColors:normalColorArray ByGradientType:topToBottom atView:button];
    
    [button setBackgroundImage:normalBackImage forState:UIControlStateNormal];
}

+ (void)setComplexGrayViewColor:(UIImageView *)view {
    NSArray *normalColorArray = [NSArray arrayWithObjects:
                                 (id)[UIColor colorWithRed:200.0 / 255.0 green:200.0 / 255.0 blue:200.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:160.0 / 255.0 green:160.0 / 255.0 blue:160.0 / 255.0 alpha:1.0],
                                 (id)[UIColor colorWithRed:130.0 / 255.0 green:130.0 / 255.0 blue:130.0 / 255.0 alpha:1.0],nil];
    UIImage *normalBackImage = [UIFormat buttonImageFromColors:normalColorArray ByGradientType:topToBottom atView:view];
    
    [view setImage:normalBackImage];
}

+ (void)setComplexClearViewColor:(UIImageView *)view {
    NSArray *normalColorArray = [NSArray arrayWithObjects:
                                 [UIColor clearColor],nil];
    UIImage *normalBackImage = [UIFormat buttonImageFromColors:normalColorArray ByGradientType:topToBottom atView:view];
    
    [view setImage:normalBackImage];
}

+ (UIImage*) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType atView:(UIView *)view{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);
//        UIGraphicsPushContext(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, view.frame.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(view.frame.size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(view.frame.size.width, view.frame.size.height);
            break;
        case 3:
            start = CGPointMake(view.frame.size.width, 0.0);
            end = CGPointMake(0.0, view.frame.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
//    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (void)initButtonStyle:(UIButton *)btn {
    [btn.layer setCornerRadius:5.0f];
    [btn.layer setBorderWidth:1.0f];
    [btn.layer setBorderColor:[UIColor grayColor].CGColor];
}

@end
