//
//  MarketTradeViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MarketTradeViewController.h"
#import "MarketTradeContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "KChartView.h"

static NSString *_instrumentName;
static int _isbuySell;

@interface MarketTradeViewController (){
    MarketTradeContentView *marketTradeContentView;
}
@end

@implementation MarketTradeViewController

// 这个可以改
+ (void)setInstrumentName:(NSString *)instrument{
    _instrumentName = instrument;
}

+ (void)setBuySell:(int)buySell {
    _isbuySell = buySell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"MarketTrade"] centerButton:nil];
    [self initMarketTradeContentView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [marketTradeContentView addKChartView];
    [marketTradeContentView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[KChartView getInstance] reset];
    [marketTradeContentView removeListener];
}

- (void)initMarketTradeContentView{
    marketTradeContentView = [[MarketTradeContentView alloc] initWithFrame:ContentRect instrument:_instrumentName buySell:_isbuySell];
    [self.centerContentView addSubview:marketTradeContentView];
}

- (void)dealloc {
    [marketTradeContentView removeFromSuperview];
    marketTradeContentView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma support
//
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
    [marketTradeContentView rotate];
    [[KChartView getInstance] popKChartViewWithAnimation:false];
}

@end
