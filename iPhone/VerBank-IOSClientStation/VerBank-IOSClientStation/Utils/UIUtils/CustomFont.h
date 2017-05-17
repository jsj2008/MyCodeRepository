//
//  CustomFont.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomFont : NSObject

+ (UIFont *)getCNHeavyWithSize:(CGFloat)size;
+ (UIFont *)getCNNormalWithSize:(CGFloat)size;

+ (UIFont *)getENHeavyWithSize:(CGFloat)size;
+ (UIFont *)getENNormalWithSize:(CGFloat)size;
+ (UIFont *)getENLightWithSize:(CGFloat)size;

@end
