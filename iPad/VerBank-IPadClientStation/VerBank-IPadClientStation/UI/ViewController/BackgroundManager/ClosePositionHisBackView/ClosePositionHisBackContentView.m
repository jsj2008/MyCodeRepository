//
//  ClosePositionHisBackContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ClosePositionHisBackContentView.h"
#import "UIColor+CustomColor.h"
#import "ShowAlertManager.h"
#import "BackgoundContentView.h"

@interface ClosePositionHisBackContentView()<SelectSlideEvent>{
    ClosePositionTableView *tableview;
}
@end

@implementation ClosePositionHisBackContentView

@synthesize titleLabel;
@synthesize sliderView;
@synthesize closePositionTableView;
@synthesize positionSumValueLabel;
@synthesize positionSumNameLabel;
@synthesize fillLabel;
@synthesize backButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"ClosePositionHis"]];
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
    
    tableview = [[ClosePositionTableView alloc] init];
    [self addSubview:tableview];
    //    [closePositionTableView.leftTableView setBackgroundColor:[UIColor blackColor]];
    //    [closePositionTableView.contentTableView setBackgroundColor:[UIColor blackColor]];
    [closePositionTableView setBackgroundColor:[UIColor clearColor]];
    [backButton addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self.positionSumNameLabel setText:[NSString stringWithFormat:@"%@ :", [[LangCaptain getInstance] getLangByCode:@"FloatSumDoller"]]];
    [self.positionSumNameLabel setBackgroundColor:[UIColor blackColor]];
    [self.positionSumNameLabel setTextColor:[UIColor whiteColor]];
    [self.positionSumValueLabel setBackgroundColor:[UIColor blackColor]];
    [self.positionSumValueLabel setText:@"0"];
    
    [self.fillLabel setBackgroundColor:[UIColor blackColor]];
    [self.fillLabel setText:@""];
    
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
            double floatPositionSum = [tableview getFloatPositionSum];
            [positionSumValueLabel setText:[NSString stringWithFormat:@"%@     ", [DecimalUtil formatMoney:floatPositionSum digist:2]]];
            if (floatPositionSum > 0.00001) {
                [self.positionSumValueLabel setTextColor:[UIColor blueUpColor]];
            } else if(floatPositionSum < -0.00001) {
                [self.positionSumValueLabel setTextColor:[UIColor redDownColor]];
            } else {
                [self.positionSumValueLabel setTextColor:[UIColor whiteColor]];
            }
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
    [tableview setFrame:closePositionTableView.frame];
}

@end
