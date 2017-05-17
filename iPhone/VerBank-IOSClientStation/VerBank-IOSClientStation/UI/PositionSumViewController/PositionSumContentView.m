//
//  PositionSumContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PositionSumContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "APIDoc.h"
#import "UIColor+CustomColor.h"
#import "DecimalUtil.h"
#import "PositionSumCellView.h"
#import "QuoteDataStore.h"
#import "MTP4CommDataInterface.h"
#import "PositionSumItem.h"
#import "LangCaptain.h"
#import "ClientAPI.h"

#import "ClientSystemConfig.h"
#import "NSArraySortUtil.h"
#import "IosLogic.h"
#import "MarketTradeViewController.h"
#import "OpenPositionContentView.h"
#import "CustomFont.h"

#define PositionSumHeigh 80

@interface PositionSumContentView()<UITableViewDataSource, UITableViewDelegate, API_Event_QuoteDataStore>{
    FloatPLStatus *floatPLStatus;
    NSMutableDictionary *positionSumDic;
}

@end

@implementation PositionSumContentView

#pragma init
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initFloatPLStatusBar];
        [self initPositionSumTableView];
        //        tradeArray = [[APIDoc getUserDocCaptain] getTradeArray];
        [self initPositionSumData];
        [self addListener];
    }
    return self;
}

- (void)initPositionSumData{
    positionSumDic = [[NSMutableDictionary alloc] init];
    
    NSArray *tempArray = nil;
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] getAccount]];
    if (groupDoc != nil) {
        TradeDoc *tradeDoc  =[groupDoc getTradeDoc];
        tempArray = [[tradeDoc getTTradeByAccountList:[[ClientAPI getInstance]getAccount]] mutableCopy];
    }
    
    if (tempArray == nil) {
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
    
    self.contentArray = [[NSMutableArray alloc] initWithArray:[positionSumDic allKeys]];
    [self sortArray];
}

- (void)sortArray {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (NSString *instrument in self.contentArray) {
        [itemArray addObject:[self getSumDataByInstrument:instrument]];
    }
    [self sortArray:itemArray];
//    contentArray = [[NSMutableArray alloc] init];
    for (PositionSumItem *item in itemArray) {
        [tempArray addObject:[item instrument]];
    }
    self.contentArray = tempArray;
}

- (void)sortArray:(NSMutableArray *)array {
    switch ([[[ClientSystemConfig getInstance] positionSumSortType] intValue]) {
        case PositionSumSortInstrument:
            for (PositionSumItem *item in array) {
                [item setSortTag:[item instrument]];
            }
            [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
            break;
        case PositionSumSortASC:
            for (PositionSumItem *item in array) {
                [item setSortTag:[@([item sumFloatPL]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        default:
            break;
    }
}


- (void)initFloatPLStatusBar{
    floatPLStatus = [[FloatPLStatus alloc] init];
    [floatPLStatus setFrame:CGRectMake(0.0f,
                                       0.0f,
                                       SCREEN_WIDTH,
                                       FloatPLStatusHeight)];
    [self addSubview:floatPLStatus];
}

- (void)initPositionSumTableView{
    
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight;
    tableViewRect.size.height -= FloatPLStatusHeight;
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    [self addSubview:contentTableView];
    //    [super addPressGesture];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    NSString * instrument = [self.contentArray objectAtIndex:[indexPath row]];
    
    if (cell == nil) {
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    PositionSumCellView *cellView = [PositionSumCellView newInstance];
    CGRect cellViewFrame = cell.frame;
    cellViewFrame.size.height = PositionSumHeigh;
    cellViewFrame.size.width = SCREEN_WIDTH;
    [cellView setFrame:cellViewFrame];
    
    [self updateCellView:cellView instrument:instrument];
    [cellView setBackgroundColor:[UIColor backgroundColor]];
    [cell addSubview:cellView];
    
    [cell setBackgroundColor:[UIColor backgroundColor]];
    return cell;
}

- (void)updateCellView:(PositionSumCellView *)cellView instrument:(NSString *)instrument{
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:instrument];
    int digist = [inst getDigits];
    
    PositionSumItem *item = [self getSumDataByInstrument:instrument];
    
    // string label
    [cellView.instrumentLabel   setText:[item instrument]];
    [cellView.buyLabel          setText:[item buy]];
    [cellView.buyLabel          setTextColor:[UIColor buySellLabelColor]];
    [cellView.sellLable         setText:[item sell]];
    [cellView.sellLable         setTextColor:[UIColor buySellLabelColor]];
    [cellView.tradeDirLabel     setText:[item tradeDir]];
    
    // amount
    [cellView.sumAmountLabel    setText:[DecimalUtil formatNumber:[item sumAmount]]];
    [cellView.sellAmountLabel   setText:[DecimalUtil formatNumber:[item sellAmount]]];
    [cellView.buyAmountLabel    setText:[DecimalUtil formatNumber:[item buyAmount]]];
    
    // avgPrice
    [cellView.buyAvgLabel       setText:[DecimalUtil formatMoney:[item buyAvg] digist:digist]];
    [cellView.sellAvgLabel      setText:[DecimalUtil formatMoney:[item sellAvg] digist:digist]];
    
    // floatPL
    [self updateFloatPL:cellView.sumFloatPLLabel data:[item sumFloatPL] digist:2];
    [self updateFloatPL:cellView.buyFloatPLLabel data:[item buyFloatPL] digist:2];
    [self updateFloatPL:cellView.sellFloatPLLabel data:[item sellFloatPL] digist:2];
    
    [cellView.sumAmountLabel setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [cellView.sumFloatPLLabel setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [cellView.buyLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.sellLable setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.tradeDirLabel setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.instrumentLabel setFont:[CustomFont getCNNormalWithSize:14.0f]];
    [cellView.buyAmountLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.buyAvgLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.buyFloatPLLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.sellAmountLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.sellAvgLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.sellFloatPLLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
}

- (void)updateFloatPL:(UILabel *)label data:(double)data digist:(int)digist{
    NSString *labelFloatString = @"";
    if (data > 0.00001) {
        labelFloatString = [NSString stringWithFormat:@"+%@", [DecimalUtil formatMoney:data digist:digist]];
        [label setTextColor:[UIColor blueUpColor]];
    } else if(data < -0.00001){
        labelFloatString = [DecimalUtil formatMoney:data digist:digist];
        [label setTextColor:[UIColor redColor]];
    } else {
        labelFloatString = [DecimalUtil formatMoney:data digist:digist];
        [label setTextColor:[UIColor whiteColor]];
    }
    [label setText:labelFloatString];
}

- (PositionSumItem *)getSumDataByInstrument:(NSString *)instrument{
    NSArray *tempArray = [positionSumDic objectForKey:instrument];
    PositionSumItem *item = [[PositionSumItem alloc] init];
    [item setInstrument:instrument];
    [item setSell:[[LangCaptain getInstance] getLangByCode:@"Sell"]];
    [item setBuy:[[LangCaptain getInstance] getLangByCode:@"Buy"]];
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
    double netAmount = buyAmount - sellAmount;
    if (netAmount > 0.0001) {
        tradeDir = [[LangCaptain getInstance] getLangByCode:@"NetBuy"];
    } else if (netAmount < -0.0001){
        tradeDir = [[LangCaptain getInstance] getLangByCode:@"NetSell"];
    } else{
        tradeDir = @"-";
    }
    [item setTradeDir:tradeDir];
    return item;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PositionSumHeigh;
}

#pragma listener
- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self removeListener];
    
    [floatPLStatus removeFromSuperview];
    floatPLStatus = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [MarketTradeViewController setInstrumentName:[contentArray objectAtIndex:[indexPath row]]];
    //    [MarketTradeViewController setBuySell:SELL];
    //    [[IosLogic getInstance] gotoMarketTradeViewController];
    [OpenPositionContentView setSelectInstrument:[self.contentArray objectAtIndex:[indexPath row]]];
    [[IosLogic getInstance] gotoOpenPositionViewController];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *instrument = [snapshot instrumentName];
        if ([self.contentArray containsObject:instrument]) {
            NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
            NSIndexPath *path = [NSIndexPath indexPathForRow:[self.contentArray indexOfObject:instrument] inSection:0];
            [reloadArray addObject:path];
            [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
        }
    });
    
}

@end
