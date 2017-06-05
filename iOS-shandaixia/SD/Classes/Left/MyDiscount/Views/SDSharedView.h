//
//  SDSharedView.h
//  FuDai
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define sharedImageUrl @"http://zhixun-test.oss-cn-shanghai.aliyuncs.com/other/001.png"

#define sharedTitle @"有人@您，您的1000元额度和免息券已放入您的账户"

#define sharedContent @"小额度借款神器闪贷侠已经成功上线，并向你发放了一笔额度，点击就可领取！"

typedef enum {
    SDSharedWeChatFriend,
    SDSharedWeChatZone,
    SDSharedSina,
    SDSharedQQFriend,
    SDSharedQQzone,
    SDSharedCopyContent
 
}SDSharedType;

//分享协议
@protocol SDSharedViewDelegate <NSObject>

@optional
- (void)sharedViewSharedButtonDidClicked:(SDSharedType)sharedType;

@end


@interface SDSharedView : UIView

//分享类型
@property (nonatomic, assign) SDSharedType sharedType;

//代理
@property (nonatomic, weak) id<SDSharedViewDelegate> delegate;

- (void)show;

- (void)remove;

+ (instancetype)sharedSDLoadView;

@end
