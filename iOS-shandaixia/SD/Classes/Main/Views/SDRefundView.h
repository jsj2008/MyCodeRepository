//
//  SDRefundView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/4.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDLoan.h"
@class SDLending;

@interface SDRefundView : UIView

@property (nonatomic, strong) SDLoan *loan;
@property (nonatomic, strong) SDLending *lending;
//还款按钮
@property (nonatomic, weak) UIButton *refundButton;


@end
