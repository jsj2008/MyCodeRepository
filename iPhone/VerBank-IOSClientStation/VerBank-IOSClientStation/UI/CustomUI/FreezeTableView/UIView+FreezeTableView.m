//
//  UIView+FreezeTableView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UIView+FreezeTableView.h"

#import "ScreenAuotoSizeScale.h"

@implementation UIView (FreezeTableView)

#pragma UIView catelog
- (void)addBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    CGRect f = self.frame;
    f.size.height += width;
    self.frame = f;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - width, self.frame.size.width, width)];
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:bottomLine];
}

- (void)addTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    CGRect f = self.frame;
    f.size.height += width;
    self.frame = f;
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, 5.0f, self.frame.size.width, width)];
    topLine.backgroundColor = color;
//    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:topLine];
}

- (UIView *)addVerticalLineWithWidth:(CGFloat)width bgColor:(UIColor *)color atX:(CGFloat)x {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, 0.0f, width, self.bounds.size.height)];
    line.backgroundColor = color;
    line.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:line];
    return line;
}

- (void)addHeaderBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    CGRect f = self.frame;
    f.size.height += width;
    self.frame = f;
    
    CGFloat offset = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(offset, self.frame.size.height - width, self.frame.size.width - offset + 1, width)];
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:bottomLine];
}

- (void)addHeaderTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    CGRect f = self.frame;
    f.size.height += width;
    self.frame = f;
    
    CGFloat offset = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(offset, 5.0f, self.frame.size.width - offset + 1, width)];
    topLine.backgroundColor = color;
//    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:topLine];
}

@end
