//
//  ClosePositionViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ClosePositionViewController.h"
#import "LangCaptain.h"
#import "ClosePositionContentView.h"
#import "IosLogic.h"
#import "IosLayoutDefine.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface ClosePositionViewController (){
    ClosePositionContentView *closePositionContentView;
}
@end

@implementation ClosePositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"ClosePositionHis"] centerButton:nil];
    [self initClosePositionContentView];
}

- (void)initClosePositionContentView{
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_CLOSEHIS subType:APP_OPT_TYPE_CLOSEHIS_ITEM_1];
    closePositionContentView = [[ClosePositionContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:closePositionContentView];
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [closePositionContentView removeFromSuperview];
    closePositionContentView = nil;
}

@end
