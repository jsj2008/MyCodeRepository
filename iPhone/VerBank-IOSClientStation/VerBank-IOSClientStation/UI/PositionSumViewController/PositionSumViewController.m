//
//  PositionSumViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PositionSumViewController.h"
#import "PositionSumContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface PositionSumViewController(){
    PositionSumContentView *positionSumContentView;
}

@end

@implementation PositionSumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"PositionSum"] centerButton:nil];
    [self initPositionSumContentView];
}

- (void)initPositionSumContentView{
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_SUMMARY subType:APP_OPT_TYPE_SUMMARY_ITEM_1];
    positionSumContentView = [[PositionSumContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:positionSumContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [positionSumContentView removeFromSuperview];
    positionSumContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
