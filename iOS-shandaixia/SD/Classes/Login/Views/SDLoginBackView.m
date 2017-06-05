//
//  SDLoginBackView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoginBackView.h"

@interface SDLoginBackView ()

@property (nonatomic, weak) UIImageView *backImageView;

@end

@implementation SDLoginBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back_image"]];
        self.backImageView = backImageView;
        [self addSubview:backImageView];
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.backImageView.frame = CGRectMake(0, self.height - 190 * SCALE, SCREENWIDTH, 190 * SCALE);
    
}

@end
