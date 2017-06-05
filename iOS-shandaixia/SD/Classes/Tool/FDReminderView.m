//
//  FDReminderView.m
//  FuDai
//
//  Created by Apple on 16/8/25.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import "FDReminderView.h"

@implementation FDReminderView


+ (void)showWithString:(NSString *)str{

    CGFloat height = 90 * SCALE;
    
    CGSize size = [str sizeWithSize:CGSizeMake(SCREENWIDTH, height) font:15];
    
    CGFloat width = size.width + 60 * SCALE;
    
    UILabel *label = [UILabel labelWithText:str textColor:[UIColor whiteColor] font:15 textAliment:NSTextAlignmentCenter];
    
    label.layer.cornerRadius = 16*SCALE;
    label.clipsToBounds = YES;
    
    label.frame = CGRectMake(SCREENWIDTH/2 - width/2, SCREENHEIGHT/2 - 45 * SCALE, width, height);
    
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0;
    
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [UIView animateWithDuration:0.25 animations:^{
       
        label.alpha = 0.6;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        [UIView animateWithDuration:0.25 animations:^{
            
            label.alpha = 0;
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
    });
    
}

+ (UIImageView *)viewWithImageNamed:(NSString *)imageNamed andParentView:(UIView *)view andY:(CGFloat)y{

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    
    [imageView sizeToFit];
    
    imageView.centerX = SCREENWIDTH/2;
    
    imageView.y = y;
    
    [view addSubview:imageView];
    
    return imageView;
    
}

@end
