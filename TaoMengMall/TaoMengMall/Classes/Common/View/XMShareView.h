//
//  ShareView.h
//  YouJu
//
//  Created by wzningjie on 16/10/10.
//  Copyright © 2016年 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareInfoModel.h"

typedef NS_ENUM(NSUInteger, XMShareType) {
    XMShareTypeWeChat,
    XMShareTypeTimeline,
    XMShareTypeWeiBo,
    XMShareTypeQQ,
    XMShareTypeZone
};

@class XMShareView;

@protocol XMShareViewDelegate <NSObject>

- (void)shareView:(XMShareView*)shareView clickWithShareType:(XMShareType)type;
@optional
- (void)shareViewDidCancel:(XMShareView*)shareView;
@end

@interface XMShareView : UIView

@property (nonatomic, weak)id<XMShareViewDelegate> delegate;

//当设置shareInfo，自动执行分享
@property (nonatomic, strong)ShareInfoModel *shareInfo;

- (void)dismiss;
- (void)show;
@end
