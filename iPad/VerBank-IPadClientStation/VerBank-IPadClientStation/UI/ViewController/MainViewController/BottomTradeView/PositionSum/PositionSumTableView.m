//
//  PositionSumContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PositionSumTableView.h"
#import "PositionSumTableViewContentCell.h"
#import "PositionSumTableViewLeftCell.h"

#import "QuoteDataStore.h"

#import "UIColor+CustomColor.h"
#import "PositionSumItem.h"
#import "SortUtils.h"

static const CGFloat leftWitdh = 470.0f;
static const CGFloat scrollViewContentWidth = 1020.0f;

@interface PositionSumTableView()<API_Event_QuoteDataStore> {
    // instrument --> positionSum
    NSMutableDictionary *positionSumDic;
}

@end

@implementation PositionSumTableView

- (id)init {
    if (self = [super init]) {
        positionSumDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)initData {
    [positionSumDic removeAllObjects];
    [self.contentArray removeAllObjects];
    
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] accountID]];
    if (groupDoc == nil) {
        NSLog(@"****** err group doc is nil! ******");
        return;
    }
    
    if (groupDoc != nil) {
        TradeDoc *tradeDoc  =[groupDoc getTradeDoc];
        NSArray *tempArray = [[tradeDoc getTTradeByAccountList:[[ClientAPI getInstance]accountID]] mutableCopy];
        if (tempArray == nil || [tempArray count] == 0) {
            return;
        }
        
        for (TTrade *trade in tempArray) {
            if (![[positionSumDic allKeys] containsObject:[trade getInstrument]]) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                [positionSumDic setObject:array forKey:[trade getInstrument]];
            }
            NSMutableArray *array = [positionSumDic objectForKey:[trade getInstrument]];
            [array addObject:trade];
        }
        
        for (NSString *instrumentKey in [positionSumDic allKeys]) {
            [self.contentArray addObject:[self getSumDataByInstrument:instrumentKey]];
        }
    }
    
    [SortUtils sortPositionSumArray:self.contentArray];
}

#pragma son Func
- (void)initContentColumNames {
    PositionSumTableViewContentCell *cell = (PositionSumTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.buyAmountLabel        setText:[[LangCaptain getInstance] getLangByCode:@"BuyAmount"]];
    [cell.buyAvgLabel           setText:[[LangCaptain getInstance] getLangByCode:@"BuyAvg"]];
    [cell.buyFloatPLLabel       setText:[[LangCaptain getInstance] getLangByCode:@"BuyFloatPL"]];
    [cell.sellMKTPriceLabel     setText:[[LangCaptain getInstance] getLangByCode:@"SellMKTPrice"]];
    
    [cell.sellAmountLabel       setText:[[LangCaptain getInstance] getLangByCode:@"SellAmount"]];
    [cell.sellAvgLabel          setText:[[LangCaptain getInstance] getLangByCode:@"SellAvg"]];
    [cell.sellFloatPLLabel      setText:[[LangCaptain getInstance] getLangByCode:@"SellFloatPL"]];
    [cell.buyMKTPriceLabel      setText:[[LangCaptain getInstance] getLangByCode:@"BuyMKTPrice"]];
}

- (void)initLeftColumNames {
    PositionSumTableViewLeftCell *cell = (PositionSumTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    
    [cell.instrumentLabel   setText:[[LangCaptain getInstance] getLangByCode:@"Instrument"]];
    [cell.buySellLabel      setText:[NSString stringWithFormat:@"%@%@", [[LangCaptain getInstance] getLangByCode:@"Net"], [[LangCaptain getInstance] getLangByCode:@"BuySell"]]];
    [cell.positionSumLabel  setText:[NSString stringWithFormat:@"%@%@", [[LangCaptain getInstance] getLangByCode:@"Net"], [[LangCaptain getInstance] getLangByCode:@"Position"]]];
    [cell.floatPLSumLabel   setText:[[LangCaptain getInstance] getLangByCode:@"FloatPLSum"]];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    PositionSumTableViewContentCell *cell = (PositionSumTableViewContentCell *)[super getContentTableViewCell];
    
    
    PositionSumItem *item = [self.contentArray objectAtIndex:[indexPath row]];
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[item instrument]] getDigits];
    
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[item instrument]];
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[item instrument]];
    
    [cell.buyAmountLabel        setText:[NSString stringWithFormat:@"+%@", [DecimalUtil formatNumber:[item buyAmount]]]];
    [cell.buyAvgLabel           setText:[DecimalUtil formatMoney:[item buyAvg] digist:digist]];
    [self updateFloatPL:cell.buyFloatPLLabel data:[item buyFloatPL] digist:2];
//    [cell.sellMKTPriceLabel     setText:[instUtil formatClientPrice:[pss getBid] isFloor:true]];
    [cell.sellMKTPriceLabel     setText:[instUtil formatClientPrice:[pss getBid]]];
    
    [cell.sellAmountLabel       setText:[NSString stringWithFormat:@"-%@", [DecimalUtil formatNumber:[item sellAmount]]]];
    [cell.sellAvgLabel          setText:[DecimalUtil formatMoney:[item sellAvg] digist:digist]];
    [self updateFloatPL:cell.sellFloatPLLabel data:[item sellFloatPL] digist:2];
//    [cell.buyMKTPriceLabel      setText:[instUtil formatClientPrice:[pss getAsk] isFloor:true]];
    [cell.buyMKTPriceLabel          setText:[instUtil formatClientPrice:[pss getAsk]]];
    
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getShowOpenPositionRecognizer]];
        cell.isAddListener = true;
    }
    
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    PositionSumTableViewLeftCell *cell = (PositionSumTableViewLeftCell *)[super getLeftTableViewCell];
    
    PositionSumItem *item = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.instrumentLabel   setText:[item instrument]];
    [cell.buySellLabel      setText:[item tradeDir]];
    [cell.positionSumLabel  setText:[NSString stringWithFormat:@"%@%@", [item buySellSymbol], [DecimalUtil formatNumber:[item sumAmount]]]];
    [cell.buySellLabel      setTextColor:[UIColor buySellLabelColor]];
    
    [self updateFloatPL:cell.floatPLSumLabel data:[item sumFloatPL] digist:2];
    
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getShowOpenPositionRecognizer]];
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
- (UITapGestureRecognizer *)getShowOpenPositionRecognizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showOpenPositionView:)];
    return recongnizer;
}

#pragma action
- (void)showOpenPositionView:(UIGestureRecognizer *)gesture {
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return ;
    
    [self selectNewIndex:[[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:[indexPath row]], nil]];
    
    PositionSumItem *item = [self.contentArray objectAtIndex:[indexPath row]];
    [[JumpDataCenter getInstance] setOpenPositionInstrumentName:[item instrument]];
    
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OpenPosition];
}

#pragma private function
- (PositionSumItem *)getSumDataByInstrument:(NSString *)instrument{
    NSArray *tempArray = [positionSumDic objectForKey:instrument];
    PositionSumItem *item = [[PositionSumItem alloc] init];
    [item setInstrument:instrument];
    //    [item setSell:[[LangCaptain getInstance] getLangByCode:@"Sell"]];
    //    [item setBuy:[[LangCaptain getInstance] getLangByCode:@"Buy"]];
    double buyAmount = 0.0f;
    double sellAmount = 0.0f;
    double buyFloatPL = 0.0f;
    double sellFloatPL = 0.0f;
    double buySum = 0.0f;
    double sellSum = 0.0f;
    for (TTrade *trade in tempArray) {
        if ([trade getBuysell] == BUY) {
            buyAmount += [trade getAmount];
            buyFloatPL += [trade floatPL];
            buySum += [trade getAmount] * [trade getOpenprice];
        } else {
            sellAmount += [trade getAmount];
            sellFloatPL += [trade floatPL];
            sellSum += [trade getAmount] * [trade getOpenprice];
        }
    }
    double sumAmount = fabs(buyAmount - sellAmount);
    double sumFloatPL = buyFloatPL + sellFloatPL;
    [item setSumAmount:sumAmount];
    [item setBuyAmount:buyAmount];
    [item setSellAmount:sellAmount];
    [item setSumFloatPL:sumFloatPL];
    [item setBuyFloatPL:buyFloatPL];
    [item setSellFloatPL:sellFloatPL];
    if (buyAmount < 0.000001 && buyAmount > -0.000001) {
        [item setBuyAvg:0.0f];
    } else{
        [item setBuyAvg:buySum / buyAmount];
    }
    
    if (sellAmount < 0.000001 && sellAmount > -0.000001) {
        [item setSellAvg:0.0f];
    } else {
        [item setSellAvg:sellSum / sellAmount];
    }
    
    NSString *tradeDir = @"-";
    NSString *buySellSymbol = @"";
    double netAmount = buyAmount - sellAmount;
    if (netAmount > 0.0001) {
        tradeDir = [[LangCaptain getInstance] getLangByCode:@"Buy"];
        buySellSymbol = @"+";
    } else if (netAmount < -0.0001){
        tradeDir = [[LangCaptain getInstance] getLangByCode:@"Sell"];
        buySellSymbol = @"-";
    } else{
        tradeDir = @"-";
    }
    [item setTradeDir:tradeDir];
    [item setBuySellSymbol:buySellSymbol];
    return item;
}

- (void)updateFloatPL:(UILabel *)label data:(double)data digist:(int)digist{
    NSString *labelFloatString = @"";
    if (data > 0.00001) {
        labelFloatString = [NSString stringWithFormat:@"+%@", [DecimalUtil formatMoney:data digist:digist]];
        [label setTextColor:[UIColor blueUpColor]];
    } else if(data < -0.00001){
        labelFloatString = [NSString stringWithFormat:@"%@", [DecimalUtil formatMoney:data digist:digist]];
        [label setTextColor:[UIColor redColor]];
    } else {
        labelFloatString = [DecimalUtil formatMoney:data digist:digist];
        [label setTextColor:[UIColor whiteColor]];
    }
    [label setText:labelFloatString];
}

#pragma Listener

- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
    [API_IDEventCaptain addListener:DATA_ON_Trade_Changed observer:self listener:@selector(tradeChange:)];
        [API_IDEventCaptain addListener:SystemConfig_PositionSumSortChanged observer:self listener:@selector(positionSumSortRuleChange:)];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
    [API_IDEventCaptain removeListener:DATA_ON_Trade_Changed observer:self];
    [API_IDEventCaptain removeListener:SystemConfig_PositionSumSortChanged observer:self];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *instrument = [snapshot instrumentName];
        for (int index = 0; index < self.contentArray.count; index++) {
            PositionSumItem *item = [self.contentArray objectAtIndex:0];
            if ([[item instrument] isEqualToString:instrument]) {
                [self.contentArray replaceObjectAtIndex:index withObject:[self getSumDataByInstrument:instrument]];
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                NSMutableArray *reloadArray = [[NSMutableArray alloc] initWithObjects:path, nil];
                
                if ([reloadArray count] != 0) {
                    [self.contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
                    [self.leftTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
                }
                
                break;
            }
        }
    });
}

- (void)tradeChange:(NSNotification *)notify {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
    });
}

- (void)positionSumSortRuleChange:(NSNotification *)notify {
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
