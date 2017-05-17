//
//  PriceViewContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PriceWarningContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "TradeApi.h"
#import "UIColor+CustomColor.h"
#import "PriceWarningCellView.h"
#import "MTP4CommDataInterface.h"
#import "LangCaptain.h"
#import "DecimalUtil.h"
#import "APIDoc.h"
#import "PriceWarningPopCellView.h"
#import "ShowAlert.h"
#import "IosLogic.h"
#import "DataCenter.h"
#import "RefreshHeadView.h"
#import "CustomFont.h"

#define PriceWarningCellHeigh 55
#define PriceWarningPopCellHeigh 30

@interface PriceWarningContentView()<UITableViewDataSource, UITableViewDelegate>{
    FloatPLStatus *floatPLStatus;
    RefreshHeadView *refreshHeadView;
}

@end

@implementation PriceWarningContentView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initFloatPLStatusBar];
        [self initPriceWarningTableView];
        selectCellIndex = _kDefaultSelectedCell;
        [self initData];
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
        //        [self getOrderHisArray:[selectSliderView getCurrentIndex] + 1];
        [self initData];
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

- (void)initData {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [[DataCenter getInstance] queryPriceWarning];
    NSArray* priceWarningArray = [[DataCenter getInstance] priceWarningArray];
    for (PriceWarning *pw in priceWarningArray) {
        if (![pw getIsPriceReach]) {
            [tempArray addObject:pw];
        }
    }
    self.contentArray = tempArray;
    //    contentArray = [[NSMutableArray alloc] initWithArray:[[DataCenter getInstance] priceWarningArray]];
}

- (void)initPriceWarningTableView{
    
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight;
    tableViewRect.size.height -= FloatPLStatusHeight;
    
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
    
    [super addOnePressGesture];
}


#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    //    TTrade *trade = [contentArray objectAtIndex:[indexPath row]];
    PriceWarning *priceWarning = [self.contentArray objectAtIndex:[indexPath row]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[priceWarning getInstrument]];
    int digist = [inst getDigits];
    
    PriceWarningCellView *cellView = [PriceWarningCellView newInstance];
    CGRect cellViewFrame = cell.frame;
    cellViewFrame.size.height = PriceWarningCellHeigh;
    cellViewFrame.size.width = SCREEN_WIDTH;
    [cellView setFrame:cellViewFrame];
    
    //    [self updateCellView:cellView instrument:instrument];
    
    [cellView.instrumentLabel   setText:[priceWarning  getInstrument]];
    [cellView.buySellLabel      setText:[self translatePriceType:[priceWarning getPriceType]]];
    [cellView.buySellLabel      setTextColor:[UIColor buySellLabelColor]];
    [cellView.timeLabel         setText:[self translayeTimeType:priceWarning]];
    [cellView.warningPriceLabel setText:[DecimalUtil formatMoney:[priceWarning getPrice] digist:digist]];
    //    NSString *instr = [priceWarning getInstrument];
    
    [cellView.timeLabel         setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.instrumentLabel   setFont:[CustomFont getCNNormalWithSize:15.0f]];
    [cellView.buySellLabel      setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [cellView.warningPriceLabel setFont:[CustomFont getCNNormalWithSize:16.0f]];
    
    [cellView setBackgroundColor:[UIColor backgroundColor]];
    [cell addSubview:cellView];
    
    CGRect popCellRect = CGRectMake(0, PriceWarningCellHeigh, SCREEN_WIDTH, PriceWarningPopCellHeigh);
    PriceWarningPopCellView *popCell = [[PriceWarningPopCellView alloc] initWithFrame:popCellRect];
    [cell addSubview:popCell];
    
    if (selectCellIndex == [indexPath row]) {
        [popCell setHidden:false];
    } else {
        [popCell setHidden:true];
    }
    [popCell.modifyButton addTarget:self action:@selector(modify) forControlEvents:UIControlEventTouchUpInside];
    [popCell.deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setBackgroundColor:[UIColor backgroundColor]];
    return cell;
}

- (void)modify {
    PriceWarning *priceWarning = [self.contentArray objectAtIndex:selectCellIndex];
    [[DataCenter getInstance] setPriceWarning:priceWarning];
    [[DataCenter getInstance] setPriceWarningInstrument:[priceWarning  getInstrument]];
    [[IosLogic getInstance] gotoPriceWarningAddOrModifyViewController];
}

- (void)delete {
    PriceWarning *priceWarning = [self.contentArray objectAtIndex:selectCellIndex];
    int isReached = [priceWarning getIsPriceReach];
    NSString *guid = [priceWarning getGuid];
    if (isReached == PRICE_REACH_STATE_NORMAL) {
        [[TradeApi getInstance] deletePriceWarning:guid];
        [[DataCenter getInstance] queryPriceWarning];
        //        contentArray = [[NSMutableArray alloc] initWithArray:[[DataCenter getInstance] priceWarningArray]];
        [self initData];
        selectCellIndex = _kDefaultSelectedCell;
        [contentTableView reloadData];
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"DeleteSuccess"]];
    } else {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"DeleteFailed"]];
    }
}

- (NSString *)translayeTimeType:(PriceWarning *)priceWarning {
    switch ([priceWarning getExpiryType]) {
        case ORDER_EXPIRE_TYPE_DAY:
            return @"NYC";
            break;
        case ORDER_EXPIRE_TYPE_WEEK:
            return @"GTW";
            break;
        case ORDER_EXPIRE_TYPE_USER_DEFINED:
            return [JEDIDateTime stringUIFromDate:[priceWarning getExpiryTime]];
            break;
        case ORDER_EXPIRE_TYPE_GTC:
            return @"GTC";
            break;
        default:
            break;
    }
    return @"Unknow";
}

- (NSString *)translatePriceType:(int)priceType {
    switch (priceType) {
        case PRICETYPE_ASK:
            return [[LangCaptain getInstance] getLangByCode:@"Buy"];
            break;
        case PRICETYPE_BID:
            return [[LangCaptain getInstance] getLangByCode:@"Sell"];
            break;
        case PRIVATE_MODDLE:
            return [[LangCaptain getInstance] getLangByCode:@"Middle"];
            break;
        default:
            return @"unknow";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == selectCellIndex) {
        return PriceWarningCellHeigh + PriceWarningPopCellHeigh;
    }
    return PriceWarningCellHeigh;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
