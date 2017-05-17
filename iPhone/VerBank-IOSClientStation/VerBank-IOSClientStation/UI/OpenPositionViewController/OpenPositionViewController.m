//
//  OpenPositionViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OpenPositionViewController.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "FloatPLStatus.h"
#import "OpenPositionContentView.h"
#import "KChartView.h"

@interface OpenPositionViewController(){
    OpenPositionContentView *openPositionContentView;
//    UIInterfaceOrientationMask mask;
}

@end

@implementation OpenPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OpenPosition"] centerButton:nil];
    
    [self initOpenPositionContentView];
//    mask = UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 初始化
//    mask = UIInterfaceOrientationMaskAllButUpsideDown;
    [openPositionContentView scroll];
    [openPositionContentView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[KChartView getInstance] removeFromSuperview];
    [[KChartView getInstance] reset];
//    [KChartView getInstance];
    [openPositionContentView removeListener];
}

- (void)initOpenPositionContentView{
    openPositionContentView = [[OpenPositionContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:openPositionContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [openPositionContentView removeFromSuperview];
    openPositionContentView = nil;

    NSLog(@"open Position view dealloc ");
}

#pragma support

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate{
    if ([self.view viewWithTag:KChartViewTag] != nil) {
        return YES;
    }
    return NO;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [[KChartView getInstance] popKChartViewWithAnimation:false];
}

@end
