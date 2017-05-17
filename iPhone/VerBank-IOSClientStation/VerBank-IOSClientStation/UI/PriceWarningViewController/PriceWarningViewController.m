//
//  PriceWarningViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PriceWarningViewController.h"
#import "PriceWarningContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "IosLogic.h"
#import "APIDoc.h"
#import "ClientSystemConfig.h"
#import "ShowAlert.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface PriceWarningViewController() {
    PriceWarningContentView *priceWarningContentView;
}

@end

@implementation PriceWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *centerButton = [[UIButton alloc] init];
    [centerButton setBackgroundImage:[UIImage imageNamed:@"images/normal/addButton.png"] forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(jumpToPriceWarningAddOrViewController) forControlEvents:UIControlEventTouchUpInside];
    [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"PriceWarning"] centerButton:centerButton];
    [self initOpenPositionContentView];
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICEWARNING subType:APP_OPT_TYPE_PRICEWARNING_ITEM_1];
}

- (void)jumpToPriceWarningAddOrViewController {
//    NSString *instrument = [[[[APIDoc getSystemDocCaptain] getInstrumentArray] objectAtIndex:0] getInstrument];
    
    NSString *instrument = [[ClientSystemConfig getInstance] getFirstInstrument];
    if (instrument == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"DefaultInstrumentIsNull"]];
        return;
    }
    [[DataCenter getInstance] setOrderInstrument:instrument];
    
    [[DataCenter getInstance] setPriceWarning:nil];
    [[DataCenter getInstance] setPriceWarningInstrument:instrument];
    [[IosLogic getInstance] gotoPriceWarningAddOrModifyViewController];
}

- (void)initOpenPositionContentView{
    priceWarningContentView = [[PriceWarningContentView alloc] initWithFrame:ContentRect];
    [self.centerContentView addSubview:priceWarningContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [priceWarningContentView removeFromSuperview];
    priceWarningContentView = nil;
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
