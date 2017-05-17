//
//  ClosePositionContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ClosePositionContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "SelectSliderView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "ClosePositionDetails.h"
#import "ClosePositionCellView.h"
#import "ClosePositionPopCellView.h"
#import "APIDoc.h"
#import "DecimalUtil.h"
#import "ShowAlert.h"

#import "RefreshHeadView.h"
#import "CustomTranslate.h"

#define SliderNumber 4
#define SUMViewHeigh 40

#define ClosePositionCellHeigh 65
#define ClosePositionPopCellHeigh 30

static NSString *popCellKey = @"PopCellKey";

@interface ClosePositionContentView()<UITableViewDataSource, UITableViewDelegate, SelectSlideEvent>{
    FloatPLStatus *floatPLStatus;
    SelectSliderView *selectSliderView;
    
    UILabel *sumValueLabel;
    RefreshHeadView *refreshHeadView;
}

@property (nonatomic, weak) RefreshHeadView *refreshHeader;

@end

@implementation ClosePositionContentView

#pragma init

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        [self getClosePositionHisArray:DefaultWeek];
        [self slideSelectChanged:DefaultIndex];
        
        [self initFloatPLStatusBar];
        [self initSelectSliderViewWithNumber:SliderNumber];
        
        [self initSumViewBar];
        [self initClosePositionHisTableView];
        selectCellIndex = _kDefaultSelectedCell;
        [self setupHeader];
    }
    return self;
}

- (void)setupHeader {
    refreshHeadView = [RefreshHeadView newInstance];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeadView addToScrollView:contentTableView];
    [refreshHeadView addTarget:self refreshAction:@selector(refreshTableView)];
}

- (void)refreshTableView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getClosePositionHisArray:[selectSliderView getCurrentIndex] + 1];
        [contentTableView reloadData];
        [refreshHeadView endRefreshing];
    });
}

- (void)initFloatPLStatusBar{
    floatPLStatus = [[FloatPLStatus alloc] init];
    [floatPLStatus setFrame:CGRectMake(0.0f,
                                       0.0f,
                                       SCREEN_WIDTH,
                                       FloatPLStatusHeight)];
    [self addSubview:floatPLStatus];
}

- (void)initSelectSliderViewWithNumber:(int)number{
    NSMutableArray *selectArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < number; i++) {
        [selectArray addObject:[NSString stringWithFormat:@"%d%@", i + 1, [[LangCaptain getInstance] getLangByCode:@"Week"]]];
    }
    selectSliderView = [[SelectSliderView alloc] initWithPointArray:selectArray frame:CGRectMake(0.0f,
                                                                                                 FloatPLStatusHeight,
                                                                                                 SCREEN_WIDTH,
                                                                                                 SliderBarHeight)];
    [selectSliderView setDelegate:self];
    [self addSubview:selectSliderView];
}

- (void)initSumViewBar{
    UIView *sumBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - SUMViewHeigh, SCREEN_WIDTH, SUMViewHeigh)];
    UIView *sumView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 1.5f, SCREEN_WIDTH, SUMViewHeigh - 3.0f)];
    [sumBackgroundView setBackgroundColor:[UIColor whiteColor]];
    [sumView setBackgroundColor:[UIColor backgroundColor]];
    UILabel *sumLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0, SCREEN_WIDTH / 2, SUMViewHeigh)];
    [sumLable setText:[[LangCaptain getInstance] getLangByCode:@"SUM"]];
    [sumLable setTextColor:[UIColor whiteColor]];
    [sumLable setFont:[UIFont systemFontOfSize:25.0f]];
    sumValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2 - 10.0f, SUMViewHeigh)];
    [sumValueLabel setFont:[UIFont systemFontOfSize:25.0f]];
    [self updateSum];
    
    [self addSubview:sumBackgroundView];
    [sumBackgroundView addSubview:sumView];
    [sumView addSubview:sumLable];
    [sumView addSubview:sumValueLabel];
    
    [sumLable setTextAlignment:NSTextAlignmentLeft];
    [sumValueLabel setTextAlignment:NSTextAlignmentRight];
}

- (void)updateSum{
    double sum = 0.0f;
    //    for (ClosePositionDetails *trade in self.contentArray) {
    for (int i = 0; i < [self.contentArray count]; i++) {
        ClosePositionDetails*trade = [self.contentArray objectAtIndex:i];
        if ([trade isKindOfClass:[ClosePositionDetails class]]) {
            sum += [trade getProfitLoss];
        }
    }
    
    NSString *sumString = [DecimalUtil formatMoney:sum digist:2];
    if (sum > 0.0001) {
        sumString = [NSString stringWithFormat:@"+%@", sumString];
        [sumValueLabel setTextColor:[UIColor blueUpColor]];
    } else if(sum < 0.0001 && sum > -0.0001){
        [sumValueLabel setTextColor:[UIColor whiteColor]];
    } else {
        [sumValueLabel setTextColor:[UIColor redDownColor]];
    }
    [sumValueLabel setText:sumString];
}

- (void)initClosePositionHisTableView {
    //    contentTableView = [[UITableView alloc] init];
    
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight + SliderBarHeight;
    tableViewRect.size.height -= FloatPLStatusHeight + SliderBarHeight + SUMViewHeigh;
    
    //    contentTableView = [[UITableView alloc] initWithFrame:tableViewRect];
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    contentTableView.bounces = YES;
    //        contentTableView.showsVerticalScrollIndicator = YES;
    //    contentTableView.bounces = NO;
    //    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    contentTableView.backgroundColor = [UIColor backgroundColor];
    //    contentTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:contentTableView];
    
    // 添加长按手势
    [super addOnePressGesture];
    //    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    //    longPressGr.minimumPressDuration = 1.0;
    //    [contentTableView addGestureRecognizer:longPressGr];
}

#pragma getData
- (void)getClosePositionHisArray:(int)beforWeeks{
    NSDate *endDate = [CustomTranslate endDayOfDate];
    long long accountID = [[ClientAPI getInstance] getAccount];
    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:beforWeeks * WeekSecInterval * -1];
    
    NSMutableArray *tempArray  = [[[TradeApi getInstance] report_ClosedPositionsDetails_Account:beginDate
                                                                                        endTime:endDate
                                                                                        account:accountID] reportList];
    [self sortDESCStringArray:tempArray];
    self.contentArray = tempArray;
}

#pragma tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ClosePositionDetails *trade = [self.contentArray objectAtIndex:[indexPath row]];
    
    CGRect cellRect = cell.frame;
    cellRect.size.width = SCREEN_WIDTH;
    ClosePositionCellView *cellView = [[ClosePositionCellView alloc] initWithFrame:cellRect];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]];
    int digist = [inst getDigits];
    
    NSString *ticket = [NSString stringWithFormat:@"%@ %lld(%d)",[[LangCaptain getInstance] getLangByCode:@"Ticket"], [trade getTicket], [trade getSplitno]];
    NSString *closeTime = [JEDIDateTime stringUIFromDate:[trade getCloseTime]];
    NSString *amount = [DecimalUtil formatNumber:[trade getAmount]];
    NSString *buyOrSell = [trade getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Sell"] : [[LangCaptain getInstance] getLangByCode:@"Buy"];
    NSString *closePrice = [DecimalUtil formatMoney:[trade getClosePrice] digist:digist];
    
    [cellView.ticketLabel setText:ticket];
    [cellView.tradeTimeLabel setText:closeTime];
    [cellView.instrumentLabel setText:[trade getInstrument]];
    [cellView.amountLabel setText:amount];
    [cellView.buyOrSellLabel setText:buyOrSell];
    [cellView.closePriceLabel setText:closePrice];
    
    NSString *floatPL = [DecimalUtil formatMoney:[trade getProfitLoss] digist:2];
    if ([trade getProfitLoss] > 0.0001) {
        floatPL = [NSString stringWithFormat:@"+%@", floatPL];
        [cellView.floatPLLabel setText:floatPL];
        [cellView.floatPLLabel setTextColor:[UIColor blueUpColor]];
    } else if([trade getProfitLoss] < 0.0001 && [trade getProfitLoss] > -0.0001){
        [cellView.floatPLLabel setText:floatPL];
        [cellView.floatPLLabel setTextColor:[UIColor whiteColor]];
    } else {
        [cellView.floatPLLabel setText:floatPL];
        [cellView.floatPLLabel setTextColor:[UIColor redDownColor]];
    }
    
    //    [cellView setTag:ClosePositionCellViewTag];
    [cell addSubview:cellView];
    
    CGRect popCellRect = CGRectMake(0, ClosePositionCellHeigh, SCREEN_WIDTH, ClosePositionPopCellHeigh);
    ClosePositionPopCellView *popCellView = [[ClosePositionPopCellView alloc] initWithFrame:popCellRect];
    // 应该是开仓时间
    [popCellView.closeTime setText:[JEDIDateTime stringUIFromDate:[trade getOpenTime]]];
    [popCellView.openPriceName setText:[[LangCaptain getInstance] getLangByCode:@"OpenPrice"]];
    [popCellView.openPriceValueName setText:[DecimalUtil formatMoney:[trade getOpenPrice] digist:digist]];
    [cell addSubview:popCellView];
    
    if (selectCellIndex == [indexPath row]) {
        [popCellView setHidden:false];
        [cellView setIsNeedBottomLine:false];
        if ([indexPath row] == [self.contentArray count] - 1) {
            [popCellView setIsNeedBottomLine:true];
        }
    } else {
        [popCellView setHidden:true];
        if ([indexPath row] == [self.contentArray count] - 1) {
            [cellView setIsNeedBottomLine:true];
        }
    }
    
    [cell setBackgroundColor:[UIColor backgroundColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == selectCellIndex) {
        return ClosePositionPopCellHeigh + ClosePositionCellHeigh;
    }
    return ClosePositionCellHeigh;
}

#pragma select delegate
- (void)slideSelectChanged:(int)index{
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsQuery"] onView:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getClosePositionHisArray:index + 1];
        selectCellIndex = _kDefaultSelectedCell;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            [self updateSum];
            [contentTableView reloadData];
        });
    });
}

#pragma listener
- (void)removeFromSuperview{
    [super removeFromSuperview];
    [floatPLStatus removeFromSuperview];
    floatPLStatus = nil;
    
    [selectSliderView setDelegate:nil];
    selectSliderView = nil;
}

- (void)dealloc{
    
}

// sortUtil
- (void)sortDESCStringArray:(NSMutableArray *)array {
    if (array == nil || [array count] == 0) {
        return;
    }
    
    if (![[array objectAtIndex:0] isKindOfClass:[ClosePositionDetails class]]) {
        return;
    }
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        ClosePositionDetails *close1 = (ClosePositionDetails *)obj1;
        ClosePositionDetails *close2 = (ClosePositionDetails *)obj2;
        return [[close2 getCloseTime] compare:[close1 getCloseTime]];
    }];
}

@end
