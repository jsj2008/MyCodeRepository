//
//  QuoteListView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/26.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteListView.h"
#import "QuoteListTableViewCell.h"
#import "QuoteView.h"
#import "UIColor+CustomColor.h"
#import "UIView+AddLine.h"
#import "QuoteDataStore.h"
#import "ClientSystemConfig.h"
#import "QuoteItem.h"
#import "APIDoc.h"
#import "DecimalUtil.h"
#import "LangCaptain.h"
#import "UIFormat.h"
#import "LayoutCenter.h"
#import "JumpDataCenter.h"
#import "API_IDEventCaptain.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

const static CGFloat cellHeight = 108.0f;
const static CGFloat popCellHeight = 28.0f;
const static NSUInteger _kDefaultSelectedCell = -1;

@interface QuoteListView()<UITableViewDataSource, UITableViewDelegate, API_Event_QuoteDataStore> {
    
    NSMutableArray *contentArray;
    
    NSUInteger selectCellIndex;
}

@property IBOutlet UITableView *contentTableView;

@end

@implementation QuoteListView

@synthesize contentTableView;

- (void)initContent {
    [self initContentTableView];
    [self addTableViewLongPress];
    [self resetInstrument];
    [self initData];
    [self.contentTableView setBackgroundColor:[UIColor blackColor]];
}

- (void)addTableViewLongPress {
    selectCellIndex = _kDefaultSelectedCell;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(TapPressToDo:)];
    [contentTableView addGestureRecognizer:longPressGesture];
    
}

- (void)resetInstrument {
    if (contentArray == nil) {
        contentArray = [[NSMutableArray alloc] init];
    }
    
    [contentArray removeAllObjects];
    
    for (NSString * instName in [[ClientSystemConfig getInstance] getSelectedInstrumentArray]) {
        QuoteItem *quoteItem = [[QuoteItem alloc] init];
        [quoteItem setInstrument:instName];
        [contentArray addObject:quoteItem];
    }
}

- (void)initData {
    [NSThread detachNewThreadSelector:@selector(runInit) toTarget:self withObject:nil];
}

- (void)runInit {
    while (true) {
        Boolean inited = [QuoteDataStore getInited];
        if (!inited) {
            NSLog(@"sleep");
            [NSThread sleepForTimeInterval:2.0f];
            continue;
        }
        
        for (QuoteItem *quoteItem in contentArray) {
            CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[quoteItem instrument]];
            @synchronized(pss) {
                if (pss != nil && [pss instrumentName] != nil) {
                    //            [self updateQuote:pss withItem:quoteItem];
                    [self initQuoteItem:quoteItem withSnapshot:pss];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [contentTableView reloadData];
        });
        return;
    }
}

- (void)initQuoteItem:(QuoteItem *)item withSnapshot:(CDS_PriceSnapShot *)data {
    if (data == nil || item == nil) {
        return;
    }
    
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[data instrumentName]];
    
//    [item setBid:[instUtil formatClientPrice:[data getBid] isFloor:false]];
//    [item setAsk:[instUtil formatClientPrice:[data getAsk] isFloor:false]];
    [item setBid:[instUtil formatClientPrice:[data getBid]]];
    [item setAsk:[instUtil formatClientPrice:[data getAsk]]];
    [item setHighPrice:[instUtil formatClientPrice:[data highPrice] isFloor:true]];
    [item setLowPricel:[instUtil formatClientPrice:[data lowPrice] isFloor:false]];
    [item setExtradigit:[[instUtil getInstrumentNode] getExtraDigit]];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(long long)[data snapshotTime] / 1000.0];
    [item setQuoteTime:[JEDIDateTime timeStringFromDate:date]];
    [item setUpDownPrice:[instUtil formatClientPrice:([data getBid] - [data yClosePrice]) isFloor:true]];
    [item setUpDownPricePercent:[DecimalUtil formatPercent:([data getBid] - [data yClosePrice]) / [data yClosePrice] withDigist:2]];
}

- (void)initContentTableView {
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    contentTableView.bounces = NO;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    contentTableView.showsVerticalScrollIndicator = NO;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
}

#pragma UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"quoteListViewCell";
    QuoteListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"QuoteListTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellID];
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell.quoteView.leftSubview     addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectSell:)]];
    //    [cell.quoteView.rightSubview    addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectBuy:)]];
    if (!cell.isAddListener) {
        [cell.quoteView.leftSubview.backgroundButton    addTarget:self action:@selector(jumpToCreateSellMarketView:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.quoteView.rightSubview.backgroundButton   addTarget:self action:@selector(jumpToCreateBuyMarketView:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.leftButton addTarget:self action:@selector(jumpToCreateOrderView:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(jumpToCreatePriceWarningView:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.quoteView setIsNeedChangeBuySell:false];

        cell.isAddListener = true;
        UITapGestureRecognizer *updownRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updownChange:)];
        [cell.upDownLabel addGestureRecognizer:updownRecongnizer];
    }

    //        [cell.quoteView setIsNeedChangeBuySell:false];
    [cell addHeaderBottomLineWithWidth:addLineBottomHeight bgColor:[UIColor whiteColor]];
    
    [self updateCell:cell withData:[contentArray objectAtIndex:[indexPath row]]];
    cell.quoteView.leftSubview.backgroundButton.adjustsImageWhenHighlighted = NO;
    cell.quoteView.rightSubview.backgroundButton.adjustsImageWhenHighlighted = NO;

    if (selectCellIndex == [indexPath row]) {
        [cell.leftButton setHidden:false];
        [cell.rightButton setHidden:false];
    } else {
        [cell.leftButton setHidden:true];
        [cell.rightButton setHidden:true];
    }
    
    [cell setBackgroundColor:[UIColor backgroundColor]];
    return cell;
}

- (void)updownChange:(UIGestureRecognizer *)gesture {
    NSNumber *numer = [[ClientSystemConfig getInstance] quoteListUpDownType];
    int type = ([numer intValue] + 1) % 2;
    
    [[ClientSystemConfig getInstance] setQuoteListUpDownType:[NSNumber numberWithInt:type]];
    [[ClientSystemConfig getInstance] saveConfigData];
    [API_IDEventCaptain fireEventChanged:SystemConfig_UpDownTypeChanged eventData:nil];

}

- (void)updateCell:(QuoteListTableViewCell *)cell withData:(QuoteItem *)item {
    
    if ([item quoteTime] == nil || [[item quoteTime] isEqualToString:@""]) {
        return;
    }
    
    NSString *timeString    = [NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"time"], [item quoteTime]];
    NSString *lowString     = [NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"Lowest"], [item lowPricel]];
    NSString *highString    = [NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"Highest"], [item highPrice]];
    NSString *upDownString  = [NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"UpDown"], [item upDownPrice]];
    NSString *upDownPercentString = [NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"UpDownPercent"], [item upDownPricePercent]];
//    [[ClientSystemConfig getInstance] getSelectedInstrumentArray]
    
    [cell.instrumentLabel   setText:[item instrument]];
    [cell.timeLabel         setText:timeString];
    [cell.lowPirceLabel     setText:lowString];
    [cell.highPriceLabel    setText:highString];
    
    if ([[[ClientSystemConfig getInstance] quoteListUpDownType] intValue] == QuoteUpDown) {
        [cell.upDownLabel       setText:upDownString];
    } else {
        [cell.upDownLabel       setText:upDownPercentString];
    }
    
    [cell.quoteView.leftSubview updateValue:[item bid]];
    [cell.quoteView.rightSubview updateValue:[item ask]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == selectCellIndex) {
        return cellHeight + popCellHeight;
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
}

#pragma abstractfunc
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
    [API_IDEventCaptain addListener:SystemConfig_InstrumentArrayChanged observer:self listener:@selector(instrumentArrayChange)];
    [API_IDEventCaptain addListener:SystemConfig_UpDownTypeChanged observer:self listener:@selector(instrumentArrayChange)];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
    [API_IDEventCaptain removeListener:SystemConfig_InstrumentArrayChanged observer:self];
    [API_IDEventCaptain removeListener:SystemConfig_UpDownTypeChanged observer:self];
    //     addListener:SystemConfig_InstrumentArrayChanged observer:self listener:@selector(instrumentArrayChange)];
}

- (void)updateView {}

- (void)instrumentArrayChange {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        
        [self resetInstrument];
        for (QuoteItem *quoteItem in contentArray) {
            CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[quoteItem instrument]];
            @synchronized(pss) {
                if (pss != nil && [pss instrumentName] != nil) {
                    [self initQuoteItem:quoteItem withSnapshot:pss];
                }
            }
        }
        [self.contentTableView reloadData];
        [self addListener];
    });
}

#pragma quoteReciver
- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    if(snapshot == nil){
        return;
    }
    
    @synchronized(contentArray){
        NSString *insName = [snapshot instrumentName];
        for(int i=0; i<contentArray.count; ++i){
            QuoteItem * item = [contentArray objectAtIndex:i];
            if(item && [[item instrument] isEqualToString:insName]){
                [self initQuoteItem:item withSnapshot:snapshot];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                    [contentTableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:path, nil]
                                            withRowAnimation:UITableViewRowAnimationNone];
                });
                break;
            }
        }
    }
}

#pragma layout
- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)TapPressToDo:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:contentTableView];
        NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        [self popCellLogic:indexPath];
        if (selectCellIndex == [contentArray count] - 1) {
            [contentTableView setContentOffset:CGPointMake(0, contentTableView.contentSize.height - contentTableView.bounds.size.height + popCellHeight) animated:YES];
        }
    }
}

#pragma popCell

- (void)popCellLogic:(NSIndexPath *)indexPath{
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    
    if (selectCellIndex == _kDefaultSelectedCell) {
        selectCellIndex = [indexPath row];
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    } else if(selectCellIndex == [indexPath row]){
        selectCellIndex = _kDefaultSelectedCell;
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
    } else if(selectCellIndex > [indexPath row]){
        int temp = (int)selectCellIndex;
        selectCellIndex = [indexPath row];
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
        NSMutableArray *preReloadArray = [[NSMutableArray alloc] init];
        [preReloadArray addObject:[NSIndexPath indexPathForRow:temp inSection:0]];
        [contentTableView reloadRowsAtIndexPaths:preReloadArray withRowAnimation:UITableViewRowAnimationNone];
    } else if(selectCellIndex < [indexPath row]){
        [reloadArray addObject:[NSIndexPath indexPathForRow:selectCellIndex inSection:0]];
        [reloadArray addObject:[NSIndexPath indexPathForRow:[indexPath row] inSection:0]];
        selectCellIndex = [indexPath row];
    }
    
    [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
}

#pragma jump
- (void)jumpToCreateSellMarketView:(id)sender event:(id)event {
    NSIndexPath *indexPath = [self getSelectIndexByEvent:event];
    NSString *instrumentName = [[contentArray objectAtIndex:[indexPath row]] instrument];
    [[JumpDataCenter getInstance] setCreateTradeInstrument:instrumentName];
    [[JumpDataCenter getInstance] setMarketTradeType:SELL];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_MarketTrade];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:instrumentName];
}

- (void)jumpToCreateBuyMarketView:(id)sender event:(id)event {
    NSIndexPath *indexPath = [self getSelectIndexByEvent:event];
    NSString *instrumentName = [[contentArray objectAtIndex:[indexPath row]] instrument];
    [[JumpDataCenter getInstance] setCreateTradeInstrument:instrumentName];
    [[JumpDataCenter getInstance] setMarketTradeType:BUY];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_MarketTrade];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:instrumentName];
    [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:0];
}

- (void)jumpToCreateOrderView:(id)sender event:(id)event {
    
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_1];
    
    NSIndexPath *indexPath = [self getSelectIndexByEvent:event];
    NSString *instrumentName = [[contentArray objectAtIndex:[indexPath row]] instrument];
    [[JumpDataCenter getInstance] setCreateTradeInstrument:instrumentName];
    [[JumpDataCenter getInstance] setMarketTradeType:SELL];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_AddOrderTrade];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:instrumentName];
    [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:0];
}

- (void)jumpToCreatePriceWarningView:(id)sender event:(id)event{
    
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_2];
    
    NSIndexPath *indexPath = [self getSelectIndexByEvent:event];
    NSString *instrumentName = [[contentArray objectAtIndex:[indexPath row]] instrument];
    [[JumpDataCenter getInstance] setCreateTradeInstrument:instrumentName];
    [[JumpDataCenter getInstance] setMarketTradeType:SELL];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_PriceWarnigTrade];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:instrumentName];
}

- (NSIndexPath *)getSelectIndexByEvent:(id)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:contentTableView];
    NSIndexPath *indexPath = [contentTableView indexPathForRowAtPoint:currentTouchPosition];
    if(indexPath == nil) return nil;
    return indexPath;
}

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self resetInstrument];
        for (QuoteItem *quoteItem in contentArray) {
            CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[quoteItem instrument]];
            @synchronized(pss) {
                if (pss != nil && [pss instrumentName] != nil) {
                    [self initQuoteItem:quoteItem withSnapshot:pss];
                }
            }
        }
        [self.contentTableView reloadData];
        [self addListener];
    });
}

- (void)pageUnSelect {
    [super pageUnSelect];
}

- (void)pageSelect {
    //    [super pageSelect];
}

@end
