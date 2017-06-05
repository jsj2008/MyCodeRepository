//
//  YPReusableControllerConst.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "YPReusableControllerConst.h"

float YPDeviceSystemVersion() {
    static float version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.floatValue;
    });
    return version;
}


const CGFloat YPStyleBarHeight = 64.0f;
const CGFloat YPStyleBarLeftOrRightBtnWH = 44.0f;
NSString *const YPKeyPathContentOffset = @"contentOffset";
NSString *const YPKeyPathContentSize = @"contentSize";// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com