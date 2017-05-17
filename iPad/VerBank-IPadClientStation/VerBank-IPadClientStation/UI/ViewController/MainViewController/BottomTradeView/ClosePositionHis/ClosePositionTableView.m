//
//  ClosePositionContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ClosePositionTableView.h"
#import "ClosePositionTableViewContentCell.h"
#import "ClosePositionTableViewLeftCell.h"

#import "ShowAlertManager.h"
#import "UIColor+CustomColor.h"
#import "SortUtils.h"

static const CGFloat leftWitdh = 470.0f;
static const CGFloat scrollViewContentWidth = 890.0f;

@implementation ClosePositionTableView

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

- (void)initData {
    NSDate *endDate = [NSDate date];
    long long accountID = [[ClientAPI getInstance] accountID];
    NSDate *beginDate = [NSDate dateWithTimeIntervalSinceNow:WeekSecInterval * -1];
    self.contentArray = [[[TradeApi getInstance] report_ClosedPositionsDetails_Account:beginDate
                                                                               endTime:endDate
                                                                               account:accountID] reportList];
    [SortUtils sortClosePositionArray:self.contentArray];
    
}

- (double)getFloatPositionSum {
    double floatPositionSum = 0.0f;
    for (ClosePositionDetails *details in self.contentArray) {
        floatPositionSum += [details getProfitLoss];
    }
    return floatPositionSum;
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
    
    self.contentArray = [[[TradeApi getInstance] report_ClosedPositionsDetails_Account:beginDate
                                                                               endTime:endDate
                                                                               account:accountID] reportList];
    [SortUtils sortClosePositionArray:self.contentArray];
}

#pragma son Func
- (void)initContentColumNames {
    ClosePositionTableViewContentCell *cell = (ClosePositionTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.openPriceLabel        setText:[[LangCaptain getInstance] getLangByCode:@"OpenPrice"]];
    [cell.floatPLOriLabel       setText:[[LangCaptain getInstance] getLangByCode:@"PL(Ori)"]];
    [cell.floatPLDollarLabel    setText:[[LangCaptain getInstance] getLangByCode:@"PL(Dollar)"]];
    [cell.closeTimeLabel        setText:[[LangCaptain getInstance] getLangByCode:@"CloseTime"]];
    [cell.openTimeLabel         setText:[[LangCaptain getInstance] getLangByCode:@"OpenTime"]];
    [cell.ticketLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Ticket"]];
}

- (void)initLeftColumNames {
    ClosePositionTableViewLeftCell *cell = (ClosePositionTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    
    [cell.instrumentLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Instrument"]];
    [cell.buySellLabel              setText:[[LangCaptain getInstance] getLangByCode:@"BuySell"]];
    [cell.amountLabel               setText:[[LangCaptain getInstance] getLangByCode:@"Amount"]];
    [cell.amountLabel               setTextAlignment:NSTextAlignmentCenter];
    [cell.closePositionPriceLabel   setText:[[LangCaptain getInstance] getLangByCode:@"ClosePrice"]];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ClosePositionTableViewContentCell *cell = (ClosePositionTableViewContentCell *)[super getContentTableViewCell];
    
    ClosePositionDetails *closePositionDetails = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[closePositionDetails getInstrument]] getDigits];
    
    double floatPLOri = [closePositionDetails getProfit];
    double floatPLDollar = [closePositionDetails getProfitLoss];
    
    [cell.openPriceLabel        setText:[DecimalUtil formatMoney:[closePositionDetails getOpenPrice] digist:digist]];
    [cell.floatPLOriLabel       setText:[DecimalUtil formatMoney:floatPLOri digist:0]];
    [cell.floatPLDollarLabel    setText:[DecimalUtil formatMoney:floatPLDollar digist:2]];
    [cell.closeTimeLabel        setText:[JEDIDateTime stringUIFromDate:[closePositionDetails getCloseTime]]];
    [cell.openTimeLabel         setText:[JEDIDateTime stringUIFromDate:[closePositionDetails getOpenTime]]];
    [cell.ticketLabel           setText:[NSString stringWithFormat:@"%lld(%d)", [closePositionDetails getTicket], [closePositionDetails getSplitno]]];
    
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
    
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ClosePositionTableViewLeftCell *cell = (ClosePositionTableViewLeftCell *)[super getLeftTableViewCell];
    
    ClosePositionDetails *closePositionDetails = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[closePositionDetails getInstrument]] getDigits];
    
    // 因为是平仓记录， 所以相反
    NSString *buySell = [closePositionDetails getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Sell"] : [[LangCaptain getInstance] getLangByCode:@"Buy"];
    
    [cell.instrumentLabel           setText:[closePositionDetails getInstrument]];
    [cell.buySellLabel              setText:buySell];
    [cell.amountLabel               setText:[DecimalUtil formatNumber:[closePositionDetails getAmount]]];
    [cell.closePositionPriceLabel   setText:[DecimalUtil formatMoney:[closePositionDetails getClosePrice] digist:digist]];
    
    [cell.buySellLabel              setTextColor:[UIColor buySellLabelColor]];
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

- (void)updateSelectIndex {
    NSArray *ticketArray = [[JumpDataCenter getInstance] closePositionHisTicketArray];
    if (ticketArray == nil || [ticketArray count] == 0) {
        return;
    }
    
//    if (closePositionHisTicket == -1) {
//        [self selectNewIndex:[[NSArray alloc] init]];
//        [[JumpDataCenter getInstance] setAddNewOrderID:0];
//        return;
//    }
    
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.contentArray.count; i++) {
        for (id ticketContainer in ticketArray) {
            long long ticket = [ticketContainer getTicket];
            if (ticket == [[self.contentArray objectAtIndex:i] getTicket]) {
                [indexArray addObject:[NSNumber numberWithInteger:i]];
            }
        }
//        if (closePositionHisTicket == [[self.contentArray objectAtIndex:i] getTicket]) {
////            [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:i], nil]];
////            [[JumpDataCenter getInstance] setClosePositionHisTicket:0];
//            break;
//        }
    }
    [self selectNewIndex:indexArray];
    [[JumpDataCenter getInstance] setClosePositionHisTicketArray:[[NSArray alloc] init]];
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
