//
//  SDSharedHeaderView.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/22.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDNumberView;

@interface SDSharedHeaderView : UIView

//呼唤好友
@property (nonatomic, weak) UIButton *callFriendButton;

//邀请人数
@property (nonatomic, weak) SDNumberView *numberOfManView;

//减免金额
@property (nonatomic, weak) SDNumberView *discountMoneyView;

//排行榜
@property (nonatomic, weak) UIView *levelView;

@end
