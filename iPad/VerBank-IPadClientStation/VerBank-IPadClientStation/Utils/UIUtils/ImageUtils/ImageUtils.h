//
//  ImageUtils.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtils : NSObject

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;
+ (UIImage *)imageWithView:(UIView *)selectView;
@end
