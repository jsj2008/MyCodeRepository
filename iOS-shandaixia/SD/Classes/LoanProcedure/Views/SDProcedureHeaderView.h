//
//  SDProcedureHeaderView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/25.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDNumberView;
@class SDLoan;

@interface SDProcedureHeaderView : UIView

//借款金额
@property (nonatomic, weak) SDNumberView *loanPriceView;
//借款期限
@property (nonatomic, weak) SDNumberView *loanTimeView;

@property (nonatomic, strong) SDLoan *loan;

@end
