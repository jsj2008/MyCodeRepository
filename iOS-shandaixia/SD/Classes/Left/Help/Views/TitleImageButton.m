//
//  TitleImageButton.m
//  SD
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "TitleImageButton.h"

@interface TitleImageButton()



@end

@implementation TitleImageButton

- (instancetype) init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self addSubview:imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageHeight = CGRectGetWidth(self.frame);
    CGFloat imageWidth = CGRectGetWidth(self.frame);
    
    CGFloat labelHeight = CGRectGetHeight(self.frame) - imageHeight;
    CGFloat labelWidth = CGRectGetWidth(self.frame);
    
    [self.imageView setFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
    [self.titleLabel setFrame:CGRectMake(0, imageHeight, labelWidth, labelHeight)];
}

@end
