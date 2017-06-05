//
//  SDIDCardHeaderView.h
//  SD
//
//  Created by 余艾星 on 17/3/1.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDIDCardHeaderView : UIView


@property (nonatomic, weak) UIImageView *progressImageView;

- (instancetype)initWithFrame:(CGRect)frame imageNamed:(NSString *)named;

@end
