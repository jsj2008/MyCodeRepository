//
//  SDSmallGestureView.m
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDSmallGestureView.h"

@implementation SDSmallGestureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = 20 * SCALE;
        
        for (NSInteger i = 0; i < 9; i ++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            
            imageView.backgroundColor = FDColor(207, 208, 222);
            
            imageView.tag = i;
            
            imageView.layer.cornerRadius = w/2;
            imageView.clipsToBounds = YES;
            
            [self addSubview:imageView];
            
            imageView.width = w;
            imageView.height = w;
            imageView.y = (imageView.tag/3) * w * 2;
            imageView.x = (imageView.tag)%3 * w * 2;
            
        }
        
    }
    return self;
}

@end
