//
//  SDRocketAlertView.h
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoginButton;



@interface SDRocketAlertView : UIView

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) SDLoginButton *knowButton;



+ (instancetype)sharedRocketAlertView;

+ (void)show;
+ (void)dismiss;

@end
