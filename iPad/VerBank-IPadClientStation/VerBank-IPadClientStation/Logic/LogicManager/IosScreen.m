//
//  IosScreen.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/31.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IosScreen.h"
#import "IOSLayoutDefine.h"

@implementation IosScreen

+ (void)setIsInRotation:(Boolean)isInRotation {
    if (isInRotation) {
        screenHeight = [UIScreen mainScreen].bounds.size.width;
        screenWidth = [UIScreen mainScreen].bounds.size.height;
    } else {
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
}

+ (CGFloat)getScreenHeight {
    return screenHeight;
}

+ (CGFloat)getScreenWidth {
    return screenWidth;
}

@end
