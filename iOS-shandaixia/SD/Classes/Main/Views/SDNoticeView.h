//
//  SDNoticeView.h
//  SD
//
//  Created by 余艾星 on 17/3/11.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBAutoScrollLabel;

@interface SDNoticeView : UIView

@property (nonatomic, weak) UILabel *noticeLabel;

@property (nonatomic, weak) UIButton *noticeButton;

//滚动消息
@property (weak, nonatomic) CBAutoScrollLabel *autoScrollLabel;

@end
