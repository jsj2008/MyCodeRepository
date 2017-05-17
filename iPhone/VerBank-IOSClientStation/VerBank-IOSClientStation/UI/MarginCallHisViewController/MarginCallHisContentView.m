//
//  MarginCallHisContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MarginCallHisContentView.h"
#import "FloatPLStatus.h"
#import "SelectSliderView.h"
#import "RefreshHeadView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "MarginCallHisCellView.h"
#import "AccountStreamDetails.h"
#import "ShowAlert.h"
#import "DecimalUtil.h"
#import "TranslateUtil.h"
#import "AccountUtil.h"
#import "UIColor+CustomColor.h"
#import "UIView+FreezeTableView.h"
#import "CustomFont.h"

#import "APIDoc.h"

#import "CustomTranslate.h"

#define MarginCallHisHeigh 65

#define SliderNumber 4

@interface MarginCallHisContentView()<UITableViewDataSource, UITableViewDelegate, SelectSlideEvent>{
    FloatPLStatus *floatPLStatus;
    SelectSliderView *selectSliderView;
    RefreshHeadView *refreshHeadView;
}

@end

@implementation MarginCallHisContentView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self slideSelectChanged:DefaultIndex];
        [self initFloatPLStatusBar];
        [self initSelectSliderViewWithNumber:SliderNumber];
        [self initMarginCallHisTableView];
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
        [self getMarginCallHisArray:[selectSliderView getCurrentIndex] + 1];
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

- (void)initMarginCallHisTableView{
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight + SliderBarHeight;
    tableViewRect.size.height -= FloatPLStatusHeight + SliderBarHeight;
    
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    contentTableView.bounces = YES;
    [self addSubview:contentTableView];
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

#pragma getData
- (void)getMarginCallHisArray:(int)beforWeeks{
    NSDate *endDate = [CustomTranslate endDayOfDate];
    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:beforWeeks * WeekSecInterval * -1];
    
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
    NSMutableArray *tempArray = [result reportList];
    [self sortDESCStringArray:tempArray];
    self.contentArray = tempArray;
}

#pragma tableView delegate

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
    
    MarginCallHisCellView *cellView = [MarginCallHisCellView newInstance];
    //    CGRect cellViewFrame = cell.frame;
    //    cellViewFrame.size.height = OrderHisHeigh;
    CGRect cellViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, MarginCallHisHeigh);
    [cellView setFrame:cellViewFrame];
    
    AccountStreamDetails *marginCallHis = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cellView.amount setText:[DecimalUtil formatMoney:[marginCallHis getAmount] digist:2]];
    [cellView.time setText:[JEDIDateTime stringUIFromyMd:[marginCallHis getValueTime]]];
    NSString *typeString = [TranslateUtil translateAccStreamType:[marginCallHis getType]
                                                      adjustType:[marginCallHis getAdjustType]];
    NSString *ccyString = nil;
    if ([marginCallHis getInstrument] != nil) {
        ccyString = [self splitCCY:[marginCallHis getType]
                        instrument:[marginCallHis getInstrument]
                           comment:[marginCallHis getComments]];
        [cellView.account setText:[NSString stringWithFormat:@"%lld(%d) %@", [marginCallHis getTicket], [marginCallHis getSplitno], ccyString]];
    } else {
        ccyString = [NSString stringWithFormat:@"%@  %@", [AccountUtil getAccountID], [marginCallHis getCurrencyName]];
        [cellView.account setText:ccyString];
    }
    
    //    [cellView.type setText:[NSString stringWithFormat:@"%@ [%lld(%d) %@]", typeString, [marginCallHis getTicket], [marginCallHis getSplitno], ccyString]];
    //    [cellView.account setText:[NSString stringWithFormat:@"%@ %@",[AccountUtil getAccountID], [marginCallHis getCurrencyName]]];
    
    [cellView.type setText:typeString];
    
    [cellView.amount setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [cellView.type setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [cellView.account setFont:[CustomFont getCNNormalWithSize:14.0f]];
    [cellView.time setFont:[CustomFont getCNNormalWithSize:14.0f]];
    
    if ([marginCallHis getAmount] > 0.00001) {
        [cellView.amount setTextColor:[UIColor blueUpColor]];
    } else if ([marginCallHis getAmount] < -0.00001) {
        [cellView.amount setTextColor:[UIColor redDownColor]];
    } else {
        [cellView.amount setTextColor:[UIColor whiteColor]];
    }
    
    [cellView setBackgroundColor:[UIColor blackColor]];
    
    
    //    [cellView.type setText:<#(NSString * _Nullable)#>];
    //    [cellView.amount setText:[marginCallHis]];
    //    [cellView addHeaderTopLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    //    [cellView addTopLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    [cell addSubview:cellView];
    [cell setBackgroundColor:[UIColor redColor]];
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

#pragma select delegate
- (void)slideSelectChanged:(int)index{
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsQuery"] onView:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getMarginCallHisArray:index + 1];
        selectCellIndex = _kDefaultSelectedCell;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            //            [self updateSum];
            [contentTableView reloadData];
        });
    });
}


- (void)removeFromSuperview{
    [super removeFromSuperview];
    //    [self removeListener];
    
    [floatPLStatus removeFromSuperview];
    floatPLStatus = nil;
}


// sortUtil
- (void)sortDESCStringArray:(NSMutableArray *)array {
    if (array == nil || [array count] == 0) {
        return;
    }
    
    if (![[array objectAtIndex:0] isKindOfClass:[AccountStreamDetails class]]) {
        return;
    }
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        AccountStreamDetails *his1 = (AccountStreamDetails *)obj1;
        AccountStreamDetails *his2 = (AccountStreamDetails *)obj2;
        return [[his2 getValueTime] compare:[his1 getValueTime]];
    }];
}

@end
