//
//  FreezeView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuoteListContentView.h"
#import "FreezeTableView.h"
#import "LangCaptain.h"
#import "JEDISystem.h"
#import "QuoteItem.h"
#import "APIDoc.h"
#import "QuoteDataStore.h"
#import "IosLayoutDefine.h"

#import "UIColor+CustomColor.h"
#import "API_IDEventCaptain.h"
#import "API_Event_QuoteDataStore.h"
#import "JEDIDateTime.h"
#import "DecimalUtil.h"
#import "FloatPLStatus.h"
#import "ClientAPI.h"
#import "ClientSystemConfig.h"
#import "KChartView.h"
#import "InstrumentStruct.h"

//#define ColumWidth 90.0f
//#define CellHeight 45.0f

@interface QuoteListContentView()<FreezeTableViewDataSource, API_Event_QuoteDataStore>{
    FreezeTableView *freezeTableView;
    FloatPLStatus *floatPLStatus;
    
    NSMutableArray *headData;
    NSMutableArray *contentArray;
    
    NSMutableArray *columWithArray;
    
    Boolean isInited;
}

@end

@implementation QuoteListContentView

#pragma init

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        isInited = false;
        contentArray = [[NSMutableArray alloc] init];
        //        [self addListerner];
        [self initData];
        
        [self initLayout];
        
    }
    return self;
}

- (void)initLayout{
    
    freezeTableView = [[FreezeTableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                        FloatPLStatusHeight,
                                                                        self.frame.size.width,
                                                                        self.frame.size.height - FloatPLStatusHeight - buttonHeight)];
    [freezeTableView addTapPressGesture];
    floatPLStatus = [[FloatPLStatus alloc] init];
    [floatPLStatus setFrame:CGRectMake(0.0f,
                                       0.0f,
                                       self.frame.size.width,
                                       FloatPLStatusHeight)];
    freezeTableView.leftHeaderEnable = YES;
    freezeTableView.datasource = self;
    [self addSubview:freezeTableView];
    [self addSubview:floatPLStatus];
    
}
//
//- (void)replaceArray:(NSMutableArray *)array Index:(int)index {
//    [array replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:0]];
//}

- (void)initData {
    
    // 买入卖出 最高 最低 涨跌 涨跌幅 更新时间
    NSNumber *c0 = [NSNumber numberWithFloat:(SCREEN_WIDTH - [ScreenAuotoSizeScale CGAutoMakeFloat:130]) / 2];
    NSNumber *c1 = [NSNumber numberWithFloat:(SCREEN_WIDTH - [ScreenAuotoSizeScale CGAutoMakeFloat:130]) / 2];
    
    NSNumber *c2 = [NSNumber numberWithFloat: [ScreenAuotoSizeScale CGAutoMakeFloat:100]];
    NSNumber *c3 = [NSNumber numberWithFloat: [ScreenAuotoSizeScale CGAutoMakeFloat:100]];
    //    NSNumber *c4 = [NSNumber numberWithFloat: [ScreenAuotoSizeScale CGAutoMakeFloat:0]];
    NSNumber *c5 = [NSNumber numberWithFloat: [ScreenAuotoSizeScale CGAutoMakeFloat:100]];
    //    NSNumber *c6 = [NSNumber numberWithFloat: [ScreenAuotoSizeScale CGAutoMakeFloat:100]];
    NSNumber *c7 = [NSNumber numberWithFloat: [ScreenAuotoSizeScale CGAutoMakeFloat:105]];
    //    columWithArray = [[NSMutableArray alloc] initWithObjects:c0, c1, c2, c3, c4, c5, c6, c7, nil];
    columWithArray = [[NSMutableArray alloc] initWithObjects:c0, c1, c2, c3, c5, c7, nil];
    
    NSArray *columnArray = [[ClientSystemConfig getInstance] columnChooseArray];
    // 最高
    for (int i = 0; i < [columnArray count]; i++) {
        NSString *flag = [columnArray objectAtIndex:i];
        if (![flag isEqualToString:@"true"]) {
            //            if (i == 2) {
            //                continue;
            //            }
            [columWithArray replaceObjectAtIndex:i + 2 withObject:[NSNumber numberWithInt:0]];
        }
    }
    
    headData = [[NSMutableArray alloc]init];
    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"SellPrice"]];
    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"BuyPrice"]];
    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"Highest"]];
    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"Lowest"]];
    //    [headData addObject:[[LangCaptain getInstance] getLangByCode:@""]];
    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"UpDown"]];
    //    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"UpDownPercent"]];
    [headData addObject:[[LangCaptain getInstance] getLangByCode:@"UpdateTime"]];
    for (int i = 0; i < [columWithArray count]; i++) {
        if ([[columWithArray objectAtIndex:i] floatValue] < 0.00001) {
            [headData replaceObjectAtIndex:i withObject:@""];
        }
    }
    
    [self initQuote];
}

- (void)initQuote{
    
    // 若QG1001 已经返回 则从doc中取， 若没有，等QG1001返回自动更新
    Boolean inited = [QuoteDataStore getInited];
    isInited = inited;
    
    for (NSString * instName in [[ClientSystemConfig getInstance] getSelectedInstrumentArray]) {
        //        NSString *instrumentName = [instArray objectAtIndex:i];
        //        CDS_PriceSnapShot *pss = nil;
        QuoteItem *quoteItem = [[QuoteItem alloc] init];
        [quoteItem setInstrument:instName];
        [contentArray addObject:quoteItem];
        if (inited) {
            CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:instName];
            if (pss != nil && [pss instrumentName] != nil) {
                [self updateQuote:pss withItem:quoteItem];
            }
        }
    }
    //    }
}

#pragma mark - FreezeTableViewDataSource

- (NSArray *)arrayDataForTopHeader {
    return [headData copy];
}

- (NSArray *)arrayDataForContent{
    return [contentArray copy];
}

- (CGFloat)tableView:(FreezeTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    return [[columWithArray objectAtIndex:column] floatValue];
}

#pragma updateQuote
- (void)updateQuote:(CDS_PriceSnapShot *)data withItem:(QuoteItem *)item{
    if (data != nil && item != nil) {
        [item setInstrument:[data instrumentName]];
        Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[data instrumentName]];
        int extraDigit = [inst getExtraDigit];
        
        InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[data instrumentName]];
        //        [item setBid:[instUtil formatClientPrice:[data getBid] isFloor:true]];
        //        [item setAsk:[instUtil formatClientPrice:[data getAsk] isFloor:true]];
        [item setBid:[instUtil formatClientPrice:[data getBid]]];
        [item setAsk:[instUtil formatClientPrice:[data getAsk]]];
        [item setHighPrice:[instUtil formatClientPrice:[data highPrice] isFloor:true]];
        [item setLowPricel:[instUtil formatClientPrice:[data lowPrice] isFloor:false]];
        [item setExtradigit:extraDigit];
        
        if ([QuoteDataStore getInited]) {
            CDS_PriceSnapShot *pps = [[QuoteDataStore getInstance] getLastQuoteData:[data instrumentName]];
            
            if (([data getBid] - [pps getBid]) > 0.000001 || ([data getAsk] - [pps getAsk]) > 0.000001) {
                [item setUpDown:UP];
            }
            
            if (([data getBid] - [pps getBid]) < -0.000001 || ([data getAsk] - [pps getAsk]) < -0.000001) {
                [item setUpDown:DOWN];
            }
            
            if ((([data getBid] - [pps getBid]) <= 0.000001 && ([data getBid] - [pps getBid]) >= -0.000001) &&
                (([data getAsk] - [pps getAsk]) <= 0.000001 && ([data getAsk] - [pps getAsk]) >= -0.000001)) {
                [item setUpDown:NORMAL];
            }
        } else {
            [item setUpDown:NORMAL];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(long long)[data snapshotTime] / 1000.0];
        [item setQuoteTime:[JEDIDateTime timeStringFromDate:date]];
        [item setUpDownPrice:[instUtil formatClientPrice:([data getBid] - [data yClosePrice])]];
        [item setUpDownPricePercent:[DecimalUtil formatPercent:([data getBid] - [data yClosePrice]) / [data yClosePrice] withDigist:2]];
    }
}

#pragma recive listener

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot{
    if(snapshot == nil){
        return;
    }
    JEDI_SYS_Try{
        QuoteItem * item = nil;
        @synchronized(contentArray){
            NSString * insName = [snapshot instrumentName];
            for(int i=0; i<contentArray.count; ++i){
                item = [contentArray objectAtIndex:i];
                if(item && [[item instrument] isEqualToString:insName]){
                    [self updateQuote:snapshot withItem:item];
                    if (freezeTableView != nil) {
                        [freezeTableView updateCellQuoteAtIndex:i];
                    }
                    break;
                }
            }
        }
    }    JEDI_SYS_EndTry
}

#pragma updateTableView
- (void)reloadFreezeTable{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self != nil){
            [freezeTableView reloadData];
        }
    });
}

- (void)quoteListInit{
    [self initQuote];
    [self reloadFreezeTable];
}

- (void)reloadData{
    if (!inited) {
        [self quoteListInit];
    }
}

#pragma subviews frame

- (void)layoutSubviews{
    [super layoutSubviews];
    [floatPLStatus setFrame:CGRectMake(0.0f,
                                       0.0f,
                                       SCREEN_WIDTH,
                                       FloatPLStatusHeight)];
}

#pragma listener
- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
    [API_IDEventCaptain addListener:NAME_ON_QUOTELIST_INITED observer:self listener:@selector(quoteListInit)];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
    [API_IDEventCaptain removeListener:NAME_ON_QUOTELIST_INITED observer:self];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [freezeTableView setDatasource:nil];
    [self removeListener];
    
    [floatPLStatus removeFromSuperview];
    floatPLStatus  = nil;
}

- (void)dealloc{
    
}

- (void)autoLandscape {
    [freezeTableView removeLongPressGesture];
    //    [freezeTableView removeTapPressGesture];
    [freezeTableView hiddenCell];
}

- (void)autoPortrait {
    [freezeTableView addLongPressGesture];
    //    [freezeTableView addTapPressGesture];
}

- (void)portrait:(int)state {
    [freezeTableView setFreezeTableViewState:state];
}

@end
