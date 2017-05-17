//
//  OrderPositionContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderPositionTableView.h"
#import "OrderPositionTableViewContentCell.h"
#import "OrderPositionTableViewLeftCell.h"
#import "QuoteDataStore.h"
#import "SortUtils.h"

#import "UIColor+CustomColor.h"
#import "ShowAlertManager.h"

static const CGFloat leftWitdh = 260.0f;
static const CGFloat scrollViewContentWidth = 920.0f;

@interface OrderPositionTableView() {
}

@end

@implementation OrderPositionTableView

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)initData {
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] accountID]];
    if (groupDoc != nil) {
        OrderDoc *orderDoc = [groupDoc getOrderDoc];
        self.contentArray = [[NSMutableArray alloc] init];
        NSMutableArray *tempArray = [[orderDoc getTOrderByAccountList:[[ClientAPI getInstance] accountID]] mutableCopy];
        //        NSMutableArray *tempArray = [orderDoc getTOrderByAccountList:[[ClientAPI getInstance] getAccount]];
        for (TOrder *order in tempArray) {
            if ([order getType] == ORDERTYPE_NORMAL) {
                [self.contentArray addObject:order];
            }
        }
    }
    [SortUtils sortOrderPositionArray:self.contentArray];
}

#pragma son Func
- (void)initContentColumNames {
    OrderPositionTableViewContentCell *cell = (OrderPositionTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.limitPriceLabel           setText:[[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    [cell.stopPriceLabel            setText:[[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    [cell.IDTLimitPriceLabel        setText:[[LangCaptain getInstance] getLangByCode:@"IDT Limit"]];
    [cell.IDTStopPriceLabel         setText:[[LangCaptain getInstance] getLangByCode:@"IDT Stop"]];
    [cell.valueTimeTypeLabel        setText:[[LangCaptain getInstance] getLangByCode:@"ValidTimeType"]];
    [cell.valueEndTimeLabel         setText:[[LangCaptain getInstance] getLangByCode:@"ValidEndTime"]];
    [cell.orderTimeLabel            setText:[[LangCaptain getInstance] getLangByCode:@"OrderTime"]];
    [cell.ticketLabel               setText:[[LangCaptain getInstance] getLangByCode:@"Ticket"]];
}

- (void)initLeftColumNames {
    OrderPositionTableViewLeftCell *cell = (OrderPositionTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    
    [cell.instrumentLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Instrument"]];
    [cell.buySellLabel              setText:[[LangCaptain getInstance] getLangByCode:@"BuySell"]];
    [cell.amountLabel               setText:[[LangCaptain getInstance] getLangByCode:@"Amount"]];
    [cell.amountLabel setTextAlignment:NSTextAlignmentCenter];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    OrderPositionTableViewContentCell *cell = (OrderPositionTableViewContentCell *)[super getContentTableViewCell];
    
    TOrder *order = [self.contentArray objectAtIndex:[indexPath row]];
    
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]] getDigits];
    NSString *time = @"";
    if ([order getExpireType] != ORDER_EXPIRE_TYPE_GTC) {
        time = [JEDIDateTime stringOrderHisFromDate:[order getExpiryTime]];
    }
    
    [cell.limitPriceLabel           setText:[DecimalUtil formatZeroMoney:[order getLimitPrice] digist:digist]];
    [cell.stopPriceLabel            setText:[DecimalUtil formatZeroMoney:[order getCurrentStopPrice] digist:digist]];
    [cell.IDTLimitPriceLabel        setText:[DecimalUtil formatZeroMoney:[order getIFDLimitPrice] digist:digist]];
    [cell.IDTStopPriceLabel         setText:[DecimalUtil formatZeroMoney:[order getIFDStopPrice] digist:digist]];
    [cell.valueTimeTypeLabel        setText:[[LangCaptain getInstance] getExpireType:[order getExpireType]]];
    [cell.valueEndTimeLabel         setText:time];
    [cell.orderTimeLabel            setText:[JEDIDateTime stringOrderHisFromDate:[order getOpenTime]]];
    [cell.ticketLabel               setText:[NSString stringWithFormat:@"%lld(%d)", [order getOrderID], [order getOsplitNo]]];
    
    //    if ([_selectArray containsObject:[NSNumber numberWithInteger:[indexPath row]]]) {
    //        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    //    } else {
    //        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    //    }
    
    if ([order isSelected]) {
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    } else {
        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    }
    
    if (!cell.isAddListener) {
        //        [cell.instrumentLabel addGestureRecognizer:[self getShowModifyOrderRecognizer]];
        [cell addGestureRecognizer:[self getShowModifyOrderRecognizer]];
        cell.isAddListener = true;
    }
    
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    OrderPositionTableViewLeftCell *cell = (OrderPositionTableViewLeftCell *)[super getLeftTableViewCell];
    TOrder *order = [self.contentArray objectAtIndex:[indexPath row]];
    [cell.instrumentLabel   setText:[order getInstrument]];
    [cell.buySellLabel      setText:[TradeViewShowUtils getStringByBuySell:[order getBuysell]]];
    [cell.amountLabel       setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [cell.buySellLabel      setTextColor:[UIColor buySellLabelColor]];
    
    //    if ([_selectArray containsObject:[NSNumber numberWithInteger:[indexPath row]]]) {
    //        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    //    } else {
    //        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    //    }
    
    if ([order isSelected]) {
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
    } else {
        [cell.contentView setBackgroundColor:[UIColor blackColor]];
    }
    
    if (!cell.isAddListener) {
        //        [cell.instrumentLabel addGestureRecognizer:[self getShowModifyOrderRecognizer]];
        [cell addGestureRecognizer:[self getShowModifyOrderRecognizer]];
        cell.isAddListener = true;
    }
    return cell;
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

#pragma gesture
- (UITapGestureRecognizer *)getShowModifyOrderRecognizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showModifyOrderView:)];
    return recongnizer;
}

#pragma action
- (void)showModifyOrderView:(UIGestureRecognizer *)gesture {
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return ;
    
    [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:[indexPath row]], nil]];
    
    TOrder *order = [self.contentArray objectAtIndex:[indexPath row]];
    
    if ([order getIsManual]) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]
                                                            delegate:nil];
        return;
    }
    
    if ([order getIsPriceReached]) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]
                                                            delegate:nil];
        return;
    }
    
    //    [[JumpDataCenter getInstance] setClosePositionTrade:trade];
    [[JumpDataCenter getInstance] setModifyOrder:order];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_ModifyOrderTrade];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:[order getInstrument]];
}

#pragma Listener delegate
- (void)addListener {
    //    [QuoteDataStore addQuoteReceiver:self];
    //    [API_IDEventCaptain addListener:DATA_ON_Trade_Changed observer:self listener:@selector(tradeChange:)];
    [API_IDEventCaptain addListener:DATA_ON_Order_Changed observer:self listener:@selector(tradeChange:)];
    [API_IDEventCaptain addListener:SystemConfig_OrderSortChanged observer:self listener:@selector(orderRuleChange:)];
}

- (void)removeListener {
    //    [QuoteDataStore removeQuoteReceiver:self];
    //    [API_IDEventCaptain removeListener:DATA_ON_Trade_Changed observer:self];
    [API_IDEventCaptain removeListener:DATA_ON_Order_Changed observer:self];
    [API_IDEventCaptain removeListener:SystemConfig_OrderSortChanged observer:self];
}

- (void)tradeChange:(NSNotification *)notify {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
        [self updateSelectIndex];
        
    });
}

- (void)orderRuleChange:(NSNotification *)notify {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
        [self updateSelectIndex];
    });
}

- (void)updateSelectIndex {
    long long addNewOrderID = [[JumpDataCenter getInstance] addNewOrderID];
    if (addNewOrderID == 0) {
        return;
    }
    
    if (addNewOrderID == -1) {
        [self selectNewIndex:[[NSArray alloc] init]];
        [[JumpDataCenter getInstance] setAddNewOrderID:0];
        return;
    }
    
    for (int i = 0; i < self.contentArray.count; i++) {
        if (addNewOrderID == [[self.contentArray objectAtIndex:i] getOrderID]) {
            [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:i], nil]];
            [[JumpDataCenter getInstance] setAddNewOrderID:0];
            break;
        }
    }
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