//
//  SDAlipayView.h
//  SD
//
//  Created by 余艾星 on 17/3/17.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoginButton;
@class SDLending;


@interface SDAlipayView : UIView

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) SDLoginButton *knowButton;



+ (instancetype)sharedAlipayView;

+ (void)showWithLending:(SDLending *)lending;
+ (void)dismiss;

@end
