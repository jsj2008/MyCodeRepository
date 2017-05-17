//
//  PriceWarningContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PriceWarningTableView.h"
#import "PriceWarningTableViewContentCell.h"
#import "PriceWarningTableViewLeftCell.h"

static const CGFloat leftWitdh = 0.0f;
static const CGFloat scrollViewContentWidth = 1024.0f;

@implementation PriceWarningTableView

- (id)init {
    if (self = [super init]) {
        //        [self initData];
    }
    return self;
}

- (void)initData {
    self.contentArray = [[NSMutableArray alloc] init];
    // 要改
    NSArray *priceWarningArray = [[TradeApi getInstance] queryPriceWarning];
    for (PriceWarning *pw in priceWarningArray) {
        if ([pw getIsPriceReach] == PRICE_REACH_STATE_NORMAL) {
            [self.contentArray addObject:pw];
        }
    }
}

#pragma son Func
- (void)initContentColumNames {
    PriceWarningTableViewContentCell *cell = (PriceWarningTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.statusLabel           setText:[[LangCaptain getInstance] getLangByCode:@"Status"]];
    [cell.priceReachTimeLabel   setText:[[LangCaptain getInstance] getLangByCode:@"PriceReachTime"]];
    [cell.instrumentLabel       setText:[[LangCaptain getInstance] getLangByCode:@"Instrument"]];
    [cell.warningPriceLabel     setText:[[LangCaptain getInstance] getLangByCode:@"WarningReachPrice"]];
    [cell.validTypeLabel        setText:[[LangCaptain getInstance] getLangByCode:@"ValidTimeType"]];
    [cell.validTimeLabel        setText:[[LangCaptain getInstance] getLangByCode:@"ValidEndTime"]];
    [cell.inputTimeLabel        setText:[[LangCaptain getInstance] getLangByCode:@"InputTime"]];
}

- (void)initLeftColumNames {
    PriceWarningTableViewLeftCell *cell = (PriceWarningTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    PriceWarningTableViewContentCell *cell = (PriceWarningTableViewContentCell *)[super getContentTableViewCell];
    
    PriceWarning *priceWarning = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[priceWarning getInstrument]] getDigits];
    
    NSString *expiryTime = [priceWarning getExpiryType] == ORDER_EXPIRE_TYPE_GTC ? @"" : [JEDIDateTime stringOrderHisFromDate:[priceWarning getExpiryTime]];
    
    [cell.statusLabel           setText:[self translatePriceStatus:[priceWarning getIsPriceReach]]];
    [cell.priceReachTimeLabel   setText:[JEDIDateTime stringUIFromDate:[priceWarning getReachTime]]];
    [cell.instrumentLabel       setText:[priceWarning getInstrument]];
    [cell.warningPriceLabel     setText:[DecimalUtil formatMoney:[priceWarning getPrice] digist:digist]];
    [cell.validTypeLabel        setText:[[LangCaptain getInstance] getExpireType:[priceWarning getExpiryType]]];
    [cell.validTimeLabel        setText:expiryTime];
    [cell.inputTimeLabel        setText:[JEDIDateTime stringUIFromDate:[priceWarning getTime]]];
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getShowModifyPriceWarningRecognizer]];
        cell.isAddListener = true;
    }
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    PriceWarningTableViewLeftCell *cell = (PriceWarningTableViewLeftCell *)[super getLeftTableViewCell];
    
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
- (UITapGestureRecognizer *)getShowModifyPriceWarningRecognizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showModifyPriceWarningView:)];
    return recongnizer;
}

#pragma action
- (void)showModifyPriceWarningView:(UIGestureRecognizer *)gesture {
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return;
    PriceWarning *priceWarning = [self.contentArray objectAtIndex:[indexPath row]];
    if ([priceWarning getIsPriceReach] == PRICE_REACH_STATE_NORMAL) {
        [[JumpDataCenter getInstance] setPriceWarning:priceWarning];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_ModifyPriceWarning];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:[priceWarning getInstrument]];
    }
}

- (NSString *)translatePriceStatus:(int)status {
    NSString *statusString = @"";
    switch (status) {
        case PRICE_REACH_STATE_DELETE:
            statusString = [[LangCaptain getInstance] getLangByCode:@"PriceReachTypeDelete"];
            break;
        case PRICE_REACH_STATE_EXPIRY:
            statusString = [[LangCaptain getInstance] getLangByCode:@"PriceReachTypeExpiry"];
            break;
        case PRICE_REACH_STATE_NORMAL:
            statusString = [[LangCaptain getInstance] getLangByCode:@"PriceReachTypeNormal"];
            break;
        case PRICE_REACH_STATE_REACHED:
            statusString = [[LangCaptain getInstance] getLangByCode:@"PriceReachTypeReached"];
            break;
        default:
            break;
    }
    return statusString;
}

#pragma Listener
- (void)addListener {
    [API_IDEventCaptain addListener:DATA_ON_PriceWarning_Reached observer:self listener:@selector(priceWarningChange:)];
}

- (void)removeListener {
    [API_IDEventCaptain removeListener:DATA_ON_PriceWarning_Reached observer:self];
}

- (void)priceWarningChange:(NSNotification *)notify {
    // 注意需要排序
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
    });
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
