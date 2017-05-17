//
//  AboutViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "TradeApi.h"

@interface AboutViewController (){
    AboutContentView *aboutContentView;
}
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"About"] centerButton:nil];
    [self initAboutContentView];
}

- (void)initAboutContentView {
    aboutContentView = [AboutContentView newInstance];
    [aboutContentView setFrame:ContentRect];
    [self.centerContentView addSubview:aboutContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [aboutContentView removeFromSuperview];
    aboutContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
