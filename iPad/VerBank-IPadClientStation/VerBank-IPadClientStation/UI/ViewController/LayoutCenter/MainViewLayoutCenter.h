//
//  LayoutCenter.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopContentView.h"
#import "LeftContentView.h"
#import "RightContentView.h"
#import "BottomContentView.h"
#import "UIView+AutoLayout.h"



@interface MainViewLayoutCenter : NSObject

@property (nonatomic, strong) TopContentView     *topContentView;
@property (nonatomic, strong) LeftContentView     *leftContentView;
@property (nonatomic, strong) RightContentView    *rightContentView;
@property (nonatomic, strong) BottomContentView   *bottomContentView;

@property (nonatomic, strong) UIView *containerView;

- (void)enlargeRightView;
- (void)tradeStatusView;
- (void)showBottomView;
- (void)showLeftView;

- (void)showPhonePinView;
- (void)removePhonePinView;

- (void)changeState;

@end
