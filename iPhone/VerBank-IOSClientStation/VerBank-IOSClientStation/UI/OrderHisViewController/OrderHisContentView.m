//
//  OrderHisContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderHisContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "SelectSliderView.h"
#import "ShowAlert.h"
#import "LangCaptain.h"
#import "ClientAPI.h"
#import "TradeApi.h"
#import "OrderHisCellView.h"
#import "MTP4CommDataInterface.h"
#import "DecimalUtil.h"
#import "OrderHisPopCellView.h"
#import "APIDoc.h"
#import "Instrument.h"
#import "TranslateUtil.h"
#import "RefreshHeadView.h"
#import "CustomFont.h"
#import "CustomTranslate.h"

#define OrderHisHeigh 85
#define OrderHisPopHeigh 70

#define SliderNumber 4

@interface OrderHisContentView()<UITableViewDataSource, UITableViewDelegate, SelectSlideEvent>{
    FloatPLStatus *floatPLStatus;
    SelectSliderView *selectSliderView;
    RefreshHeadView *refreshHeadView;
}

@end

@implementation OrderHisContentView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self slideSelectChanged:DefaultIndex];
        [self initFloatPLStatusBar];
        [self initSelectSliderViewWithNumber:SliderNumber];
        [self initOrderHisTableView];
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
        [self getOrderHisArray:[selectSliderView getCurrentIndex] + 1];
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

- (void)initOrderHisTableView{
    
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight + SliderBarHeight;
    tableViewRect.size.height -= FloatPLStatusHeight + SliderBarHeight;
    
//    contentTableView = [[UITableView alloc] initWithFrame:tableViewRect];
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    contentTableView.bounces = YES;
//    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    contentTableView.backgroundColor = [UIColor backgroundColor];
//    contentTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:contentTableView];
    
    // 添加长按手势
    [super addOnePressGesture];
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
- (void)getOrderHisArray:(int)beforWeeks{
    NSDate *endDate = [CustomTranslate endDayOfDate];
    long long accountID = [[ClientAPI getInstance] getAccount];
    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:beforWeeks * WeekSecInterval * -1];
    NSMutableArray *tempArray = [[[TradeApi getInstance] report_TOrderHisDetails_Account:beginDate
                                                                    endTime:endDate
                                                                    account:accountID] reportList];
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
    
    OrderHisCellView *cellView = [OrderHisCellView newInstance];
//    CGRect cellViewFrame = cell.frame;
//    cellViewFrame.size.height = OrderHisHeigh;
    CGRect cellViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, OrderHisHeigh);
    [cellView setFrame:cellViewFrame];
    
    TOrderHis *orderHis = [self.contentArray objectAtIndex:[indexPath row]];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[orderHis getInstrument]];
    int digist = [inst getDigits];
    
    NSString *ticket = [NSString stringWithFormat:@"%@  %lld(%d)",[[LangCaptain getInstance] getLangByCode:@"Ticket"], [orderHis getOrderID], [orderHis getOsplitNo]];
    NSString *orderTime = [JEDIDateTime stringHHmmFromDate:[orderHis getcloseTime]];
//    NSString *closeType = [[LangCaptain getInstance] getOrderHisCloseReason:[orderHis getcloseReason]];
    NSString *closeType = [TranslateUtil translateCloseType:[orderHis getcloseType] reason:[orderHis getcloseReason]];
    NSString *did = [[LangCaptain getInstance] getLangByCode:@"TurnOver"];
    NSString *closePrice = [orderHis getclosePrice] > 0.000001 ? [NSString stringWithFormat:@"%@ %@", did, [DecimalUtil formatMoney:[orderHis getclosePrice] digist:digist]] : @"";
    NSString *correspondingString = @"";
    NSString *correspondingNumberString = @"";
    if ([orderHis getCorrespondingTicket] != 0) {
        correspondingString = [[LangCaptain getInstance] getLangByCode:@"CorrespondingTicket"];
        correspondingNumberString = [NSString stringWithFormat:@"%lld", [orderHis getCorrespondingTicket]];
    }
    NSString *correspondingTicket = [NSString stringWithFormat:@"%@    %@", correspondingString, correspondingNumberString];
    NSString *instrument = [orderHis getInstrument];
    NSString *buySell = [orderHis getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"];
    NSString *tradeAmount = [DecimalUtil formatNumber:[orderHis getAmount]];
    
    [cellView.ticketLabel       setText:ticket];
    [cellView.orderTimeLabel    setText:orderTime];
    [cellView.closeTypeLabel    setText:[NSString stringWithFormat:@"%@%@", closeType, closePrice]];
//    [cellView.closePriceLabel setText:closePrice];
    [cellView.designTicketLabel setText:correspondingTicket];
    [cellView.instrumentLabel   setText:instrument];
    [cellView.tradeDirLabel     setText:buySell];
    [cellView.tradeDirLabel     setTextColor:[UIColor buySellLabelColor]];
    [cellView.tradeAmountLabel  setText:tradeAmount];
    
    [cellView.ticketLabel       setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.orderTimeLabel    setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.closeTypeLabel    setFont:[CustomFont getCNNormalWithSize:16.0f]];
    [cellView.designTicketLabel setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.instrumentLabel   setFont:[CustomFont getCNNormalWithSize:15.0f]];
    [cellView.tradeDirLabel     setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [cellView.tradeAmountLabel  setFont:[CustomFont getCNNormalWithSize:18.0f]];
    
    OrderHisPopCellView *popCellView = [OrderHisPopCellView newInstance];

    CGRect popCellViewRect = CGRectMake(0, OrderHisHeigh - 2.0f, SCREEN_WIDTH, OrderHisPopHeigh + 2.0f);
    [popCellView setFrame:popCellViewRect];

    NSString *limitPriceValue = [orderHis getLimitPrice] > 0.000001 ? [DecimalUtil formatMoney:[orderHis getLimitPrice] digist:digist] : @"";
    NSString *stopPriceValue = [orderHis getCurrentStopPrice] > 0.000001 ? [DecimalUtil formatMoney:[orderHis getCurrentStopPrice] digist:digist] : @"";
    Boolean showOCO = [orderHis getLimitPrice] > 0.000001 && [orderHis getCurrentStopPrice] > 0.000001;
    NSString *stopMovePriceValue = [orderHis getStopMoveGap] > 0 ? [@([orderHis getStopMoveGap]) stringValue] : @"";
    NSString *IDTLimitValue = [orderHis getIFDLimitPrice] > 0.000001 ? [DecimalUtil formatMoney:[orderHis getIFDLimitPrice] digist:digist] : @"";
    NSString *IDTStopValue = [orderHis getIFDStopPrice] > 0.000001 ? [DecimalUtil formatMoney:[orderHis getIFDStopPrice] digist:digist] : @"";
    NSString *timeType = [[LangCaptain getInstance] getExpireType:[orderHis getExpireType]];
    NSString *timeString = @"";
    if ([orderHis getExpireType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        timeString = [JEDIDateTime stringUIFromDate:[orderHis getExpiryTime]];
    }
    
    [popCellView.limitPriceNameLabel        setText:[[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    [popCellView.stopPriceNameLabel         setText:[[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    [popCellView.moveStopNameLabel          setText:[[LangCaptain getInstance] getLangByCode:@"StopMovePrice"]];
    [popCellView.timeNameLabel              setText:[[LangCaptain getInstance] getLangByCode:@"ValidDate"]];
    [popCellView.limitPriceValueLabel       setText:limitPriceValue];
    [popCellView.stopPriceValueLabel        setText:stopPriceValue];
    [popCellView.ocoLabel                   setHidden:!showOCO];
    [popCellView.moveStopValueLabel         setText:stopMovePriceValue];
    [popCellView.IDTLimitValueLabel         setText:IDTLimitValue];
    [popCellView.IDTStopValueLabel          setText:IDTStopValue];
    [popCellView.timeTypeLabel              setText:[NSString stringWithFormat:@"%@   %@", timeType, timeString]];
    
    [popCellView.limitPriceNameLabel        setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.stopPriceNameLabel         setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.moveStopNameLabel          setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.timeNameLabel              setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.limitPriceValueLabel       setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.stopPriceValueLabel        setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.ocoLabel                   setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.moveStopValueLabel         setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.IDTLimitValueLabel         setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.IDTStopValueLabel          setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.timeTypeLabel              setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.IDTLimitNameLabel          setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [popCellView.IDTStopNameLabel           setFont:[CustomFont getCNNormalWithSize:10.0f]];

    
    [cellView setBackgroundColor:[UIColor backgroundColor]];
    [popCellView setBackgroundColor:[UIColor closePositionPopCellColor]];
    [cell addSubview:cellView];
    [cell addSubview:popCellView];
    
    if (selectCellIndex == [indexPath row]) {
        [popCellView setHidden:false];
    } else {
        [popCellView setHidden:true];
    }
    
    [cell setBackgroundColor:[UIColor backgroundColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectCellIndex == [indexPath row]) {
        return OrderHisPopHeigh + OrderHisHeigh;
    }
    return OrderHisHeigh;
}

#pragma select delegate
- (void)slideSelectChanged:(int)index{
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsQuery"] onView:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getOrderHisArray:index + 1];
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
    
    if (![[array objectAtIndex:0] isKindOfClass:[TOrderHis class]]) {
        return;
    }
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        TOrderHis *his1 = (TOrderHis *)obj1;
        TOrderHis *his2 = (TOrderHis *)obj2;
        return [[his2 getcloseTime] compare:[his1 getcloseTime]];
    }];
}



@end
