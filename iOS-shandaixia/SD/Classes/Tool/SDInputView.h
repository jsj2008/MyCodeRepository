//
//  SDInputView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDImageRightButton;

@interface SDInputView : UIView

//输入框
@property (nonatomic, weak) UITextField *inputTextField;

@property (nonatomic, weak) SDImageRightButton *chooseButton;

//右侧按钮
@property (nonatomic, weak) UIButton *rightButton;

//只有文字的按钮
@property (nonatomic, weak) UIButton *titlesButton;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder;

@end
