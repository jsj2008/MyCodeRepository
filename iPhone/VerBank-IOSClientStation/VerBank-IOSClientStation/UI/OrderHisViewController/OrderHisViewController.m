//
//  OrderHisViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderHisViewController.h"
#import "OrderHisContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface OrderHisViewController (){
    OrderHisContentView *orderHisContentView;
}

@end

@implementation OrderHisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"OrderHis"] centerButton:nil];
    [self initOrderHisContentView];
}

- (void)initOrderHisContentView{
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDERHIS subType:APP_OPT_TYPE_ORDERHIS_ITEM_1];
    orderHisContentView = [[OrderHisContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:orderHisContentView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [orderHisContentView removeFromSuperview];
    orderHisContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
