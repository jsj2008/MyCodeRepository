//
//  HedgingContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HedgingContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"

#import "HedgingSumView.h"
#import "UIColor+CustomColor.h"

#import "LangCaptain.h"
#import "APIDoc.h"
#import "Instrument.h"
#import "HedgingCellView.h"
#import "DecimalUtil.h"
#import "MTP4CommDataInterface.h"
#import "QuoteDataStore.h"
#import "ToCloseTradeNode.h"

#import "UIFormat.h"
#import "ShowAlert.h"
#import "TradeUtil.h"

#import "ClientAPI.h"
#import "TradeApi.h"
#import "IosLogic.h"
#import "CertificateUtil.h"
#import "TranslateUtil.h"
#import "CommDataUtil.h"
#import "PhonePinInputView.h"

#import "ClientSystemConfig.h"
#import "NSArraySortUtil.h"

#import "CustomFont.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

#define HedgingSumViewHeight 110
#define HedgingCellHeight 70

#define HedginConfirmButtonHeight 60

@interface HedgingContentView()<UITableViewDataSource, UITableViewDelegate, API_Event_QuoteDataStore, UIAlertViewDelegate>{
    NSString *_instrument;
    FloatPLStatus *floatPLStatus;
    HedgingSumView *hedgingSumView;
    
    NSMutableArray *selectArray;
}

@end

@implementation HedgingContentView

- (id)initWithFrame:(CGRect)frame instrument:(NSString *)instrument{
    if (self = [super initWithFrame:frame]) {
        _instrument = instrument;
        [self initFloatPLStatusBar];
        [self initHedgingSumView];
        [self initHedgingTableView];
        //        [self initLayout];
        
        [self initHedgingData];
        [self initConfirmButtonView];
        [self addListener];
    }
    return self;
}

- (void)initFloatPLStatusBar{
    floatPLStatus = [[FloatPLStatus alloc] init];
    [floatPLStatus setFrame:CGRectMake(0.0f,
                                       0.0f,
                                       SCREEN_WIDTH,
                                       FloatPLStatusHeight)];
    [self addSubview:floatPLStatus];
}

- (void)initHedgingSumView {
    
    hedgingSumView = [HedgingSumView newInstance];
    [hedgingSumView setFrame:CGRectMake(0, FloatPLStatusHeight, SCREEN_WIDTH, HedgingSumViewHeight)];
    
    [hedgingSumView.sellDirLabel setText:[[LangCaptain getInstance] getLangByCode:@"Sell"]];
    [hedgingSumView.buyDirLabel setText:[[LangCaptain getInstance] getLangByCode:@"Buy"]];
    [hedgingSumView.sellDirLabel setTextColor:[UIColor buySellLabelColor]];
    [hedgingSumView.buyDirLabel setTextColor:[UIColor buySellLabelColor]];
    
    [hedgingSumView.instrumentLabel setText:_instrument];
    
    [self updateHedgingSum];
    
    [hedgingSumView setBackgroundColor:[UIColor backgroundColor]];
    [self addSubview:hedgingSumView];
}

- (void)initHedgingTableView{
    
    CGRect tableViewRect = self.frame;
    tableViewRect.origin.y += FloatPLStatusHeight + HedgingSumViewHeight;
    tableViewRect.size.height -= FloatPLStatusHeight + HedgingSumViewHeight + HedginConfirmButtonHeight;
    
    [contentTableView setFrame:tableViewRect];
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    
    [self addSubview:contentTableView];
}

- (void)initConfirmButtonView {
    CGRect buttonViewRect = self.frame;
    buttonViewRect.origin.y = self.frame.size.height - HedginConfirmButtonHeight;
    buttonViewRect.size.height = HedginConfirmButtonHeight;
    UIView *buttonView = [[UIView alloc] initWithFrame:buttonViewRect];
    
    double width = SCREEN_WIDTH - 10 * 2;
    CGRect commitRect = CGRectMake(10, 10.0, width / 2 - 4.0f, 30.0f);
    CGRect cancelRect = CGRectMake(10.0 + width / 2 + 2.0f, 10.0, width / 2 - 4.0f, 30.0f);
    UIButton *commitButton      = [[UIButton alloc] initWithFrame:commitRect];
    UIButton *cancelButton      = [[UIButton alloc] initWithFrame:cancelRect];
    
    [buttonView setBackgroundColor:[UIColor backgroundColor]];
    [self addSubview:buttonView];
    [buttonView addSubview:commitButton];
    [buttonView addSubview:cancelButton];
    
    [commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ConfirmHedging"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:commitButton withCorner:20.0f];
    [UIFormat setComplexBlueButtonColor:commitButton];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cancelButton withCorner:20.0f];
    [UIFormat setComplexGrayButtonColor:cancelButton];
    
    [commitButton addTarget:self action:@selector(checkCA) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initHedgingData{
    NSArray *array = nil;
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] getAccount]];
    if (groupDoc != nil) {
        TradeDoc *tradeDoc  =[groupDoc getTradeDoc];
        array = [[tradeDoc getTTradeByAccountList:[[ClientAPI getInstance]getAccount]] mutableCopy];
    }
    //    NSArray *array = [[APIDoc getUserDocCaptain] getTradeArray];
    NSMutableArray *tempArray = [[NSMutableArray  alloc] init];
    if (array != nil && [array count] != 0) {
//        for (TTrade *trade in array) {
        for (int i = 0; i< [array count] ; i++){
            TTrade *trade = [array objectAtIndex:i];
            if ([[trade getInstrument] isEqualToString:_instrument]) {
                if ([trade getCorOrderID] == 0 ||
                    ([CommDataUtil isUptradeOrder:[trade getCorOrderID]] &&
                     [CommDataUtil isPriceReached:[trade getCorOrderID]])) {
                        [tempArray addObject:trade];
                    }
            }
        }
    }
    
    [self sortArray:tempArray];
    self.contentArray = tempArray;
    selectArray = [[NSMutableArray alloc] init];
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



#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentTableViewCell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HedgingCellView *cellView = [HedgingCellView newInstance];
    CGRect cellViewRect = CGRectMake(0, 0, SCREEN_WIDTH, HedgingCellHeight);
    [cellView setFrame:cellViewRect];
    [cell addSubview:cellView];
    
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int digist = [inst getDigits];
    
    TTrade *trade = [self.contentArray objectAtIndex:[indexPath row]];
    [cellView.instrumentLabel setText:_instrument];
    
    [cellView.buttonView setBackgroundColor:[UIColor clearColor]];
    
    if ([selectArray containsObject:trade]) {
        [cellView.buttonView setImage:[UIImage imageNamed:@"images/normal/checkbox_pressed"]];
    } else {
        [cellView.buttonView setImage:[UIImage imageNamed:@"images/normal/checkbox_normal"]];
    }
    
    
    NSString *ticket = [NSString stringWithFormat:@"%@  %lld(%d)", [[LangCaptain getInstance] getLangByCode:@"Ticket"], [trade getTicket], [trade getSplitno]];
    NSString *time = [JEDIDateTime stringUIFromDate:[trade getOpenTime]];
    NSString *amount = [DecimalUtil formatNumber:[trade getAmount]];
    NSString *floatPL = nil;
    if ([trade floatPL] >= 0.00001) {
        floatPL = [NSString stringWithFormat:@"+%@", [DecimalUtil formatMoney:[trade floatPL] digist:2]];
        [cellView.floatPLLabel setTextColor:[UIColor blueUpColor]];
    } else if([trade floatPL] <= -0.00001) {
        floatPL = [DecimalUtil formatMoney:[trade floatPL] digist:2];
        [cellView.floatPLLabel setTextColor:[UIColor redDownColor]];
    } else {
        floatPL = [DecimalUtil formatMoney:[trade floatPL] digist:2];
        [cellView.floatPLLabel setTextColor:[UIColor whiteColor]];
    }
    NSString *tradeDir = [trade getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"];
    NSString *openPrice = [DecimalUtil formatMoney:[trade getOpenprice] digist:digist];
    NSString *mktPrice = [NSString stringWithFormat:@"MKT: %@", [DecimalUtil formatMoney:[trade marketPrice] digist:digist]];
    
    [cellView.ticketLabel       setText:ticket];
    [cellView.timeLabel         setText:time];
    [cellView.amountLabel       setText:amount];
    [cellView.floatPLLabel      setText:floatPL];
    [cellView.tradeDirLabel     setText:tradeDir];
    [cellView.tradeDirLabel     setTextColor:[UIColor buySellLabelColor]];
    [cellView.openPriceLabel    setText:openPrice];
    [cellView.mktPriceLabel     setText:mktPrice];
    
    [cellView.ticketLabel       setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.timeLabel         setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [cellView.amountLabel       setFont:[CustomFont getCNNormalWithSize:15.0f]];
    [cellView.floatPLLabel      setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [cellView.tradeDirLabel     setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [cellView.openPriceLabel    setFont:[CustomFont getCNNormalWithSize:12.0f]];
    [cellView.mktPriceLabel     setFont:[CustomFont getCNNormalWithSize:12.0f]];
    
    [cellView setBackgroundColor:[UIColor backgroundColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HedgingCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTrade *selectTrade = [self.contentArray objectAtIndex:[indexPath row]];
    if ([selectArray containsObject:selectTrade]) {
        [selectArray removeObject:selectTrade];
    } else {
        [selectArray addObject:selectTrade];
    }
    [self updateHedgingSum];
    
    NSArray *reloadArray = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[indexPath row] inSection:0],nil];
    [tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
}

#pragma listener

- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
    [API_IDEventCaptain addListener:DATA_ON_Order_Changed observer:self listener:@selector(orderChange:)];
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

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:_instrument]) {
            [contentTableView reloadData];
        }
    });
}

#pragma updateData

- (void)orderChange:(NSNotification *)notify {
    // 有问题
    //    [QuoteDataStore removeQuoteReceiver:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self removeListener];
        [self initHedgingData];
        [contentTableView reloadData];
        //        [self addListener];
    });
    
    //    [QuoteDataStore addQuoteReceiver:self];
}

- (void)updateHedgingSum{
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int digist = [inst getDigits];
    
    double sellAmount = 0.0f;
    double buyAmount = 0.0f;
    double sellSum = 0.0f;
    double buySum = 0.0f;
    for (TTrade *trade in selectArray) {
        if ([trade getBuysell] == BUY) {
            buyAmount += [trade getAmount];
            buySum += [trade getAmount] * [trade getOpenprice];
        } else {
            sellAmount += [trade getAmount];
            sellSum += [trade getAmount] * [trade getOpenprice];
        }
    }
    
    [hedgingSumView.sellAmountLabel setText:[DecimalUtil formatNumber:sellAmount]];
    [hedgingSumView.buyAmountLabel setText:[DecimalUtil formatNumber:buyAmount]];
    hedgingSumView.sellAmount = sellAmount;
    hedgingSumView.buyAmount = buyAmount;
    if (sellAmount  <= 0.00001) {
        [hedgingSumView.sellAvgLabel setText:[DecimalUtil formatMoney:0 digist:digist]];
    } else {
        [hedgingSumView.sellAvgLabel setText:[DecimalUtil formatMoney:sellSum / sellAmount digist:digist]];
    }
    
    if (buyAmount <= 0.00001) {
        [hedgingSumView.buyAvgLabel setText:[DecimalUtil formatMoney:0 digist:digist]];
    } else {
        [hedgingSumView.buyAvgLabel setText:[DecimalUtil formatMoney:buySum / buyAmount digist:digist]];
    }
}

#pragma doTrade
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
        [self doHedgingTrade];
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
            [self doHedgingTrade];
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

- (void)doHedgingTrade{
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_5];
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    NSString *errNotice = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
    NSString *successNotice = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
    
    if (hedgingSumView.buyAmount < 0.00001 && hedgingSumView.sellAmount < 0.00001) {
        [[ShowAlert getInstance] showAlerViewWithTitle:errNotice andMessage:[[LangCaptain getInstance] getLangByCode:@"PleaseSelectHedgingTicket"]];
        return;
    }
    
    if (fabs(hedgingSumView.buyAmount - hedgingSumView.sellAmount) > 0.00001 ) {
        [[ShowAlert getInstance] showAlerViewWithTitle:errNotice andMessage:[[LangCaptain getInstance] getLangByCode:@"SellBuyNotSame"]];
        return;
    }
    
    if (![TradeUtil isLegalTradeAmount:hedgingSumView.sellAmount] || ![TradeUtil isLegalTradeAmount:hedgingSumView.buyAmount]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:errNotice andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountErr"]];
        return;
    }
    
    NSArray *buyTradeArray = [self getToCloseTradeNodeVec:true];
    NSArray *sellTradeArray = [self getToCloseTradeNodeVec:false];
    for (TTrade *trade in selectArray) {
        if (![CommDataUtil isUptradeOrder:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
            return;
        }
    }
    
    for (TTrade *trade in selectArray) {
        if (![CommDataUtil isPriceReached:[trade getCorOrderID]] && [trade getCorOrderID] != 0) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
            return;
        }
    }
    
    int checkCode = [TradeUtil isHeadgeTradeAmountValiedBuyTicket:buyTradeArray sellNodes:sellTradeArray];
    
    if (checkCode != CheckCode_Valid) {
        [[ShowAlert getInstance] showAlerViewWithTitle:errNotice andMessage:[TradeUtil transCheckCode:checkCode]];
        return;
    }
    
    IP_TRADESERV5102 *ip = [[TradeApi getInstance] createHedgeCFDTradeAccount:[[ClientAPI getInstance] getAccount]
                                                                   instrument:_instrument
                                                         toCloseBuyTradeNodes:buyTradeArray
                                                        toCloseSellTradeNodes:sellTradeArray];
    
    
    
    NSString *signature = [CertificateUtil getPkcs7sin:ip];
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_HedgeCFD *result = [[TradeApi getInstance] doHedgeCFDTrade:ip
                                                                     signature:signature];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            if ([result result] == RESULT_SUCCEED) {
                [[ShowAlert getInstance] showAlerViewWithTitle:successNotice andMessage:[[LangCaptain getInstance] getLangByCode:@"HedgingSuccess"]];
                [[[ShowAlert getInstance] alertView] setDelegate:self];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_6];
            } else {
                [[ShowAlert getInstance] showAlerViewWithTitle:errNotice andMessage:[[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]]];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_7];
            }
        });
        
    });
}

- (void)doCancel{
    [[IosLogic getInstance] gotoOpenPositionViewController];
}

- (NSArray *)getToCloseTradeNodeVec:(Boolean)buySell{
    NSMutableArray *closeArray = [[NSMutableArray alloc] init];
    for (TTrade *trade in selectArray) {
        ToCloseTradeNode *node = [[ToCloseTradeNode alloc] init];
        
        // buy
        if (buySell && [trade getBuysell] == BUY) {
            [node setTicket:[trade getTicket]];
            [node setSplitno:[trade getSplitno]];
            [node setAmount:[trade getAmount]];
            [closeArray addObject:node];
        }
        
        if (!buySell && !([trade getBuysell] == BUY)) {
            [node setTicket:[trade getTicket]];
            [node setSplitno:[trade getSplitno]];
            [node setAmount:[trade getAmount]];
            [closeArray addObject:node];
        }
    }
    return closeArray;
}

#pragma alert delegate
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //        [self initHedgingData];
        //        [contentTableView reloadData];
        //        [self initHedgingSumView];
        [[IosLogic getInstance] gotoClosePositionViewController];
    }
}

@end
