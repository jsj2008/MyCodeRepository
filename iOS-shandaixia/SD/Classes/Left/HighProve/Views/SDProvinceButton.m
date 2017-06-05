//
//  SDProvinceButton.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDProvinceButton.h"

@implementation SDProvinceButton

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_area_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_area_press"] forState:UIControlStateSelected];
        [self setTitleColor:FDColor(34, 34, 34) forState:UIControlStateNormal];
        [self setTitleColor:SDWhiteColor forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:30 * SCALE];
        
        [self sizeToFit];
        
        
    }
    return self;
}

@end
