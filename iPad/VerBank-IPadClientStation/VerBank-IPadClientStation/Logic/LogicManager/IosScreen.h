//
//  IosScreen.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/31.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat screenHeight;
static CGFloat screenWidth;

@interface IosScreen : NSObject

+ (void)setIsInRotation:(Boolean)isInRotation;

+ (CGFloat)getScreenHeight;
+ (CGFloat)getScreenWidth;

@end
