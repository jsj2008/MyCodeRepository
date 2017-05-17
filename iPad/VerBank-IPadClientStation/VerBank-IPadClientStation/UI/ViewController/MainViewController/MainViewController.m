//
//  MainViewController.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewLayoutCenter.h"
#import "BackgroundLayoutCenter.h"
#import "IOSVersionDefine.h"
#import "LayoutCenter.h"
#import "IOSLayoutDefine.h"
#import "CheckUtils.h"
#import "MessageView.h"
#import "TradeApi.h"

@interface MainViewController() {
    LayoutCenter *layoutCenter;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayoutCenter];
    [self addMainView];
    //    [self addTouchEvent];
    [self initScreenConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initLayoutCenter {
    layoutCenter = [LayoutCenter getInstance];
}

- (void)addMainView {
    [self.view addSubview:layoutCenter.mainViewLayoutCenter.containerView];
    [self.view addSubview:layoutCenter.backgroundLayoutCenter.mainBackgroundView];
    
    [layoutCenter.mainViewLayoutCenter.rightContentView addKChartViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
    if (![MessageView getIsAllRead]) {
        [[[layoutCenter mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_Message];
    }
    [[[layoutCenter mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OpenPosition];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)initScreenConfig {
    if (IOS7_OR_LATER) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)dealloc {
    [layoutCenter destroy];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"UIViewController will rotate to Orientation: %ld", (long)toInterfaceOrientation);
    //    [layoutCenter.mainViewLayoutCenter.containerView setFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    //    [[layoutCenter mainViewLayoutCenter] changeState];
    //    IOSLayoutDefine_h.isRotation = true;
//    [IosScreen setIsInRotation:true];
//    [layoutCenter updateLayout];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"did rotated to new Orientation, view Information %@", self.view);
    //    [layoutCenter.mainViewLayoutCenter.containerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    [[layoutCenter mainViewLayoutCenter] changeState];
    //    [layoutCenter updateLayout];
    //    IOSLayoutDefine_h.isRotation = false;
    //    [layoutCenter updateLayout];
//    [IosScreen setIsInRotation:false];
//    [layoutCenter updateLayoutAfterRotation];
}

@end
