//
//  YPBaseAnimator.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPBaseAnimator.h"

@implementation YPBaseAnimator

#pragma mark - Override
- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    _duration = 0.35f;
    return self;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerInteractiveTransitioning>)transitionContext
{
    return _duration;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com