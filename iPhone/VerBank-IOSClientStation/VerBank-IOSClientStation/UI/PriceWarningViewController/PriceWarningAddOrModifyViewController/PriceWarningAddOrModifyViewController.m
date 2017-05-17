//
//  PriceWarningAddOrModifyViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PriceWarningAddOrModifyViewController.h"
#import "PriceWarningAddOrModifyContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "DataCenter.h"

@interface PriceWarningAddOrModifyViewController () {
    PriceWarningAddOrModifyContentView *priceWarningAddOrModifyContentView;
}

@end

@implementation PriceWarningAddOrModifyViewController


//- (id)initWithPriceWarning:(PriceWarning *)priceWarning instrument:(NSString *)instrument {
//    if (self = [super init]) {
//        [self setAddOrModifyTitle:priceWarning];
//        [priceWarningAddOrModifyContentView setPriceWarning:priceWarning];
//        [priceWarningAddOrModifyContentView setInstrument:instrument];
//        [priceWarningAddOrModifyContentView refreshUI];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddOrModifyTitle];
    [self initPriceWarningAddOrModifyContentView];
}

- (void)setAddOrModifyTitle {
    if ([[DataCenter getInstance] priceWarning] == nil) {
        [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"AddPriceWarning"] centerButton:nil];
    } else {
        [self setStateBarTitle:[[LangCaptain getInstance] getLangByCode:@"ModifyPriceWarning"] centerButton:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [priceWarningAddOrModifyContentView addListener];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [priceWarningAddOrModifyContentView removeListener];
}

- (void)initPriceWarningAddOrModifyContentView {
//    priceWarningAddOrModifyContentView = [[PriceWarningAddOrModifyContentView alloc] initWithFrame:ContentRect];

    priceWarningAddOrModifyContentView = [PriceWarningAddOrModifyContentView newInstance];
    [self.centerContentView addSubview:priceWarningAddOrModifyContentView];
}

//- (void)viewWillLayoutSubviews {
//    
//    // floatStatusBar
////    CGRect floatPLStatusFrame = priceWarningAddOrModifyContentView.floatPLStatus.frame;
////    floatPLStatusFrame.size.height = FloatPLStatusHeight;
////    [priceWarningAddOrModifyContentView.floatPLStatus setFrame:floatPLStatusFrame];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [priceWarningAddOrModifyContentView removeFromSuperview];
    priceWarningAddOrModifyContentView = nil;
    [[DataCenter getInstance] setPriceWarningInstrument:nil];
    [[DataCenter getInstance] setPriceWarning:nil];
}

#pragma support

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
