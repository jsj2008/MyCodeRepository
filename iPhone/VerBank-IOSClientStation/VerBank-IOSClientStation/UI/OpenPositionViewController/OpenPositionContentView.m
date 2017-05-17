//
//  OpenPositionContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OpenPositionContentView.h"
#import "LangCaptain.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "OpenPositionCellView.h"
#import "APIDoc.h"
#import "QuoteDataStore.h"
#import "MTP4CommDataInterface.h"
#import "UIColor+CustomColor.h"
#import "OpenPositionPopCellView.h"
#import "DecimalUtil.h"
#import "QuoteDataStore.h"
#import "API_IDEventCaptain.h"
#import "IosLogic.h"
#import "HedgingViewController.h"
#import "ClientAPI.h"
#import "ClosePositionPopView.h"
#import "UIFormat.h"
#import "ImageUtils.h"
#import "TradeApi.h"
#import "ShowAlert.h"
#import "ToCloseTradeNode.h"
#import "DataCenter.h"
#import "NSArraySortUtil.h"
#import "ClientSystemConfig.h"
#import "CertificateUtil.h"
#import "PhonePinInputView.h"
#import "TranslateUtil.h"
//#import "KChartView.h"
#import "KChartParam.h"
#import "CommDataUtil.h"
#import "CustomFont.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

#define OpenPositionPopCellViewTag 101
#define OpenPositionCellViewTag 100
#define OpenPositionPopButtonViewTag 99


#define PopCellHeigh 30
#define OpenPositionCellHeigh 100

static NSString *scrollInstrument = nil;
static NSString *scrollTicket = nil;

@interface OpenPositionContentView()<UITableViewDelegate, UITableViewDataSource, API_Event_QuoteDataStore>{
    FloatPLStatus *floatPLStatus;
    UIView *_backgroundView;
    TTrade *_closeTrade;
    NSObject *lock;
    
    //    UILongPressGestureRecognizer *contentlongPressGr;
    int scrollIndex;
    
    long long selectCloseTicket;
}

@end

@implementation OpenPositionContentView

#pragma init
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        lock = [[NSObject alloc] init];
        [self initFloatPLStatusBar];
        [self initOpenPositionTableView];
        selectCellIndex = _kDefaultSelectedCell;
        //        contentArray = [[APIDoc getUserDocCaptain] getTradeArray];
        [self initData];
        //        [self addListener];
        [self initBackgroundView];
        //        [self initPress];
        //        lock = [[NSObject alloc] init];
        //        [self scroll];
        scrollIndex = -1;
        selectCloseTicket = -1;
    }
    return self;
}

- (void)scroll {
    if (scrollInstrument != nil) {
        for (int i = 0; i < self.contentArray.count; i++) {
            TTrade *trade = [self.contentArray objectAtIndex:i];
            if ([[trade getInstrument] isEqualToString:scrollInstrument]) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                scrollIndex = i;
                [self refreshAtindex:scrollIndex];
                [contentTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
                scrollInstrument = nil;
                return;
            }
        }
        scrollInstrument = nil;
        return;
    }
    
    if (scrollTicket != nil) {
        for (int i = 0; i < self.contentArray.count; i++) {
            TTrade *trade = [self.contentArray objectAtIndex:i];
            NSString *ticket = [NSString stringWithFormat:@"%lld(%d)", [trade getTicket], [trade getSplitno]];
            if ([ticket isEqualToString:scrollTicket]) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                scrollIndex = i;
                [self refreshAtindex:scrollIndex];
                [contentTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
                scrollTicket = nil;
                return;
            }
        }
        scrollTicket = nil;
        return;
    }
    
}

- (void)refreshAtindex:(int)index {
    NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
    [reloadArray addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
}

- (UITapGestureRecognizer *)newShowKChartView {
    UITapGestureRecognizer *contentKChartPressGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKChartView:)];
    return contentKChartPressGr;
    //    [contentTableView addGestureRecognizer:contentlongPressGr];
}

- (UILongPressGestureRecognizer *)newHedgingPress {
    UILongPressGestureRecognizer *contentlongPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hedgingPress:)];
    contentlongPressGr.minimumPressDuration = 0.4;
    return contentlongPressGr;
    //    [contentTableView addGestureRecognizer:contentlongPressGr];
}

- (UITapGestureRecognizer *)newCloseTradePress {
    //    UITapGestureRecognizer *contentTapPressGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapCloseTrade:)];
    UITapGestureRecognizer *contentTapPressGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapCloseTrade:)];
    return contentTapPressGr;
}

- (void)showKChartView:(UIGestureRecognizer *)gesture {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_1];
    //    if(gesture.state == UIGestureRecognizerStateBegan){
    //        [super LongPressToDo:gesture];
    CGPoint point = [gesture locationInView:contentTableView];
    NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
    if(indexPath == nil) return ;
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    NSString *instrumentName = [trade getInstrument];
    [((LeftViewController *)[[[IosLogic getInstance] getWindow] rootViewController]) popKChartView:instrumentName];
    //    }
}


- (void)hedgingPress:(UIGestureRecognizer *)gesture {
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        //        [super LongPressToDo:gesture];
        CGPoint point = [gesture locationInView:contentTableView];
        NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        [super popCellLogic:indexPath];
        if ([indexPath row] == [self.contentArray count] - 1) {
            [contentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}

- (void)contentTapCloseTrade:(UIGestureRecognizer *)gesture {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_2];
    CGPoint point = [gesture locationInView:contentTableView];
    NSIndexPath * indexPath = [contentTableView indexPathForRowAtPoint:point];
    if(indexPath == nil) return ;
    [self docloseTrade:indexPath];
}

- (void)docloseTrade:(NSIndexPath *)indexPath {
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    selectCloseTicket = [trade getTicket];
    
    if (![CommDataUtil isUptradeOrder:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"CannotClosePosition"]];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"CannotClosePosition"]];
        return;
    }
    
    ClosePositionPopView *closeView = [ClosePositionPopView newInstance];
    [closeView setFrame:ClosePositionViewRect];
    _closeTrade = trade;
    
    [closeView.instrumentLabel setText:[trade getInstrument]];
    [closeView.amountLabel setText:[DecimalUtil formatNumber:[trade getAmount]]];
    NSString *buySell = [trade getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Sell"] : [[LangCaptain getInstance] getLangByCode:@"Buy"];
    [closeView.buySellLabel setText:buySell];
    
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[trade getInstrument]];
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]];
    int digist = [inst getDigits];
    
    NSString *mktPrice = [trade getBuysell] == BUY ? [DecimalUtil formatMoney:[pss getBid] digist:digist] : [DecimalUtil formatMoney:[pss getAsk] digist:digist];
    [closeView.priceLabel setText:mktPrice];
    
    [closeView setInstrument:[trade getInstrument]];
    [closeView setDigist:digist];
    [closeView setBuySell:[trade getBuysell] == BUY];
    
    [closeView.cancelButton addTarget:self action:@selector(closePositionCancel) forControlEvents:UIControlEventTouchUpInside];
    [closeView.commitButton addTarget:self action:@selector(checkCA) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:closeView];
    UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
    UIImage *backImage = [ImageUtils imageWithView:rootView];
    backImage = [backImage blurredImageWithRadius:kDefaultRadius iterations:kDefaultIterations tintColor:[UIColor blackColor]];
    _backgroundView.backgroundColor = [UIColor colorWithPatternImage:backImage];
    [_backgroundView addSubview:closeView];
    [rootView addSubview:_backgroundView];
}

- (void)initBackgroundView {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)initData {
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] getAccount]];
    if (groupDoc != nil) {
        TradeDoc *tradeDoc  =[groupDoc getTradeDoc];
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[tradeDoc getTTradeByAccountList:[[ClientAPI getInstance]getAccount]]];
        [self sortArray:tempArray];
        self.contentArray = tempArray;
    }
}

- (void)sortArray:(NSMutableArray *)array {
    switch ([[[ClientSystemConfig getInstance] openPositionSortType] intValue]) {
        case OpenPositionSortInstrument:
            // 多字段 排序 嵌套比較麻煩 ， 這樣比較方面 但效率低， 效率要求不高， 暫時這麼寫
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade getOpenprice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TTrade *trade in array) {
                [trade setSortTag:[trade getInstrument]];
            }
            [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
            break;
        case OpenPositionSortOpenPrice:
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade getOpenprice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        case OpenPositionSortFloatPL:
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade floatPL]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        case OpenPositionSortTradeTime:
            for (TTrade *trade in array) {
                [trade setSortTag:[JEDIDateTime stringUIFromDate:[trade getOpenTime]]];
            }
            [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
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

- (void)initOpenPositionTableView{
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight;
    tableViewRect.size.height -= FloatPLStatusHeight + buttonHeight;
    
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    [self addSubview:contentTableView];
    
    //    [super addLongPressGesture];
}

#pragma updateTableView

- (void)updateFloatPLandMktPrice:(TTrade *)trade view:(OpenPositionCellView *)openPositionView{
    
    NSString *floatPL = [DecimalUtil formatMoney:[trade floatPL] digist:2];
    if ([trade floatPL] > 0.0001) {
        floatPL = [NSString stringWithFormat:@"+%@", floatPL];
        [openPositionView.floatPLLabel setText:floatPL];
        [openPositionView.floatPLLabel setTextColor:[UIColor blueUpColor]];
    } else if([trade floatPL] < 0.0001 || [trade floatPL] > -0.0001){
        [openPositionView.floatPLLabel setText:floatPL];
        [openPositionView.floatPLLabel setTextColor:[UIColor redDownColor]];
    } else {
        [openPositionView.floatPLLabel setText:floatPL];
        [openPositionView.floatPLLabel setTextColor:[UIColor whiteColor]];
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]];
    int digist = [inst getDigits];
    
    CDS_PriceSnapShot *cds = [[QuoteDataStore getInstance] getQuoteData:[trade getInstrument]];
    NSString *mktPrice = [trade getBuysell] == BUY ? [DecimalUtil formatMoney:[cds getBid] digist:digist] : [DecimalUtil formatMoney:[cds getAsk] digist:digist];
    
    [openPositionView.mktPriceLabel setText:[NSString stringWithFormat:@"MKT:%@", mktPrice]];
    //    [openPositionView.priceBackgroundButton bringSubviewToFront:<#(UIView *)#>];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot{
    [self removeListener];
    @synchronized(lock) {
        NSString *instrumentName = [snapshot instrumentName];
        NSMutableArray *reloadArray = [[NSMutableArray alloc] init];
        //        NSMutableArray *tempArray = [self.contentArray mutableCopy];
        for (int i = 0; i < [self.contentArray count]; i++) {
            TTrade *trade = [self.contentArray objectAtIndex:i];
            if (trade == nil) {
                break;
            }
            if ([[trade getInstrument] isEqualToString:instrumentName]) {
                [reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [contentTableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
        });
    }
    [self addListener];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *cellID = @"contentTableViewCell";
    NSString *cellID = [NSString stringWithFormat:@"contentTableViewCell%ld", (long)[indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //        cell.textLabel.font = [UIFont systemFontOfSize:15];
    //    }
    
    OpenPositionCellView *cellView = nil;
    OpenPositionPopCellView *popCell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGRect cellRect = cell.frame;
        cellRect.size.height = OpenPositionCellHeigh - 2;
        cellView = [[OpenPositionCellView alloc] initWithFrame:cellRect];
        [cellView.leftClickView addGestureRecognizer:[self newShowKChartView]];
        [cellView.rightClickView addGestureRecognizer:[self newHedgingPress]];
        [cellView.rightClickView addGestureRecognizer:[self newCloseTradePress]];
        
        [cellView setTag:OpenPositionCellViewTag];
        [cell addSubview:cellView];
        
        CGRect popCellRect = CGRectMake(0, OpenPositionCellHeigh, SCREEN_WIDTH, PopCellHeigh);
        popCell = [[OpenPositionPopCellView alloc] initWithFrame:popCellRect];
        [popCell setTag:OpenPositionPopButtonViewTag];
        [cell addSubview:popCell];
        [popCell.hedgingButton addTarget:self action:@selector(clickHedgingButton) forControlEvents:UIControlEventTouchUpInside];
        
        // view instert button 无法响应 暂时使用这个方法，以后修改
        UIButton *tempButton = [[UIButton alloc] initWithFrame:cellView.priceBackgroundButton.frame];
        [cell addSubview:tempButton];
        [tempButton addTarget:self action:@selector(jumpToOrderOpenAddOrModifyViewController:) forControlEvents:UIControlEventTouchUpInside];
        [cell setBackgroundColor:[UIColor backgroundColor]];
    } else {
        cellView = [cell viewWithTag:OpenPositionCellViewTag];
        popCell = [cell viewWithTag:OpenPositionPopButtonViewTag];
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]];
    int digist = [inst getDigits];
    
    NSString *ticket = [NSString stringWithFormat:@"%@ %lld(%d)",[[LangCaptain getInstance] getLangByCode:@"Ticket"], [trade getTicket], [trade getSplitno]];
    NSString *openTime = [JEDIDateTime stringUIFromDate:[trade getOpenTime]];
    NSString *amount = [DecimalUtil formatNumber:[trade getAmount]];
    
    NSString *buyOrSell = [trade getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"];
    NSString *openPrice = [DecimalUtil formatMoney:[trade getOpenprice] digist:digist];
    
    TOrder *order = [[APIDoc getUserDocCaptain] getOrder:[trade getCorOrderID]];
    NSString *limit = [DecimalUtil formatZeroMoney:[order getLimitPrice] digist:digist];
    NSString *limitPrice = [NSString stringWithFormat:@"%@ %@", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"], limit];
    NSString *stop = [DecimalUtil formatZeroMoney:[order getCurrentStopPrice] digist:digist];
    NSString *stopPrice = [NSString stringWithFormat:@"%@ %@", [[LangCaptain getInstance] getLangByCode:@"StopPrice"], stop];
    NSString *stopMove = [DecimalUtil formatZeroMoney:[order getStopMoveGap] digist:0];
    NSString *stopMovePrice = [NSString stringWithFormat:@"%@ %@", [[LangCaptain getInstance] getLangByCode:@"StopMovePrice"], stopMove];
    
    [cellView.ticketLabel setText:ticket];
    [cellView.tradeTimeLabel setText:openTime];
    [cellView.instrumentLabel setText:[trade getInstrument]];
    [cellView.amountLabel setText:amount];
    [cellView.buyOrSellLabel setText:buyOrSell];
    [cellView.openPriceLabel setText:openPrice];
    [cellView.limitPriceLabel setText:limitPrice];
    [cellView.stopPriceLabel setText:stopPrice];
    [cellView.moveStopPriceLabel setText:stopMovePrice];
    
    [self updateFloatPLandMktPrice:trade view:cellView];
    
    if (scrollIndex == [indexPath row]) {
        [cellView setBackgroundColor:[UIColor floatPLStatusBarColor]];
    }
    
    if (selectCellIndex == [indexPath row]) {
        [popCell setHidden:false];
    } else {
        [popCell setHidden:true];
    }
    
    return cell;
}

- (void)jumpToOrderOpenAddOrModifyViewController:(id)sender {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_8];
    UITableViewCell *cell = (UITableViewCell *)[sender superview];
    NSIndexPath *path = [contentTableView indexPathForCell:cell];
    
    TTrade *trade = [self.contentArray objectAtIndex:[path row]];
    if (![CommDataUtil isUptradeOrder:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    [[DataCenter getInstance] setTrade:trade];
    [[IosLogic getInstance] gotoOrderOpenAddOrModifyViewController];
    //    [[DataCenter getInstance] setTrade:<#(TTrade *)#>];
}

- (void)clickHedgingButton{
    [HedgingViewController setInstrumentName:[[self.contentArray objectAtIndex:selectCellIndex] getInstrument]];
    [[IosLogic getInstance] gotoHedgingViewController];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == selectCellIndex) {
        return PopCellHeigh + OpenPositionCellHeigh;
    }
    return OpenPositionCellHeigh;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)closePositionCancel {
    [[_backgroundView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_backgroundView removeFromSuperview];
    _closeTrade = nil;
    selectCloseTicket = -1;
}

- (void)checkCA {
    Boolean isLoadRsakey = [CertificateUtil isLoadedRsaKey];
    // 先这么写方便测试！
    if (!isLoadRsakey) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"CANotLoaded"]];
        return;
    }
    
    if (![CertificateUtil checkCertState]) {
        FnCertState *caState = [[DataCenter getInstance] fnCertState];
        if (caState == nil) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:[[DataCenter getInstance] fnCertResult]]];
        } else {
            int state = [caState getCaState];
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[TranslateUtil translateCA:state]];
        }
        return;
    }
    
    Boolean isNeedReputPhonePin = [CertificateUtil checkPhonePinByValidate];
    if (isNeedReputPhonePin) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        PhonePinInputView *phonePinInputView = [PhonePinInputView newInstance];
        [phonePinInputView setFrame:InputPinViewRect];
        UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
        [rootView addSubview:backView];
        [backView addSubview:phonePinInputView];
        [phonePinInputView.inputFeild setText:@""];
        [phonePinInputView.cancelButton addTarget:self
                                           action:@selector(phonePinCancel:)
                                 forControlEvents:UIControlEventTouchUpInside];
        [phonePinInputView.commitButton addTarget:self
                                           action:@selector(phonePinCommit:)
                                 forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self doClosePositionAction];
    }
}

- (void)phonePinCancel:(id)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)phonePinCommit:(id)sender {
    [[(PhonePinInputView *)[sender superview] inputFeild] resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        long long account = [[ClientAPI getInstance] getAccount];
        NSString *phonePin = ((PhonePinInputView *)[sender superview]).inputFeild.text;
        if (phonePin == nil || [phonePin isEqualToString:@""]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinIsNil"]];
            return;
        }
        int checkType = [[TradeApi getInstance] checkAccount:account
                                                    phonePin:phonePin];
        if (checkType == CA_TRADE_SUCCEED) {
            [[DataCenter getInstance] setPhonePin:phonePin];
            [[DataCenter getInstance] resetPhonePinErr];
            [CertificateUtil resetTimeTickIsEnterBackground:false];
            [[[sender superview] superview] removeFromSuperview];
            [self doClosePositionAction];
        } else if (checkType == USERIDENTIFY_RESULT_ERR_NETERR) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"ERR_NetErr"]];
        } else {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinErr"]];
            [[DataCenter getInstance] phonePinErr];
        }
    });
}

- (void)doClosePositionAction {
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    Boolean isBuySell = [_closeTrade getBuysell] == BUY;
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[_closeTrade getInstrument]];
    double price = isBuySell ? [pss getAsk] : [pss getBid];
    
    ToCloseTradeNode *node = [[ToCloseTradeNode alloc] init];
    [node setAmount:[_closeTrade getAmount]];
    [node setSplitno:[_closeTrade getSplitno]];
    [node setTicket:[_closeTrade getTicket]];
    
    IP_TRADESERV5101 * ip = [[TradeApi getInstance] createMktCFDTradeIPAccount:[[ClientAPI getInstance] getAccount]
                                                                instrumentName:[_closeTrade  getInstrument]
                                                                  isBuyNotSell:!isBuySell
                                                                        amount:[_closeTrade getAmount]
                                                                         price:price
                                                                   mktPirceGap:0
                                                             toCloseTradeNodes:[[NSArray alloc] initWithObjects:node, nil]
                                                               toOpenTradeNode:nil
                                                                  IFDStopPrice:0.0f
                                                                 IFDLimitPrice:0.0f];
    NSString *signature = [CertificateUtil getPkcs7sin:ip];
    //    if (signature == nil) {
    //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
    //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"SignFailed"]];
    //        return;
    //    }
    
    // ca 签名
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:_backgroundView];
    [self removeListener];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_MktCFD *result = [[TradeApi getInstance] doMKTCFDTrade:ip
                                                                 signature:signature];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            if ([result result] == RESULT_SUCCEED) {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"ClosePositionSuccess"]];
                [self closePositionCancel];
                //                [[IosLogic getInstance] gotoOpenPositionViewController];
                [[IosLogic getInstance] gotoClosePositionViewController];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_3];
            } else {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]]];
                [self addListener];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_4];
            }
        });
    });
}

#pragma listener
- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
    [API_IDEventCaptain addListener:DATA_ON_Trade_Changed observer:self listener:@selector(tradeChange:)];
    [API_IDEventCaptain addListener:DATA_ON_Order_Changed observer:self listener:@selector(tradeChange:)];
}

- (void)tradeChange:(NSNotification *)notify {
    // 有问题
    //    [QuoteDataStore removeQuoteReceiver:self];
    [self removeListener];
    @synchronized(lock) {
        [self initData];
        
        //        NSArray *tempArray = [contentArray mutableCopy];
        //        for (TTrade *trade in contentArray) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [contentTableView reloadData];
        });
        for (int i = 0; i < [self.contentArray count]; i++) {
            //            if ([trade getTicket] == selectCloseTicket) {
            if ([[self.contentArray objectAtIndex:i] getTicket] == selectCloseTicket) {
                return;
            }
        }
        [self closePositionCancel];
    }
    
    //    [QuoteDataStore addQuoteReceiver:self];
    [self addListener];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
    [API_IDEventCaptain removeListener:DATA_ON_Trade_Changed observer:self];
    [API_IDEventCaptain removeListener:DATA_ON_Order_Changed observer:self];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self removeListener];
    
    [floatPLStatus removeFromSuperview];
    floatPLStatus = nil;
}

+ (void)setSelectInstrument:(NSString *)instrument {
    scrollInstrument = instrument;
}

+ (void)setSelectTicket:(NSString *)ticket {
    scrollTicket = ticket;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [contentTableView reloadData];
}

// 通过插入cell的形式来 完成popcell的操作
// 想到另一种实现方式，暂时不删掉
//- (void)restoreTableCell{
//    if (popCellIndex != -1) {
//        [self resetCellStateatView:OpenPositionCellViewTag index:popCellIndex - 1 isSelect:false];
//        NSMutableArray *deleteIndexPathArray = [[NSMutableArray alloc] init];
//        NSIndexPath *deletePath = [NSIndexPath indexPathForRow:popCellIndex inSection:0];
//        [tradeArray removeObjectAtIndex:popCellIndex];
//        popCellIndex = -1;
//        [deleteIndexPathArray addObject:deletePath];
//        [openPositionTableView deleteRowsAtIndexPaths:deleteIndexPathArray withRowAnimation:UITableViewRowAnimationNone];
//    }
//}
//
//- (void)popTableCell{
//    NSMutableArray *addIndexPathArray = [[NSMutableArray alloc] init];
//    if (popCellIndex >=0) {
//        [self resetCellStateatView:OpenPositionCellViewTag index:popCellIndex - 1 isSelect:true];
//        NSIndexPath *addPath = [NSIndexPath indexPathForRow:popCellIndex inSection:0];
//        [tradeArray insertObject:popCellKey atIndex:popCellIndex];
//        [addIndexPathArray addObject:addPath];
//        [openPositionTableView insertRowsAtIndexPaths:addIndexPathArray withRowAnimation:UITableViewRowAnimationNone];
//    }
//}
//
//- (void)popLogic:(NSIndexPath *)indexPath{
//
//    int tempSelectIndex = popCellIndex;
//    // 选中的是pop栏 return
//    if ([indexPath row] == tempSelectIndex) {
//        return;
//    }
//
//    // 还原TableView
//    [self restoreTableCell];
//
//    // 选中的 是已经回收的那一栏
//    if ([indexPath row] == (tempSelectIndex - 1)) {
//        popCellIndex = -1;
//        return;
//    }
//
//    // 选中的小于原先选中的栏 或原先什么都没选
//    if ([indexPath row] < (tempSelectIndex - 1) || tempSelectIndex == -1) {
//        popCellIndex = (int)[indexPath row] + 1;
//    } else {
//        popCellIndex = (int)[indexPath row];
//    }
//
//    [self popTableCell];
//}

// 通过 将cell的高度变宽的方式实现
// 无法 解决隐藏问题

//- (void)popCellAction:(int)index{
//    if (index == popCellIndex) {
//        popCellIndex = -1;
//        [self resetCellStateatView:OpenPositionPopCellViewTag index:index hiden:true];
//    } else {
//        if (popCellIndex != -1) {
//             [self resetCellStateatView:OpenPositionPopCellViewTag index:popCellIndex hiden:true];
//        }
//        popCellIndex = index;
//        [self resetCellStateatView:OpenPositionPopCellViewTag index:popCellIndex hiden:false];
//    }
//}

//- (void)resetCellStateatView:(int)tag index:(int)index isSelect:(Boolean)select{
//    UITableViewCell *cell = [cellDic objectForKey:[self getTradeKey:[tradeArray objectAtIndex:index]]];
//    OpenPositionCellView *openView = (OpenPositionCellView *)[cell viewWithTag:tag];
//    [openView setIsSelected:select];
//}

@end
