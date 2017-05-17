//
//  OrderModifyViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderAddOrModifyViewController.h"

#import "OrderAddOrModifyContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "DataCenter.h"

#import "KChartView.h"

//static TOrder *_order;
//static NSString *_instrument;

@interface OrderAddOrModifyViewController () {
    OrderAddOrModifyContentView *orderAddOrModifyContentView;
}

@end

@implementation OrderAddOrModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[DataCenter getInstance] order] == nil) {
        [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OrderTrade"] centerButton:nil];
    } else {
        [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OrderModify"] centerButton:nil];
    }
    [self initOrderModifyContentView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [orderAddOrModifyContentView addKChartView];
    [orderAddOrModifyContentView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [orderAddOrModifyContentView removeListener];
//    [[KChartView getInstance] removeFromSuperview];
//    [[KChartView getInstance] reset];
//    [KChartView getInstance];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [orderAddOrModifyContentView removeFromSuperview];
//    orderAddOrModifyContentView = nil;
//    [[DataCenter getInstance] setOrder:nil];
//    [[DataCenter getInstance] setOrderInstrument:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initOrderModifyContentView{
//    orderModifyContentView = [[OrderModifyContentView alloc] initWithFrame:ContentRect];
    orderAddOrModifyContentView = [OrderAddOrModifyContentView newInstance];
    [self.centerContentView addSubview:orderAddOrModifyContentView];
}

- (void)dealloc{
//    [orderAddOrModifyContentView removeFromSuperview];
//    orderAddOrModifyContentView = nil;
//    [[DataCenter getInstance] setOrder:nil];
//    [[DataCenter getInstance] setOrderInstrument:nil];
    [orderAddOrModifyContentView removeFromSuperview];
    orderAddOrModifyContentView = nil;
    [[DataCenter getInstance] setOrder:nil];
    [[DataCenter getInstance] setOrderInstrument:nil];
}

#pragma support

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (BOOL)shouldAutorotate{
//    return NO;
//}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskAllButUpsideDown;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
//    if ([self.view viewWithTag:KChartViewTag] != nil) {
//        return YES;
//    }
//    return NO;
    return NO;
}

//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
////    [[KChartView getInstance] popKChartViewWithAnimation:false];
//}

@end
