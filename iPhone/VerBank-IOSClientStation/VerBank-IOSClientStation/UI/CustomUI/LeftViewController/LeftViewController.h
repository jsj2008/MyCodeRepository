//
//  LeftViewController.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import "ContentView.h"


extern const CGFloat kDefaultRadius;
extern const NSUInteger kDefaultIterations;

@interface UIImage (LeftViewController)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end

@interface LeftViewController : UIViewController

@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, assign) CGFloat sideViewAlpha;
@property (nonatomic, retain) UIColor *sideViewTintColor;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIView *leftContentView;
@property (nonatomic, retain) UIView *centerContentView;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) ContentView *contentView;

- (void)setStateBarTitle:(NSString *)title centerButton:(UIButton *)button;

- (void)addKChartView:(NSString *)instrumentName;
- (void)popKChartView:(NSString *)instrumentName;

- (void)resetRightView;

@end
