//
//  CustomFont.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CustomFont.h"
#import "ScreenAuotoSizeScale.h"

@implementation CustomFont

+ (UIFont *)getCNHeavyWithSize:(CGFloat)size {
    //    return [UIFont fontWithName:@"SourceHanSansCN-Heavy" size:size];
    return [UIFont fontWithName:@"Microsoft YaHei" size:[ScreenAuotoSizeScale CGAutoMakeFloat:size]];
    
}

+ (UIFont *)getCNNormalWithSize:(CGFloat)size {
    //    return [UIFont fontWithName:@"SourceHanSansCN-Medium" size:size];
    return [UIFont fontWithName:@"Microsoft YaHei" size:[ScreenAuotoSizeScale CGAutoMakeFloat:size]];
}

+ (UIFont *)getENHeavyWithSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir-Heavy" size:[ScreenAuotoSizeScale CGAutoMakeFloat:size]];
}

+ (UIFont *)getENNormalWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Avenir-Medium" size:[ScreenAuotoSizeScale CGAutoMakeFloat:size]];
}

+ (UIFont *)getENLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Avenir-Light" size:[ScreenAuotoSizeScale CGAutoMakeFloat:size]];
}

@end
