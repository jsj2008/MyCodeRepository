//
//  UIView+AddLine.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/1.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "UIView+AddLine.h"
#import "ScreenAuotoSizeScale.h"

#define BottomLineViewTag   300
#define TopLineViewTag      301

const CGFloat addLineTopHeight     = 1.0f;
const CGFloat addLineBottomHeight  = 1.0f;

@implementation UIView (AddLine)

- (void)addBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    if ([self viewWithTag:BottomLineViewTag] != nil) {
        return;
    }
//    CGRect f = self.frame;
//    f.size.height += width;
//    self.frame = f;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - width, self.frame.size.width, width)];
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    [bottomLine setTag:BottomLineViewTag];
    [self addSubview:bottomLine];
}

- (void)addTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    if ([self viewWithTag:TopLineViewTag] != nil) {
        return;
    }
//    CGRect f = self.frame;
//    f.size.height += width;
//    self.frame = f;
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, self.frame.size.width, width)];
    topLine.backgroundColor = color;
    //    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [topLine setTag:TopLineViewTag];
    [self addSubview:topLine];
}

//- (UIView *)addVerticalLineWithWidth:(CGFloat)width bgColor:(UIColor *)color atX:(CGFloat)x {
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, 0.0f, width, self.bounds.size.height)];
//    line.backgroundColor = color;
//    line.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
//    [self addSubview:line];
//    return line;
//}

- (void)addHeaderBottomLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    
    if ([self viewWithTag:BottomLineViewTag] != nil) {
        return;
    }
    
//    CGRect f = self.frame;
//    f.size.height += width;
//    self.frame = f;
    
    CGFloat offset = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(offset, self.frame.size.height - width, self.frame.size.width - offset + 1, width)];
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [bottomLine setTag:BottomLineViewTag];
    [self addSubview:bottomLine];
}

- (void)addHeaderTopLineWithWidth:(CGFloat)width bgColor:(UIColor *)color {
    
    if ([self viewWithTag:TopLineViewTag] != nil) {
        return;
    }
    
//    CGRect f = self.frame;
//    f.size.height += width;
//    self.frame = f;
    
    CGFloat offset = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(offset, 0.0f, self.frame.size.width - offset + 1, width)];
    topLine.backgroundColor = color;
    //    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [topLine setTag:TopLineViewTag];
    [self addSubview:topLine];
}


@end
