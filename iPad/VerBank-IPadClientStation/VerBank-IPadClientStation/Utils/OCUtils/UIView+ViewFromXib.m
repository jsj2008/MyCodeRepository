//
//  UIView+ViewFromXib.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "UIView+ViewFromXib.h"

@implementation UIView (ViewFromXib)

+ (instancetype)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    id contentView = [nib objectAtIndex:0];
    [contentView initContent];
    return contentView;
}

+ (instancetype)newInstanceWithClassName:(NSString *)className {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:className owner:self options:nil];
    id contentView = [nib objectAtIndex:0];
    [contentView initContent];
    return contentView;
}

+ (instancetype)newInstanceWithNibIndex:(NSUInteger)index {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    id contentView = [nib objectAtIndex:index];
    [contentView initContent];
    return contentView;
}

- (void)initContent {
    NSLog(@"this is abstract content");
}

@end
