//
//  SDCancelButton.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDRegistButton.h"

@interface SDRegistButton()


@end

@implementation SDRegistButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(204, 204, 204);
        
        UIButton *registButton = [UIButton buttonWithTitle:@"注册" titleColor:FDColor(153, 153, 153) titleFont:28 * SCALE];
        
        [self addSubview:registButton];
        self.registButton = registButton;
        registButton.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.height/2;
    self.clipsToBounds = YES;
    
    CGFloat w = self.width - 2;
    CGFloat h = self.height - 2;
    
    self.registButton.frame = CGRectMake(1, 1, w, h);
    self.registButton.layer.cornerRadius = h/2;
    self.registButton.clipsToBounds = YES;
}
@end
