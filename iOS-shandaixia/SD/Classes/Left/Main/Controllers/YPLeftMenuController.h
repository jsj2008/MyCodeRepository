//
//  YPLeftMenuController.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/25.
//  Copyright © 2016年 tyiti. All rights reserved.
//  侧滑菜单控制器

#import <UIKit/UIKit.h>


//代理传值
@protocol SDLeftMenuDetailButtonDidClickedDelegate <NSObject>

@optional

- (void)leftMenuDetailButtonDidClickedWithTag:(NSInteger)tag;

@end



@interface YPLeftMenuController : UIViewController

//代理
@property (nonatomic,weak) id<SDLeftMenuDetailButtonDidClickedDelegate> delegate;

@end