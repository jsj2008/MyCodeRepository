//
//  SDHighProveButton.m
//  SD
//
//  Created by 余艾星 on 17/2/28.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDHighProveButton.h"



@implementation SDHighProveButton

//快速创建一个按钮带背景图
+ (SDHighProveButton *)buttonWithImage:(NSString *)imageName backImageNamed:(NSString *)backName{
    
    SDHighProveButton *button = [[self alloc] init];
    
    if (imageName) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (backName) {
        
        [button setBackgroundImage:[UIImage imageNamed:backName] forState:UIControlStateNormal];
    }
    
    button.backgroundColor = [UIColor whiteColor];
    
    [button sizeToFit];
    
    UIImageView *finishedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_rz_OK"]];
    
    [finishedImageView sizeToFit];
    
    finishedImageView.hidden = YES;
    
    [button addSubview:finishedImageView];
    
    button.finishedImageView = finishedImageView;
    
    //百分比
    UIImageView *percentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"highProve_20percent"]];
    
    [percentImageView sizeToFit];
    
    percentImageView.hidden = YES;
    
    [button addSubview:percentImageView];
    
    button.percentImageView = percentImageView;
    
    return button;
    
}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat width = self.finishedImageView.width;
    CGFloat height = self.finishedImageView.height;
    
    self.finishedImageView.x = self.width - 0.72 * width;
    self.finishedImageView.y = self.height - 0.72 * height;
    
    self.percentImageView.x = self.width - self.percentImageView.width;
    self.percentImageView.y = 0;
}

@end
