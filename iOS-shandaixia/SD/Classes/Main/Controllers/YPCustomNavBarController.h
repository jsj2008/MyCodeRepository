//
//  YPCustomNavBarController.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPReusableControllerConst.h"
#import "YPBaseTransitionsController.h"

typedef void(^YPCustomNavBarControllerNormalBlock)(void);

@interface YPCustomNavBarController : YPBaseTransitionsController

@property (nonatomic, weak) UIView *navBarContainer;

- (void)leftBtnDidTouch;


/**
 *  固定样式
 *
 *  @param title 标题
 */
- (void)createNavBarWithTitle:(NSString *)title;

#pragma mark - Public
- (void)createNavBarWithTitle:(NSString *)title titleColor:(UIColor *)color backImageNamed:(NSString *)named backGroundColor:(UIColor *)backColor;

//- (void)createNavBarWithTitle:(NSString *)title rightAction:(YPCustomNavBarControllerNormalBlock)actionBlock;

- (void)createNavBarWithTitle:(NSString *)title withRightTile:(NSString *)rightTitle andAction:(YPCustomNavBarControllerNormalBlock)actionBlock;

- (void)noContentUIWithImageNamed:(NSString *)named;

@end
