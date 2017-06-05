//
//  YPIconBtn.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/25.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPIconBtn.h"

@implementation YPIconBtn

#pragma mark - Public
+ (instancetype)iconBtn
{
    return [[self alloc] init];
}

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    [self prepare];
    
    return self;
}

#pragma mark - Private

- (void)prepare {};

#pragma mark - setter

/** 取消高亮 */
- (void)setHighlighted:(BOOL)highlighted {}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com