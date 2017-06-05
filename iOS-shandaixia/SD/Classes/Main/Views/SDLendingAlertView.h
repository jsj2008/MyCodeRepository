//
//  SDLendingAlertView.h
//  SD
//
//  Created by 余艾星 on 17/3/11.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDLoginButton;
@class SDLending;

@protocol SDLendingAlertViewDelegate <NSObject>

@optional
- (void)lendingAlertViewKnowButtonDidClicked:(SDLending *)lending;

@end

@interface SDLendingAlertView : UIView

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) SDLoginButton *knowButton;


@property (nonatomic, strong) SDLending *lending;


@property (nonatomic, weak) id<SDLendingAlertViewDelegate> delegate;


+ (instancetype)sharedLendingAlertView;

+ (void)show;
+ (void)dismiss;

@end
