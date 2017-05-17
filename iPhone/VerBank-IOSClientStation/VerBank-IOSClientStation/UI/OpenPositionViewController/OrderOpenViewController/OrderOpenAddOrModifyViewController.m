//
//  OrderOpenViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderOpenAddOrModifyViewController.h"
#import "OrderOpenAddOrModifyContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "DataCenter.h"
#import "KChartView.h"

@interface OrderOpenAddOrModifyViewController () {
    OrderOpenAddOrModifyContentView *orderOpenAddOrModifyContentView;
}

@end

@implementation OrderOpenAddOrModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[DataCenter getInstance] trade] getCorOrderID] == 0) {
        [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OrderTrade"] centerButton:nil];
    } else {
        [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OrderModify"] centerButton:nil];
    }
    
    [self initOrderOpenAddOrModifyContentView];
}

- (void)viewDidAppear:(BOOL)animated {
//    [orderOpenAddOrModifyContentView addKChartView];
    [super viewDidAppear:animated];
    [orderOpenAddOrModifyContentView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[KChartView getInstance] removeFromSuperview];
    [[KChartView getInstance] reset];
//    [KChartView getInstance];
    [orderOpenAddOrModifyContentView removeListener];
}

- (void)initOrderOpenAddOrModifyContentView{
    orderOpenAddOrModifyContentView = [OrderOpenAddOrModifyContentView newInstance];
    [orderOpenAddOrModifyContentView setFrame:ContentRect];
    [self.centerContentView addSubview:orderOpenAddOrModifyContentView];
}

- (void)dealloc{
    [orderOpenAddOrModifyContentView removeFromSuperview];
    orderOpenAddOrModifyContentView = nil;
    
    [[DataCenter getInstance] setTrade:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate{
//    if ([self.view viewWithTag:KChartViewTag] != nil) {
//        return YES;
//    }
    return NO;
}

//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [[KChartView getInstance] popKChartViewWithAnimation:false];
//}

@end
