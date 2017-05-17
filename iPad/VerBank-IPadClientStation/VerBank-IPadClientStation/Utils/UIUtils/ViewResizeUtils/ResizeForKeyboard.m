//
//  ResizeForKeyboard.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ResizeForKeyboard.h"

@implementation ResizeForKeyboard

+ (void) setViewPosition:(UIView *)view forY:(CGFloat)y{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = view.frame;
    rect.origin.y = y;
    view.frame = rect;
    
    [UIView commitAnimations];
}

@end
