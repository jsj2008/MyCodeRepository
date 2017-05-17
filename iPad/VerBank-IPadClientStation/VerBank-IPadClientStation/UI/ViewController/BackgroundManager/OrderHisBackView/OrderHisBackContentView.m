//
//  OrderHisBackContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderHisBackContentView.h"
#import "UIColor+CustomColor.h"
#import "ShowAlertManager.h"
#import "BackgoundContentView.h"

@interface OrderHisBackContentView()<SelectSlideEvent> {
    OrderHisTableView *tableview;
}
@end

@implementation OrderHisBackContentView

@synthesize titleLabel;
@synthesize sliderView;
@synthesize orderHisTableView;
@synthesize backButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OrderHis"]];
    [backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    
    [sliderView setDelegate:self];
    [sliderView setPointNameArray:[[NSArray alloc] initWithObjects:
                                   [NSString stringWithFormat:@"1%@", [[LangCaptain getInstance] getLangByCode:@"Week"]],
                                   [NSString stringWithFormat:@"2%@", [[LangCaptain getInstance] getLangByCode:@"Week"]],
                                   [NSString stringWithFormat:@"1%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                   [NSString stringWithFormat:@"2%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                   [NSString stringWithFormat:@"3%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                   [NSString stringWithFormat:@"4%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                   [NSString stringWithFormat:@"5%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                   [NSString stringWithFormat:@"6%@", [[LangCaptain getInstance] getLangByCode:@"Month"]], nil]];
    
    tableview = [[OrderHisTableView alloc] init];
    [self addSubview:tableview];
//    [tableview setBackgroundColor:[UIColor clearColor]];
//    [tableview.leftTableView setBackgroundColor:[UIColor blackColor]];
//    [tableview.contentTableView setBackgroundColor:[UIColor blackColor]];
    
    [backButton addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)resetContentView {
    [self slideSelectChanged:[sliderView getCurrentIndex]];
}

#pragma SelectSlideEvent delegate
- (void)slideSelectChanged:(int)index {
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [tableview initDataWithSecInterval:index];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [tableview.contentTableView reloadData];
            [tableview.leftTableView reloadData];
        });
    });
}

- (void)doCancelAction {
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [tableview setFrame:orderHisTableView.frame];
}

@end
