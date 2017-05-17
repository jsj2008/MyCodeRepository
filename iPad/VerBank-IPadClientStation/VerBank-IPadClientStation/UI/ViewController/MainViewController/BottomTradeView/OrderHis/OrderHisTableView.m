//
//  OrderHisContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderHisTableView.h"
#import "OrderHisTableViewContentCell.h"
#import "OrderHisTableViewLeftCell.h"
#import "TranslateUtil.h"
#import "CheckUtils.h"

#import "ShowAlertManager.h"
#import "UIColor+CustomColor.h"
#import "SortUtils.h"

static const CGFloat leftWitdh = 400.0f;
static const CGFloat scrollViewContentWidth = 1550.0f;

@implementation OrderHisTableView

- (id)init {
    if (self = [super init]) {
        //        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
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
    long long accountID = [[ClientAPI getInstance] accountID];
    
    self.contentArray = [[[TradeApi getInstance] report_TOrderHisDetails_Account:beginDate
                                                                         endTime:endDate
                                                                         account:accountID] reportList];
    [SortUtils sortOrderHisArray:self.contentArray];
}

- (void)initData {
    NSDate *endDate = [TimeUtil endDayOfDate];
    long long accountID = [[ClientAPI getInstance] accountID];
    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:WeekSecInterval * -1];
    self.contentArray = [[[TradeApi getInstance] report_TOrderHisDetails_Account:beginDate
                                                                         endTime:endDate
                                                                         account:accountID] reportList];
    
    [SortUtils sortOrderHisArray:self.contentArray];
}

#pragma son Func
- (void)initContentColumNames {
    OrderHisTableViewContentCell *cell = (OrderHisTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.typeLabel             setText:[[LangCaptain getInstance] getLangByCode:@"Type"]];
    [cell.limitPriceLabel       setText:[[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    [cell.stopPriceLabel        setText:[[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    [cell.stopMoveLabel         setText:[[LangCaptain getInstance] getLangByCode:@"StopMovePrice"]];
    [cell.dealPriceLabel        setText:[[LangCaptain getInstance] getLangByCode:@"DealPrice"]];
    [cell.IFDLimitPriceTLabel   setText:[[LangCaptain getInstance] getLangByCode:@"IDT Limit"]];
    [cell.IFDStopPriceTLabel    setText:[[LangCaptain getInstance] getLangByCode:@"IDT Stop"]];
    
    [cell.categoryLabel         setText:[[LangCaptain getInstance] getLangByCode:@"Category"]];
    [cell.closeTicketLabel      setText:[[LangCaptain getInstance] getLangByCode:@"CloseTicket"]];
    [cell.valueTimeTypeLabel    setText:[[LangCaptain getInstance] getLangByCode:@"ValidTimeType"]];
    [cell.valueTimeEndLabel     setText:[[LangCaptain getInstance] getLangByCode:@"ValidEndTime"]];
    [cell.confirmTimeLabel      setText:[[LangCaptain getInstance] getLangByCode:@"ConfirmTime"]];
    [cell.inputTimeLabel        setText:[[LangCaptain getInstance] getLangByCode:@"InputTime"]];
}

- (void)initLeftColumNames {
    OrderHisTableViewLeftCell *cell = (OrderHisTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    
    [cell.ticketLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Ticket"]];
    [cell.amountLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Amount"]];
    [cell.amountLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.instrumentLabel       setText:[[LangCaptain getInstance] getLangByCode:@"Instrument"]];
    [cell.buySellLabel          setText:[[LangCaptain getInstance] getLangByCode:@"BuySell"]];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    OrderHisTableViewContentCell *cell = (OrderHisTableViewContentCell *)[super getContentTableViewCell];
    
    TOrderHis *orderHis = [self.contentArray objectAtIndex:[indexPath row]];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[orderHis getInstrument]];
    int digist = [inst getDigits];
    
    NSString *expiryTime = [orderHis getExpireType] == ORDER_EXPIRE_TYPE_GTC ? @"" : [JEDIDateTime stringOrderHisFromDate:[orderHis getExpiryTime]];
    
    [cell.typeLabel             setText:[CheckUtils getOCOStringByStop:[orderHis getCurrentStopPrice] limitPrice:[orderHis getLimitPrice]]];
    [cell.limitPriceLabel       setText:[DecimalUtil formatZeroMoney:[orderHis getLimitPrice] digist:digist]];
    [cell.stopPriceLabel        setText:[DecimalUtil formatZeroMoney:[orderHis getCurrentStopPrice] digist:digist]];
    [cell.stopMoveLabel         setText:[DecimalUtil formatZeroMoney:[orderHis getStopMoveGap] digist:0]];
    [cell.dealPriceLabel        setText:[DecimalUtil formatZeroMoney:[orderHis getclosePrice] digist:digist]];
    [cell.IFDLimitPriceTLabel   setText:[DecimalUtil formatZeroMoney:[orderHis getIFDLimitPrice] digist:digist]];
    [cell.IFDStopPriceTLabel    setText:[DecimalUtil formatZeroMoney:[orderHis getIFDStopPrice] digist:digist]];
    
    [cell.categoryLabel         setText:[TranslateUtil translateCloseType:[orderHis getcloseType] reason:[orderHis getcloseReason]]];
    [cell.closeTicketLabel      setText:[NSString stringWithFormat:@"%lld", [orderHis getCorrespondingTicket]]];
    [cell.valueTimeTypeLabel    setText:[[LangCaptain getInstance] getExpireType:[orderHis getExpireType]]];
    [cell.valueTimeEndLabel     setText:expiryTime];
    [cell.confirmTimeLabel      setText:[JEDIDateTime stringOrderHisFromDate:[orderHis getcloseTime]]];
    [cell.inputTimeLabel        setText:[JEDIDateTime stringUIFromDate:[orderHis getOpenTime]]];
    
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    OrderHisTableViewLeftCell *cell = (OrderHisTableViewLeftCell *)[super getLeftTableViewCell];
    
    TOrderHis *orderHis = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.ticketLabel           setText:[NSString stringWithFormat:@"%lld(%d)", [orderHis getOrderID], [orderHis getOsplitNo]]];
    [cell.amountLabel           setText:[DecimalUtil formatNumber:[orderHis getAmount]]];
    [cell.instrumentLabel       setText:[orderHis getInstrument]];
    [cell.buySellLabel          setText:[TradeViewShowUtils getStringByBuySell:[orderHis getBuysell]]];
    
    [cell.buySellLabel          setTextColor:[UIColor buySellLabelColor]];
    
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
