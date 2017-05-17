//
//  OrderPositionContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderPositionContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "APIDoc.h"
#import "OrderPositionCellView.h"
#import "LangCaptain.h"
#import "MTP4CommDataInterface.h"
#import "DecimalUtil.h"
#import "UIFormat.h"
#import "QuoteDataStore.h"
#import "IosLogic.h"
#import "ClientAPI.h"
#import "OrderAddOrModifyViewController.h"

#import "API_IDEventCaptain.h"
#import "NSArraySortUtil.h"
#import "ClientSystemConfig.h"
#import "ShowAlert.h"
#import "KChartView.h"
#import "CustomFont.h"

#define OrderPositionCellHeigh 115

static NSString *scrollOrderId = nil;

@interface OrderPositionContentView()<UITableViewDataSource, UITableViewDelegate, API_Event_QuoteDataStore>{
    FloatPLStatus *floatPLStatus;
    //    UITapGestureRecognizer * limitViewListener;
    int scrollIndex;
    
    NSObject *lock;
}

@end

@implementation OrderPositionContentView

#pragma init
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        lock = [[NSObject alloc] init];
        [self initFloatPLStatusBar];
        [self initOrderPositionTableView];
        //        contentArray = [[APIDoc getUserDocCaptain] getOrderArray];
        [self initData];
        //        [self initLimitViewListener];
        //        [self addListener];
        [self initPress];
        scrollIndex = -1;
    }
    return self;
}

- (UITapGestureRecognizer *)newLimitViewListener {
    UITapGestureRecognizer *limitViewListenera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderModifyClick:)];
    return limitViewListenera;
}

- (void)initPress {
    longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(contentLongPressToDo:)];
    longPressGr.minimumPressDuration = 0.8;
    [contentTableView addGestureRecognizer:longPressGr];
}

//- (void)initLimitViewListener {
//    limitViewListener = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderModifyClick:)];
//}

- (void)initData {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] getAccount]];
    if (groupDoc != nil) {
        OrderDoc *orderDoc = [groupDoc getOrderDoc];
        //        contentArray = [[NSMutableArray alloc] init];
        NSMutableArray *tempArray = [[orderDoc getTOrderByAccountList:[[ClientAPI getInstance] getAccount]] mutableCopy];
        //        for (TOrder *order in tempArray) {
        for (int i = 0; i < [tempArray count]; i++) {
            TOrder *order = [tempArray objectAtIndex:i];
            if ([order getType] == ORDERTYPE_NORMAL) {
                [array addObject:order];
            }
        }
        [self sortArray:array];
    }
    self.contentArray = array;
}

- (void)sortArray:(NSMutableArray *)array {
    switch ([[[ClientSystemConfig getInstance] orderSortType] intValue]) {
        case OrderSortInstrument:
            for (TOrder *order in array) {
                [order setSortTag:[@([order getCurrentStopPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getLimitPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            
            for (TOrder *order in array) {
                [order setSortTag:[@([order getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[order getInstrument]];
            }
            [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
            break;
        case OrderSortDESC:
            for (TOrder *order in array) {
                [order setSortTag:[@([order getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getCurrentStopPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getLimitPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        case OrderSortASC:
            for (TOrder *order in array) {
                [order setSortTag:[@([order getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getCurrentStopPrice]) stringValue]];
            }
            [NSArraySortUtil sortASCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                if ([order getLimitPrice] <= 0.0f) {
                    [order setSortTag:[@(INTMAX_MAX) stringValue]];
                } else {
                    [order setSortTag:[@([order getLimitPrice]) stringValue]];
                }
            }
            [NSArraySortUtil sortASCNumberArray:array sortSelector:@"sortTag"];
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

- (void)initOrderPositionTableView{
    
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight;
    tableViewRect.size.height -= FloatPLStatusHeight + buttonHeight;
    
    //    contentTableView = [[UITableView alloc] initWithFrame:tableViewRect];
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    //    contentTableView.bounces = NO;
    //    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    contentTableView.showsVerticalScrollIndicator = NO;
    //
    //    contentTableView.backgroundColor = [UIColor backgroundColor];
    [self addSubview:contentTableView];
    //    [super addPressGesture];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    OrderPositionCellView *cellView = [OrderPositionCellView newInstance];
    CGRect cellViewRect = CGRectMake(0, 0, SCREEN_WIDTH, OrderPositionCellHeigh);
    [cellView setFrame:cellViewRect];
    
    TOrder *order = [self.contentArray  objectAtIndex:[indexPath row]];
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]];
    int digist = [inst getDigits];
    
    //    QuoteData *quoteData = [[APIDoc getSystemDocCaptain] getQuote:[order getInstrument]];
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[order getInstrument]];
    double marketPrice = 0.0f;
    if ([order getBuysell] == BUY) {
        marketPrice = [pss getAsk];
    } else {
        marketPrice = [pss getBid];
    }
    
    NSString *ticket = [NSString stringWithFormat:@"%@    %lld",[[LangCaptain getInstance] getLangByCode:@"Ticket"], [order getOrderID]];
    
    NSString *type = [[LangCaptain getInstance] getExpireType:[order getExpireType]];
    NSString *time = @"";
    if ([order getExpireType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        time = [JEDIDateTime stringHHmmFromDate:[order getExpiryTime]];
    }
    
    NSString *instrument = [order getInstrument];
    NSString *buySell = [order getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"];
    NSString *amount = [DecimalUtil formatNumber:[order getAmount]];
    
    
    [cellView.ticketLabel setText:ticket];
    [cellView.typeLabel setText:type];
    [cellView.timeLabel setText:time];
    [cellView.instrumentLabel setText:instrument];
    [cellView.tradeDirLabel setText:buySell];
    [cellView.tradeDirLabel setTextColor:[UIColor buySellLabelColor]];
    [cellView.amountLabel setText:amount];
    
    [cellView.limitPriceView setBackgroundColor:[UIColor bluePriceBackgroundViewColor]];
    
    CGRect rect = cellView.limitPriceView.frame;
    rect.size.width = SCREEN_WIDTH - 20;
    cellView.limitPriceView.frame = rect;
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cellView.limitPriceView withCorner:8.0f];
    [cellView.limitPriceView setNeedsDisplay];
    
    // string
    [cellView.limitNameLabel setText:[[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    [cellView.stopNameLabel setText:[[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    [cellView.stopMoveNameLabel setText:[[LangCaptain getInstance] getLangByCode:@"StopMovePrice"]];
    [cellView.IDTLimitNameLabel setText:[NSString stringWithFormat:@"IDT%@", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"]]];
    [cellView.IDTStopNameLabel setText:[NSString stringWithFormat:@"IDT%@", [[LangCaptain getInstance] getLangByCode:@"StopPrice"]]];
    
    // value
    NSString *limitPrice = [DecimalUtil formatZeroMoney:[order getLimitPrice] digist:digist];
    NSString *stopPrice = [DecimalUtil formatZeroMoney:[order getCurrentStopPrice] digist:digist];
    NSString *stopMovePrice = [order getStopMoveGap] == 0 ? @"" : [@([order getStopMoveGap]) stringValue];
    
    if ((![limitPrice isEqualToString:@""]) && (![stopPrice isEqualToString:@""])) {
        [cellView.ocoLabel setHidden:false];
    } else{
        [cellView.ocoLabel setHidden:true];
    }
    
    NSString *IDTLimitPrice = [DecimalUtil formatZeroMoney:[order getIFDLimitPrice] digist:digist];
    NSString *IDTStopPrice = [DecimalUtil formatZeroMoney:[order getIFDStopPrice] digist:digist];
    
    //    NSString *limitDistance = [self priceValue:[order getLimitPrice] - marketPrice digist:digist];
    //    NSString *stopDistance = [self priceValue:[order getCurrentStopPrice] - marketPrice digist:digist];
    
    // 不需要显示正负
    NSString *limitDistance = [DecimalUtil formatMoney:fabs([order getLimitPrice] - marketPrice) digist:digist];
    NSString *stopDistance = [DecimalUtil formatMoney:fabs([order getCurrentStopPrice] - marketPrice) digist:digist];
    
    [cellView.stopDistanceLabel setTextColor:[UIColor orderStop]];
    
    [cellView.limitDistanceLabel setTextColor:[UIColor orderLimit]];
    
    if ([order getLimitPrice] > -0.00001 && [order getLimitPrice] < 0.00001) {
        limitDistance = @"";
    }
    
    if ([order getCurrentStopPrice] > -0.00001 && [order getCurrentStopPrice] < 0.00001) {
        stopDistance = @"";
    }
    
    [cellView.limitPriceLabel setText:limitPrice];
    [cellView.stopPriceLabel setText:stopPrice];
    [cellView.stopMoveValueLabel setText:stopMovePrice];
    [cellView.IDTLimitValueLabel setText:IDTLimitPrice];
    [cellView.IDTStopValueLabel setText:IDTStopPrice];
    
    [cellView.limitDistanceLabel setText:limitDistance];
    [cellView.stopDistanceLabel setText:stopDistance];
    
    [cellView.ticketLabel           setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.timeLabel             setFont:[CustomFont getCNNormalWithSize:10.0f]];
    
    [cellView.instrumentLabel       setFont:[CustomFont getCNNormalWithSize:15.0f]];
    [cellView.tradeDirLabel         setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [cellView.amountLabel           setFont:[CustomFont getCNNormalWithSize:18.0f]];
    
    [cellView.limitNameLabel        setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.stopNameLabel         setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.IDTLimitNameLabel     setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.IDTStopNameLabel      setFont:[CustomFont getCNNormalWithSize:12.0f]];
    
    [cellView.limitDistanceLabel    setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.stopDistanceLabel     setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.IDTLimitValueLabel    setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.IDTStopValueLabel     setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.limitPriceLabel       setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.stopPriceLabel        setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.ocoLabel              setFont:[CustomFont getCNNormalWithSize:11.0f]];
    [cellView.typeLabel             setFont:[CustomFont getCNNormalWithSize:10.0f]];
    
    
    // 不需要显示
    //    [cellView.marketPrice setText:[DecimalUtil formatZeroMoney:marketPrice digist:digist]];
    //    [cellView.marketPrice setHidden:true];
    
    [cell addSubview:cellView];
    [cellView setBackgroundColor:[UIColor backgroundColor]];
    [cell setBackgroundColor:[UIColor backgroundColor]];
    [cellView.limitPriceView addGestureRecognizer:[self newLimitViewListener]];
    //    NSLog(@"%@, %lld, %@", [pss instrumentName], [order getOrderID], ticket);
    //        [cellView addGestureRecognizer:limitViewListener];
    //    cellView.limitPriceView addtar
    
    if (scrollIndex == [indexPath row]) {
        [cellView setBackgroundColor:[UIColor floatPLStatusBarColor]];
    }
    
    return cell;
}

- (NSString *)priceValue:(double)price digist:(int)digist{
    return price < -0.00001 ? [DecimalUtil formatZeroMoney:price digist:digist] : [NSString stringWithFormat:@"+%@", [DecimalUtil formatZeroMoney:price digist:digist]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return OrderPositionCellHeigh;
}

#pragma updateTable data

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot{
    if (snapshot == nil) {
        return;
    }
    @synchronized (lock) {
        //        @synchronized(contentArray) {
        NSString *instrumentName = [snapshot instrumentName];
        NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.contentArray  count]; i++) {
            TTrade *trade = [self.contentArray  objectAtIndex:i];
            if ([[trade getInstrument] isEqualToString:instrumentName]) {
                //                    NSLog(@"rec quote %@, index is %lu", instrumentName, (unsigned long)[contentArray indexOfObject:trade]);
                [reloadArray addObject:[NSIndexPath indexPathForRow:[self.contentArray  indexOfObject:trade] inSection:0]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([reloadArray count] != 0) {
                [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
            }
            //        }
        });
    }
    
}

#pragma listener

- (void)contentLongPressToDo:(UIGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:contentTableView];
        NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        TOrder *order = [self.contentArray  objectAtIndex:[indexPath row]];
        NSString *instrumentName = [order getInstrument];
        [((LeftViewController *)[[[IosLogic getInstance] getWindow] rootViewController]) popKChartView:instrumentName];
    }
}

- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
    
    //    [API_IDEventCaptain fireEventChanged:DATA_ON_Order_Changed eventData:[@([tinfo getAccountID]) stringValue]];
    [API_IDEventCaptain addListener:DATA_ON_Order_Changed observer:self listener:@selector(orderChange:)];
}

- (void)orderChange:(NSNotification *)notify {
    // 有问题
    //    [QuoteDataStore removeQuoteReceiver:self];
    @synchronized (lock) {
        [self initData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //        [self removeListener];
            [contentTableView reloadData];
            //        [self addListener];
        });
    }
    //    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
    [API_IDEventCaptain removeListener:DATA_ON_Order_Changed observer:self];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self removeListener];
    
    [floatPLStatus removeFromSuperview];
    floatPLStatus = nil;
}

#pragma action
- (void)orderModifyClick:(UIGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:contentTableView];
    NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
    if(indexPath == nil) return ;
    
    TOrder *order = [self.contentArray  objectAtIndex:[indexPath row]];
    
    if ([order getIsManual]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    if ([order getIsPriceReached]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    [[DataCenter getInstance] setOrder:order];
    [[DataCenter getInstance] setOrderInstrument:[order getInstrument]];
    [[IosLogic getInstance] gotoOrderAddOrModifyViewController];
}

#pragma ScrollOrderid
+ (void)setScrollOrderID:(NSString *)orderID {
    scrollOrderId = orderID;
}

- (void)scroll {
    if (scrollOrderId != nil) {
        for (int i = 0; i < self.contentArray .count; i++) {
            TOrder *order = [self.contentArray  objectAtIndex:i];
            NSString *orderId = [NSString stringWithFormat:@"%lld", [order getOrderID]];
            if ([scrollOrderId isEqualToString:orderId]) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                scrollIndex = i;
                [self refreshAtindex:scrollIndex];
                [contentTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
                scrollOrderId = nil;
                return;
            }
        }
        scrollOrderId = nil;
        return;
    }
}

- (void)refreshAtindex:(int)index {
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    [reloadArray addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
}

@end
