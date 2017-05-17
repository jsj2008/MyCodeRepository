//
//  ForexNewsViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ForexNewsViewController.h"
#import "LangCaptain.h"
#import "ForexNewsContentView.h"
#import "IosLayoutDefine.h"

@interface ForexNewsViewController () {
    ForexNewsContentView *forexNewsContentView;
}
@end

@implementation ForexNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"ForexNews"] centerButton:nil];
    [self initForexContentView];
}

- (void)initForexContentView {
    forexNewsContentView = [[ForexNewsContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:forexNewsContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [forexNewsContentView removeFromSuperview];
    forexNewsContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
