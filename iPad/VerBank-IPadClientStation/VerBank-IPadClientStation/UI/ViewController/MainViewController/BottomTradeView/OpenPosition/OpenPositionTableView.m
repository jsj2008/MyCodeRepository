//
//  OpenPositionContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenPositionTableView.h"
#import "OpenPositionTableViewContentCell.h"
#import "OpenPositionTableViewLeftCell.h"
#import "QuoteDataStore.h"

#import "ShowAlertManager.h"

#import "SortUtils.h"

#import "UIColor+CustomColor.h"
#import "CommDataUtil.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@class TOrder;

static const CGFloat leftWitdh = 350.0f;
static const CGFloat scrollViewContentWidth = 1024.0f;

@interface OpenPositionTableView() <ListenerProtocol, API_Event_QuoteDataStore> {
    AddNewOpenOrderType openOrderType;
}
@end

@implementation OpenPositionTableView

- (id)init {
    if (self = [super init]) {
        //        [self initData];
        //        [self addListener];
    }
    return self;
}

- (void)initData {
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] accountID]];
    if (groupDoc != nil) {
        TradeDoc *tradeDoc  =[groupDoc getTradeDoc];
        self.contentArray = [[tradeDoc getTTradeByAccountList:[[ClientAPI getInstance] accountID]] mutableCopy];

//        self.contentArray = [tradeDoc getTTradeByAccountList:[[ClientAPI getInstance] getAccount]];
        
        [SortUtils sortOpenPositionArray:self.contentArray];
    }
}

#pragma son Func
- (void)initContentColumNames {
    OpenPositionTableViewContentCell *cell = (OpenPositionTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.marginRateLabel       setText:[[LangCaptain getInstance] getLangByCode:@"MarginRate"]];
    [cell.limitPriceOrderLabel  setText:[[LangCaptain getInstance] getLangByCode:@"LimitPriceOrder"]];
    [cell.stopPriceOrderLabel   setText:[[LangCaptain getInstance] getLangByCode:@"StopPriceOrder"]];
    [cell.stopMovePriceLabel    setText:[[LangCaptain getInstance] getLangByCode:@"StopMovePrice"]];
    [cell.floatPLOriLabel       setText:[[LangCaptain getInstance] getLangByCode:@"FloatPL(Ori)"]];
    [cell.floatPLDollarLabel    setText:[[LangCaptain getInstance] getLangByCode:@"FloatPL(Dollar)"]];
    [cell.openTimeLabel         setText:[[LangCaptain getInstance] getLangByCode:@"OpenTime"]];
    [cell.ticketLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Ticket"]];
}

- (void)initLeftColumNames {
    OpenPositionTableViewLeftCell *cell = (OpenPositionTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    
    [cell.instrumentLabel   setText:[[LangCaptain getInstance] getLangByCode:@"Instrument"]];
    [cell.buySellLabel      setText:[[LangCaptain getInstance] getLangByCode:@"BuySell"]];
    [cell.amountLabel       setText:[[LangCaptain getInstance] getLangByCode:@"Amount"]];
    [cell.amountLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.dealPriceLabel    setText:[[LangCaptain getInstance] getLangByCode:@"OpenPrice"]];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    OpenPositionTableViewContentCell *cell = (OpenPositionTableViewContentCell *)[super getContentTableViewCell];
    
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]] getDigits];
    TOrder *order = [[APIDoc getUserDocCaptain] getOrder:[trade getCorOrderID]];
    
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[trade getInstrument]];
    if (pss == nil) {
        return nil;
    }
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[trade getInstrument]];
    NSString *marginRateString = @"";
    
    if ([trade getBuysell] == BUY) {
//        marginRateString = [instUtil formatClientPrice:[pss getBid] isFloor:true];
        marginRateString = [instUtil formatClientPrice:[pss getBid]];
    } else {
//        marginRateString = [instUtil formatClientPrice:[pss getAsk] isFloor:true];
        marginRateString = [instUtil formatClientPrice:[pss getAsk]];
    }
    
    double floatPLOri = [trade floatPLInCCY2];
    double floatPLDollar= [trade floatPL];
    
    [cell.marginRateLabel       setText:marginRateString];
    [cell.limitPriceOrderLabel  setText:[DecimalUtil formatZeroMoney:[order getLimitPrice] digist:digist]];
    [cell.stopPriceOrderLabel   setText:[DecimalUtil formatZeroMoney:[order getCurrentStopPrice] digist:digist]];
    [cell.stopMovePriceLabel    setText:[DecimalUtil formatZeroMoney:[order getStopMoveGap] digist:0]];
    [cell.floatPLOriLabel       setText:[DecimalUtil formatMoney:floatPLOri digist:0]];
    [cell.floatPLDollarLabel    setText:[DecimalUtil formatMoney:floatPLDollar digist:2]];
    [cell.openTimeLabel         setText:[JEDIDateTime stringUIFromDate:[trade getOpenTime]]];
    [cell.ticketLabel           setText:[NSString stringWithFormat:@"%lld(%d)", [trade getTicket], [trade getSplitno]]];
    
    if (floatPLOri > 0.00001) {
        [cell.floatPLOriLabel setTextColor:[UIColor blueUpColor]];
    } else if(floatPLOri < -0.00001) {
        [cell.floatPLOriLabel setTextColor:[UIColor redDownColor]];
    } else {
        [cell.floatPLOriLabel setTextColor:[UIColor whiteColor]];
    }
    
    if (floatPLDollar > 0.00001) {
        [cell.floatPLDollarLabel setTextColor:[UIColor blueUpColor]];
    } else if(floatPLDollar < -0.00001) {
        [cell.floatPLDollarLabel setTextColor:[UIColor redDownColor]];
    } else {
        [cell.floatPLDollarLabel setTextColor:[UIColor whiteColor]];
    }
    
    //    if ([_selectArray containsObject:[NSNumber numberWithInteger:[indexPath row]]]) {
    //        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    //    } else {
    //        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    //    }
    
    if ([trade isSelected]) {
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    } else {
        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    }
    
    if (!cell.isAddListener) {
        [cell.marginRateLabel       addGestureRecognizer:[self getShowHedgingRecongnizer]];
        [cell.floatPLOriLabel       addGestureRecognizer:[self getShowHedgingRecongnizer]];
        [cell.floatPLDollarLabel    addGestureRecognizer:[self getShowHedgingRecongnizer]];
        
        [cell.marginRateLabel       addGestureRecognizer:[self getShowClosePositionRecongnizer]];
        [cell.floatPLOriLabel       addGestureRecognizer:[self getShowClosePositionRecongnizer]];
        [cell.floatPLDollarLabel    addGestureRecognizer:[self getShowClosePositionRecongnizer]];
        
        [cell.limitPriceOrderLabel  addGestureRecognizer:[self getShowOpenPositionOrderLimitRecongnizer]];
        [cell.stopPriceOrderLabel   addGestureRecognizer:[self getShowOpenPositionOrderStopRecongnizer]];
        [cell.stopMovePriceLabel    addGestureRecognizer:[self getShowOpenPositionOrderStopRecongnizer]];
        [cell setIsAddListener:true];
    }
    
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    OpenPositionTableViewLeftCell *cell = (OpenPositionTableViewLeftCell *)[super getLeftTableViewCell];
    
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]] getDigits];
    
    [cell.instrumentLabel   setText:[trade getInstrument]];
    [cell.buySellLabel      setText:[TradeViewShowUtils getStringByBuySell:[trade getBuysell]]];
    [cell.amountLabel       setText:[DecimalUtil formatNumber:[trade getAmount]]];
    [cell.dealPriceLabel    setText:[DecimalUtil formatMoney:[trade getOpenprice] digist:digist]];
    
    [cell.buySellLabel setTextColor:[UIColor buySellLabelColor]];
    
//    if ([_selectArray containsObject:[NSNumber numberWithInteger:[indexPath row]]]) {
//        [cell.contentView setBackgroundColor:[UIColor grayColor]];
//    } else {
//        [cell.contentView setBackgroundColor:[UIColor blackColor]];
//    }
    if ([trade isSelected]) {
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    } else {
        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    }
    
    if (!cell.isAddListener) {
        [cell.instrumentLabel addGestureRecognizer:[self getShowKChartViewRecongnizer]];
        [cell.amountLabel   addGestureRecognizer:[self getShowHedgingRecongnizer]];
        [cell.amountLabel   addGestureRecognizer:[self getShowClosePositionRecongnizer]];
        [cell setIsAddListener:true];
    }
    
    return cell;
}

- (UILongPressGestureRecognizer *)getShowHedgingRecongnizer {
    UILongPressGestureRecognizer *recongnizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(showHedgingView:)];
    [recongnizer setMinimumPressDuration:0.8f];
    return recongnizer;
}

- (UITapGestureRecognizer *)getShowClosePositionRecongnizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showCloseView:)];
    return recongnizer;
}

- (UITapGestureRecognizer *)getShowOpenPositionOrderLimitRecongnizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showOpenPositionOrderViewLimit:)];
    return recongnizer;
}

- (UITapGestureRecognizer *)getShowOpenPositionOrderStopRecongnizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showOpenPositionOrderViewStop:)];
    return recongnizer;
}

- (UITapGestureRecognizer *)getShowOpenPositionOrderOCORecongnizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showOpenPositionOrderViewOCO:)];
    return recongnizer;
}

- (UITapGestureRecognizer *)getShowKChartViewRecongnizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showKChartView:)];
    return recongnizer;
}

#pragma action
- (void)showHedgingView:(UIGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan){
        NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
        if(indexPath == nil) return ;
        TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
        [[JumpDataCenter getInstance] setHedgingInstrumentName:[trade getInstrument]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showHedgingView];
    }
}

- (void)showCloseView:(UIGestureRecognizer *)gesture {
    
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_2];
    
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return ;
    [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:[indexPath row]], nil]];
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    if (![CommDataUtil isUptradeOrder:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OpenPositionLocked"]
                                                            delegate:nil];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OpenPositionLocked"]
                                                            delegate:nil];
        return;
    }
    
    [[JumpDataCenter getInstance] setClosePositionTrade:trade];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showClosePositionView];
}

- (void)showOpenPositionOrderViewLimit:(UIGestureRecognizer *)gesture {
    openOrderType = AddNewOpenOrderTypeLimit;
    [self showOpenPositionOrderView:gesture];
}

- (void)showOpenPositionOrderViewStop:(UIGestureRecognizer *)gesture {
    openOrderType = AddNewOpenOrderTypeStop;
    [self showOpenPositionOrderView:gesture];
}

- (void)showOpenPositionOrderViewOCO:(UIGestureRecognizer *)gesture {
    openOrderType = AddNewOpenOrderTypeOCO;
    [self showOpenPositionOrderView:gesture];
}

- (void)showOpenPositionOrderView:(UIGestureRecognizer *)gesture {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_8];
    
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return;
    
    [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:[indexPath row]], nil]];
    
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    
    if (![CommDataUtil isUptradeOrder:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]
                                                            delegate:nil];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]
                                                            delegate:nil];
        return;
    }
    
    [[JumpDataCenter getInstance] setCreateTradeInstrument:[trade getInstrument]];
    [[JumpDataCenter getInstance] setOpenOrderTrade:trade];
    [[JumpDataCenter getInstance] setMarketTradeType:SELL];
    TOrder *order = [[APIDoc getUserDocCaptain] getOrder:[trade getCorOrderID]];
    if (order == nil) {
        [[JumpDataCenter getInstance] setOpenOrderType:openOrderType];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_AddOpenPositionOrder];
    } else {
        [[JumpDataCenter getInstance] setModifyOrder:order];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_ModifyOpenPositionOrder];
    }
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:[trade getInstrument]];
}

- (void)showKChartView:(UIGestureRecognizer *)gesture {
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return;
    
    [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:[indexPath row]], nil]];
    
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    [[JumpDataCenter getInstance] setEnlargeInstrumentName:[trade getInstrument]];
    
    [[[[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray] objectAtIndex:0] maxMinClick:nil];
}

- (CGFloat)getLeftColumWidth {
    return leftWitdh;
}

- (CGFloat)getContentColumWidth {
    return SCREEN_WIDTH - leftWitdh;
}

- (CGFloat)getScrollContentWidth {
    return scrollViewContentWidth;
}

#pragma listener protocol
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
    [API_IDEventCaptain addListener:DATA_ON_Trade_Changed observer:self listener:@selector(tradeChange:)];
    [API_IDEventCaptain addListener:SystemConfig_OpenSortChanged observer:self listener:@selector(sortRuleChange:)];
    //    [API_IDEventCaptain addListener:DATA_ON_Order_Changed observer:self listener:@selector(tradeChange:)];
    
}
- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
    [API_IDEventCaptain removeListener:DATA_ON_Trade_Changed observer:self];
    [API_IDEventCaptain removeListener:SystemConfig_OpenSortChanged observer:self];
    //    [API_IDEventCaptain removeListener:DATA_ON_Order_Changed observer:self];
}

- (void)tradeChange:(NSNotification *)notify {
    //    [self initData];
    // 注意需要排序
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
    });
}

- (void)sortRuleChange:(NSNotification *)notify {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
    });
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *instrumentName = [snapshot instrumentName];
        NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.contentArray count]; i++) {
            TTrade *trade = [self.contentArray objectAtIndex:i];
            if ([[trade getInstrument] isEqualToString:instrumentName]) {
                [reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
        if ([reloadArray count] != 0) {
            [self.contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
            [self.leftTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
        }
    });
}

- (void)updateSelectIndex {
    
    long long ticket = [[JumpDataCenter getInstance] openPositionTicket];
    if (ticket != 0) {
        for (int i = 0; i < self.contentArray.count; i++) {
            TTrade *trade = [self.contentArray objectAtIndex:i];
            long long tradeTicket = [trade getTicket];
            if (tradeTicket == ticket) {
                [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:i], nil]];
                [[JumpDataCenter getInstance] setOpenPositionTicket:0];
                [[JumpDataCenter getInstance] setOpenPositionInstrumentName:@""];
                break;
            }
        }
        return;
    }
    
    NSString *instrumentName = [[JumpDataCenter getInstance] openPositionInstrumentName];
    if (instrumentName == nil || [instrumentName isEqualToString:@""]) {
        return;
    }
    
    if ([instrumentName isEqualToString:@"-1"]) {
        [self selectNewIndex:[[NSArray alloc] init]];
        [[JumpDataCenter getInstance] setOpenPositionInstrumentName:@""];
        return;
    }
    
    NSMutableArray *selectArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.contentArray.count; i++) {
        if ([instrumentName isEqualToString:[[self.contentArray objectAtIndex:i] getInstrument]]) {
            [selectArray addObject:[NSNumber numberWithInteger:i]];
        }
    }
    [self selectNewIndex:selectArray];
    [[JumpDataCenter getInstance] setOpenPositionInstrumentName:@""];
}

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
}

- (void)pageUnSelect {
    [super pageUnSelect];
}

- (void)pageSelect {
    [super pageSelect];
}

@end
