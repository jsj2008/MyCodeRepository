//
//  HedgingViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HedgingViewController.h"
#import "HedgingContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"

@interface HedgingViewController(){
    HedgingContentView *hedgingContentView;
}

@end

@implementation HedgingViewController

+ (void)setInstrumentName:(NSString *)instrument{
    _instrumentName = instrument;
}

+ (NSString *)getInstrumentName{
    return _instrumentName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"Hedging"] centerButton:nil];
    [self initHedgingContentView];
}

- (void)initHedgingContentView{
    hedgingContentView = [[HedgingContentView alloc] initWithFrame:ContentRect instrument:_instrumentName];
    [self.centerContentView addSubview:hedgingContentView];
}

- (void)dealloc {
    [hedgingContentView removeFromSuperview];
    hedgingContentView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
