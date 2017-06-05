//
//  SDLoginButton.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoginButton.h"

@implementation SDLoginButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(70, 151, 251);
        [self setTitle:@"登录" forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.layer.cornerRadius = self.height/2;
    self.clipsToBounds = YES;
}

@end
