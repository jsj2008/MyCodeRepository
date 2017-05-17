//
//  MarginCallHisView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MarginCallHisView.h"
#import "TimeUtil.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "MarginCallHisViewCell.h"
#import "AccountStreamDetails.h"
#import "DecimalUtil.h"
#import "TranslateUtil.h"
#import "APIDoc.h"
#import "AccountUtil.h"
#import "UIColor+CustomColor.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "UIView+AddLine.h"
#import "SortUtils.h"

const CGFloat MarginCallHisHeigh = 80.0f;

@interface MarginCallHisView()<UITableViewDataSource, UITableViewDelegate, SelectSlideEvent> {
    NSMutableArray *contentArray;
}

@end

@implementation MarginCallHisView

@synthesize contentTableView;
@synthesize selectSliderView;

- (void)initContent {
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor blackColor]];
    
    
    [selectSliderView setPointNameArray:[[NSArray alloc] initWithObjects:
                                         [NSString stringWithFormat:@"1%@", [[LangCaptain getInstance] getLangByCode:@"Week"]],
                                         [NSString stringWithFormat:@"2%@", [[LangCaptain getInstance] getLangByCode:@"Week"]],
                                         [NSString stringWithFormat:@"1%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                         [NSString stringWithFormat:@"2%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                         [NSString stringWithFormat:@"3%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                         [NSString stringWithFormat:@"4%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                         [NSString stringWithFormat:@"5%@", [[LangCaptain getInstance] getLangByCode:@"Month"]],
                                         [NSString stringWithFormat:@"6%@", [[LangCaptain getInstance] getLangByCode:@"Month"]], nil]];
    [selectSliderView setDelegate:self];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateView {
    [self initDataWithSecInterval:[selectSliderView getCurrentIndex]];
}

- (void)initDataWithSecInterval:(SecIntervalType)secIntervalType {
    NSTimeInterval secInterval = WeekSecInterval * 1;
    switch (secIntervalType) {
        case SecIntervalWeek1:
            secInterval = WeekSecInterval * 1;
            break;
        case SecIntervalWeek2:
            secInterval = WeekSecInterval * 2;
            break;
        case SecIntervalMonth1:
            secInterval = MonthSecInterval * 1;
            break;
        case SecIntervalMonth2:
            secInterval = MonthSecInterval * 2;
            break;
        case SecIntervalMonth3:
            secInterval = MonthSecInterval * 3;
            break;
        case SecIntervalMonth4:
            secInterval = MonthSecInterval * 4;
            break;
        case SecIntervalMonth5:
            secInterval = MonthSecInterval * 5;
            break;
        case SecIntervalMonth6:
            secInterval = MonthSecInterval * 6;
            break;
        default:
            break;
    }
    
    NSDate *endDate = [TimeUtil endDayOfDate];
    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:secInterval * -1];
    
    NSNumber *deposit    = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_DEPOSIT];
    NSNumber *withDraw   = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_WITHDRAW];
    NSNumber *rollover   = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_ROLLOVER];
    NSNumber *trade      = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_TRADE];
    NSNumber *adjustFixdeposit = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_ADJUST_FIXDEPOSIT];
    NSNumber *liquidation = [[NSNumber alloc] initWithInt:ACCOUNTSTREAMTYPE_LIQUIDATION];
    NSArray *array = [[NSArray alloc] initWithObjects:deposit,withDraw,rollover,trade,adjustFixdeposit,liquidation, nil];
    
    TradeResult_SimpleReport *result = [[TradeApi getInstance] report_AccountStreamDetails:beginDate
                                                                                   endDate:endDate
                                                                                   typeVec:array];
    contentArray = [result reportList];
    
    // sort
    [SortUtils sortAccountStreamDetailsArray:contentArray];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"contentMarginCallHisViewCell";
    MarginCallHisViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"MarginCallHisViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell addHeaderBottomLineWithWidth:addLineBottomHeight bgColor:[UIColor whiteColor]];
    
    AccountStreamDetails *marginCallHis = [contentArray objectAtIndex:[indexPath row]];
    //
    [cell.amountLabel   setText:[DecimalUtil formatMoney:[marginCallHis getAmount] digist:2]];
    [cell.timeLabel     setText:[JEDIDateTime stringUIFromyMd:[marginCallHis getValueTime]]];
    NSString *typeString = [TranslateUtil translateAccStreamType:[marginCallHis getType]
                                                      adjustType:[marginCallHis getAdjustType]];
    NSString *ccyString = nil;
    if ([marginCallHis getInstrument] != nil) {
        ccyString = [self splitCCY:[marginCallHis getType]
                        instrument:[marginCallHis getInstrument]
                           comment:[marginCallHis getComments]];
        [cell.accountLabel setText:[NSString stringWithFormat:@"%lld(%d) %@", [marginCallHis getTicket], [marginCallHis getSplitno], ccyString]];
    } else {
        ccyString = [NSString stringWithFormat:@"%@  %@", [AccountUtil getAccountID], [marginCallHis getCurrencyName]];
        [cell.accountLabel setText:ccyString];
    }
    
    
    [cell.typeLabel setText:typeString];
    //
    //
    if ([marginCallHis getAmount] > 0.00001) {
        [cell.amountLabel setTextColor:[UIColor blueUpColor]];
    } else if ([marginCallHis getAmount] < -0.00001) {
        [cell.amountLabel setTextColor:[UIColor redDownColor]];
    } else {
        [cell.amountLabel setTextColor:[UIColor whiteColor]];
    }
    return cell;
}

- (NSString *)splitCCY:(int)type instrument:(NSString *)instrument comment:(NSString *)comment {
    if (type == ACCOUNTSTREAMTYPE_TRADE) {
        Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:instrument];
        return inst == nil ? instrument : [inst getCcy2];
    } else if (comment != nil && [comment length] > 0) {
        NSString *key = @"CCY=";
        NSRange keyRange = [comment rangeOfString:key];
        NSString *context = [comment substringWithRange:NSMakeRange(keyRange.location + keyRange.length, 3)];
        return context;
    }
    return comment;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MarginCallHisHeigh;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma SelectSlideEvent delegate
- (void)slideSelectChanged:(int)index {
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initDataWithSecInterval:index];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [self.contentTableView reloadData];
        });
    });
}

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initDataWithSecInterval:[selectSliderView getCurrentIndex]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [self.contentTableView reloadData];
        });
    });
}

- (void)pageUnSelect {
    [super pageUnSelect];
}

- (void)pageSelect {
    [super pageSelect];
}


@end
