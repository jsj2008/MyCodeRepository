//
//  OrderPositionViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderPositionViewController.h"
#import "OrderPositionContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "APIDoc.h"
#import "OrderAddOrModifyViewController.h"
#import "IosLogic.h"
#import "ClientSystemConfig.h"
#import "ShowAlert.h"
#import "KChartView.h"

@interface OrderPositionViewController (){
    OrderPositionContentView *orderPositionContentView;
}
@end

@implementation OrderPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *centerButton = [[UIButton alloc] init];
    [centerButton setBackgroundImage:[UIImage imageNamed:@"images/normal/addButton.png"] forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(jumpToAddOrderViewController) forControlEvents:UIControlEventTouchUpInside];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OrderPosition"] centerButton:centerButton];
    [self initOrderPositionContentView];
}

- (void)initOrderPositionContentView{
    orderPositionContentView = [[OrderPositionContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:orderPositionContentView];
}

- (void)jumpToAddOrderViewController {
    [[DataCenter getInstance] setOrder:nil];
    //    [[DataCenter getInstance] setOrderInstrument:[[[[APIDoc getSystemDocCaptain] getInstrumentArray] objectAtIndex:0] getInstrument]];
//    [[DataCenter getInstance] setOrderInstrument:[[[ClientSystemConfig getInstance] instrumentArray] objectAtIndex:0]];
    NSString *instrument = [[ClientSystemConfig getInstance] getFirstInstrument];
    if (instrument == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"DefaultInstrumentIsNull"]];
        return;
    }
    [[DataCenter getInstance] setOrderInstrument:instrument];
    [[IosLogic getInstance] gotoOrderAddOrModifyViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [orderPositionContentView removeFromSuperview];
    orderPositionContentView = nil;
    
    NSLog(@"order position dealloc ");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [orderPositionContentView scroll];
    [orderPositionContentView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [orderPositionContentView removeListener];
//    [[KChartView getInstance] removeFromSuperview];
    [[KChartView getInstance] reset];
//    [KChartView getInstance];
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
