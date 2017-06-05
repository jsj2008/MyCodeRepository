//
//  SDSubmitView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/25.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoan;
@class SDSpecialDiscount;

@interface SDSubmitView : UIView

@property (nonatomic, strong) SDLoan *loan;

@property (nonatomic, weak) UIButton *submitButton;

@property (nonatomic, strong) SDSpecialDiscount *specialDiscount;

@end
