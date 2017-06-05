//
//  SDHighProveButton.h
//  SD
//
//  Created by 余艾星 on 17/2/28.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDHighProveButton : UIButton

@property (nonatomic, weak) UIImageView *finishedImageView;
@property (nonatomic, weak) UIImageView *percentImageView;

+ (SDHighProveButton *)buttonWithImage:(NSString *)imageName backImageNamed:(NSString *)backName;


@end
