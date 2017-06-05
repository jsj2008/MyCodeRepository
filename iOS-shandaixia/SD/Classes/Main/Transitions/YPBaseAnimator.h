//
//  YPBaseAnimator.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YPBaseAnimator : NSObject

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, strong) id<UIViewControllerInteractiveTransitioning> interactiveTransitioning;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerInteractiveTransitioning>)transitionContext;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com