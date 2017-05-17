//
//  SystemConfigViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SystemConfigViewController.h"
#import "LangCaptain.h"
#import "SystemConfigContentView.h"
#import "IosLayoutDefine.h"
#import "ShowAlert.h"

@interface SystemConfigViewController () {
    SystemConfigContentView *systemConfigContentView;
}

@end

@implementation SystemConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"SystemConfig"] centerButton:nil];
    [self initForexContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {
    [systemConfigContentView tableUpdate];
}

- (void)initForexContentView {
    NSLog(@"begin init content view %@", [NSDate new]);
    systemConfigContentView = [[SystemConfigContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:systemConfigContentView];
    NSLog(@"end init content view %@", [NSDate new]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [systemConfigContentView removeFromSuperview];
    systemConfigContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
