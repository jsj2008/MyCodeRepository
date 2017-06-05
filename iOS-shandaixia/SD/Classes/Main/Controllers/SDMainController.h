//
//  SDMainController.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoan;
@class SDUserVerifyDetail;


@protocol SDMainControllerDelegate <NSObject>

@optional
- (void)mainControllerScrollDelegate;

@end

@interface SDMainController : UIViewController

//立即借钱
@property (nonatomic, weak) UIButton *loanButton;

@property (nonatomic, weak) UIButton *refundButton;

@property (nonatomic, strong) SDLoan *loan;

@property (nonatomic, strong) SDUserVerifyDetail *userVerifyDetail;

@property (nonatomic, weak) id<SDMainControllerDelegate> delegate;

@end
