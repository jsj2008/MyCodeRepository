//
//  ThirdPartLoginView.h
//  BabyDaily
//
//  Created by marco on 8/18/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThirdPartLoginViewDelegate <NSObject>

- (void)weiboAuthorizeLogin;//微博授权登录
- (void)wechatAuthorizeLogin;//微信授权登录
- (void)tencentAuthorizeLogin;//QQ授权登录

@end

@interface ThirdPartLoginView : UIView

@property (nonatomic, assign) BOOL hideName;

@property (nonatomic, weak) id <ThirdPartLoginViewDelegate> delegate;

- (instancetype)initWithDelegate:(id <ThirdPartLoginViewDelegate>)delegate;


@end
