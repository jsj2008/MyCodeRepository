//
//  UIBarButtonItem+YAXCategory.m
//  WeiBo
//
//  Created by 余艾星 on 16/3/14.
//  Copyright © 2016年 余艾星. All rights reserved.
//

#import "UIBarButtonItem+YAXCategory.h"

@implementation UIBarButtonItem (YAXCategory)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)selector image:(NSString *)image highlightedImage:(NSString *)highlightedImage{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
    
    
    
    
    if (image) {
        
        [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    
    if (highlightedImage) {
        
//        [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    
    
    
    [button sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
