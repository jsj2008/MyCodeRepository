//
//  SDLoanView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoan;
@class SDLending;

@interface SDLoanView : UIView

@property (nonatomic, strong) SDLoan *loan;

@property (nonatomic, strong) SDLending *lending;

//立即借钱
@property (nonatomic, weak) UIButton *loanButton;



@end
