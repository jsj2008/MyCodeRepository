//
//  FDAlertView.h
//  FuDai
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAlertView : UIView



//标题
@property (nonatomic, weak) UILabel *titleLabel;

//左边按钮
@property (nonatomic, weak) UIButton *leftButton;

//右边按钮
@property (nonatomic, weak) UIButton *rightButton;


- (void)show;

- (void)dismiss;

@end
