//
//  UIView+RefreshExtension.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UIView+RefreshExtension.h"

@implementation UIView (RefreshExtension)

- (CGFloat)refreshViewHeight {
    return self.frame.size.height;
}

- (void)setRefreshViewHeight:(CGFloat)refreshViewHeight {
    CGRect temp = self.frame;
    temp.size.height = refreshViewHeight;
    self.frame = temp;
}

- (CGFloat)refreshViewWidth {
    return self.frame.size.width;
}

- (void)setRefreshViewWidth:(CGFloat)refreshViewWidth {
    CGRect temp = self.frame;
    temp.size.width = refreshViewWidth;
    self.frame = temp;
}

- (CGFloat)refreshViewY {
    return self.frame.origin.y;
}

- (void)setRefreshViewY:(CGFloat)refreshViewY {
    CGRect temp = self.frame;
    temp.origin.y = refreshViewY;
    self.frame = temp;
}

@end
