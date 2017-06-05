//
//  UIBarButtonItem+YAXCategory.h
//  WeiBo
//
//  Created by 余艾星 on 16/3/14.
//  Copyright © 2016年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YAXCategory)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)selector image:(NSString *)image highlightedImage:(NSString *)highlightedImage;

@end
