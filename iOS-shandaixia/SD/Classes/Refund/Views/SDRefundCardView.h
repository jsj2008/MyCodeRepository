//
//  SDRefundCardView.h
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDBankCard;
@class SDLending;

@interface SDRefundCardView : UIView

@property (nonatomic, strong) SDLending *lending;

@property (nonatomic, weak) UIImageView *bankIconImageView;

@property (nonatomic, strong) SDBankCard *bankCard;

@property (nonatomic, weak) UIButton *chooseButton;

@property (nonatomic, weak) UIImageView *lineImageView;

@property (nonatomic, weak) UITextField *refundTextField;

@end
