//
//  MessageViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "KChartView.h"

@interface MessageViewController () {
    MessageContentView *messageContentView;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"NoticeInformation"] centerButton:nil];
    [self initNoticeInformationContentView];
    [KChartView getInstance];
}

- (void)initNoticeInformationContentView {
    messageContentView = [[MessageContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:messageContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [messageContentView removeFromSuperview];
    messageContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
