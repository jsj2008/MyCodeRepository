//
//  MarginCallHisViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MarginCallHisViewController.h"
#import "MarginCallHisContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface MarginCallHisViewController () {
    MarginCallHisContentView *marginCallHisContentView;
}
@end

@implementation MarginCallHisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_MARGIN subType:APP_OPT_TYPE_MARGIN];
    
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"MarginCallHis"] centerButton:nil];
    [self initMarginCallHisContentView];
}

- (void)initMarginCallHisContentView {
    marginCallHisContentView = [[MarginCallHisContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:marginCallHisContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
