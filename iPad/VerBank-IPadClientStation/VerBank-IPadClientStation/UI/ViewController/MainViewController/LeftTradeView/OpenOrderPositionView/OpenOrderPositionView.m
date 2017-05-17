//
//  OpenOrderPositionView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenOrderPositionView.h"
#import "QuoteDataStore.h"
#import "ZLKeyboardView.h"
#import "LangCaptain.h"
#import "TextFieldController.h"
#import "APIDoc.h"
#import "JumpDataCenter.h"
#import "AccountUtil.h"
#import "DecimalUtil.h"
#import "CommDataUtil.h"
#import "LayoutCenter.h"
#import "BlackgroundTextField.h"
#import "ShowAlertManager.h"
#import "CheckUtils.h"
#import "TradeActionUtil.h"
#import "CheckWarningNode.h"
#import "InstWarnConfig.h"
#import "WarningUtil.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface OpenOrderPositionView() <CustomSegmentProtocol, API_Event_QuoteDataStore, QuoteViewDelegate, ZLKeyboardDelegate, CustomAlertDelegate> {
    Boolean isAddOrModify;
}
@end

@implementation OpenOrderPositionView

@synthesize accountLabel;
@synthesize instrumentLabel;
@synthesize timeLabel;
@synthesize quoteView;
@synthesize segmentControl;
@synthesize ocoPageView;

- (void)initContent {
    [segmentControl setDelegate:self];
    [self setBackgroundColor:[UIColor blackColor]];
    // 以后根据 trade 初始化判断是limit oco stop
    //    [self.ocoPageView setIndex:2];
    //    [self.segmentControl setCurrentSelectIndex:2];
    
    //    [self.ocoPageView.limitView.commitButton    addTarget:self action:@selector(doOrderTrade) forControlEvents:UIControlEventTouchUpInside];
    //    [self.ocoPageView.stopView.commitButton     addTarget:self action:@selector(doOrderTrade) forControlEvents:UIControlEventTouchUpInside];
    //    [self.ocoPageView.ocoView.commitButton      addTarget:self action:@selector(doOrderTrade) forControlEvents:UIControlEventTouchUpInside];
    //    [self.ocoPageView.limitView.cancelButton    addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.ocoPageView.stopView.cancelButton     addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.ocoPageView.ocoView.cancelButton      addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    NSString *amountString = [NSString stringWithFormat:@"%@ :", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    [self.ocoPageView.limitView.amountLabel setText:amountString];
    [self.ocoPageView.stopView.amountLabel setText:amountString];
    [self.ocoPageView.ocoView.amountLabel setText:amountString];
    
    NSString *valueTimeString = [NSString stringWithFormat:@"%@ :", [[LangCaptain getInstance] getLangByCode:@"ValidDate"]];
    [self.ocoPageView.limitView.valueTimeLabel setText:valueTimeString];
    [self.ocoPageView.stopView.valueTimeLabel setText:valueTimeString];
    [self.ocoPageView.ocoView.valueTimeLabel setText:valueTimeString];
    
    [self.quoteView setDelegate:self];
    //    [self set];
    [self initKeyboard];
}

- (void)initKeyboard {
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLeftTradeNumber];
    for (UIView *view in [ocoPageView subviews]) {
        for (UIView *subView in [view subviews]) {
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                [TextFieldUtil removeShortCutItem:textField];
                [self initTextField:textField withZLKeyboard:inputView];
            }
        }
    }
    [inputView setKeyboardDelegate:self];
}

- (void)initTextField:(UITextField *)textField withZLKeyboard:(ZLKeyboardView *)inputView {
    textField.inputView = inputView;
    [textField setDelegate:(id)inputView];
}

#pragma segmentControl delegate
- (NSArray *)getSegmentNameArray {
    return [[NSArray alloc] initWithObjects:@"Limit", @"Stop", @"OCO", nil];
}

- (CGFloat)getButtobMiddleAdge {
    return 2.0f;
}

- (CGFloat)getCornerRadius{
    return 8.0f;
}

- (CGFloat)getCornerWidth{
    return 1.0f;
}

- (void)didClickButtonAtIndex:(NSUInteger)index {
    [[TextFieldController getInstance] keyboardReturen];
    [self.ocoPageView setIndex:index];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [ocoPageView setNeedsLayout];
}

#pragma override
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)updateView {
    [super updateView];
    Instrument *inst        = [[APIDoc getSystemDocCaptain] getInstrument:self.instrumentName];
    
    CDS_PriceSnapShot *pss  = [[QuoteDataStore getInstance] getQuoteData:self.instrumentName];
    if (pss == nil) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"UpdateFailed"]
                                                            delegate:nil];
        return;
    }
    
    
    [self.instrumentLabel setText:self.instrumentName];
    
    NSString *placeholder = [NSString stringWithFormat:@"%@ %@", [inst getCcy1], [DecimalUtil formatNumber:[CommDataUtil getDefaultCcy1Amount:self.instrumentName]]];
    self.ocoPageView.limitView.amountTextField.attributedPlaceholder    = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.ocoPageView.stopView.amountTextField.attributedPlaceholder     = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.ocoPageView.ocoView.amountTextField.attributedPlaceholder      = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    [self updateValue:pss];
    
    //    [self.ocoPageView resetInputValue];
    
    [self.quoteView setEditAble:false];
    TTrade *openOrderTrade = [[JumpDataCenter getInstance] openOrderTrade];
    if ([openOrderTrade getBuysell] == BUY) {
        [self.quoteView setSellStatus];
    } else {
        [self.quoteView setBuyStatus];
    }
    
    [self.ocoPageView.limitView.amountTextField setText:[DecimalUtil formatNumber:[openOrderTrade getAmount]]];
    [self.ocoPageView.stopView.amountTextField setText:[DecimalUtil formatNumber:[openOrderTrade getAmount]]];
    [self.ocoPageView.ocoView.amountTextField setText:[DecimalUtil formatNumber:[openOrderTrade getAmount]]];
    
    [self.ocoPageView initStopMoveGap:_instrumentName];
    
}

#pragma quoteDataStore

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:self.instrumentName]) {
            [self updateValue:snapshot];
        }
    });
}

// 更新时间 QuoteView 提示的价格
- (void)updateValue:(CDS_PriceSnapShot *)pss {
    [self updateTime:[pss snapshotTime]];
    [self updateQuoteViewAsk:[pss getAsk] bid:[pss getBid]];
    [self updatePriceNotice];
}


- (void)updateQuoteViewAsk:(double)ask bid:(double)bid{
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:self.instrumentName];
//    [self.quoteView.leftSubview      updateValue:[instUtil formatClientPrice:bid isFloor:true]];
//    [self.quoteView.rightSubview     updateValue:[instUtil formatClientPrice:ask isFloor:true]];
    [self.quoteView.leftSubview updateValue:[instUtil formatClientPrice:bid]];
    [self.quoteView.rightSubview updateValue:[instUtil formatClientPrice:ask]];
}

- (void)updateTime:(long long)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    [self.timeLabel setText:[JEDIDateTime stringUIFromTime:date]];
}

- (void)updatePriceNotice {
    
    Boolean isBuySell = [self.quoteView currentBuySell] == BUY ? true : false;
    
    NSString *limitSymbol   = [self getSymbleByBuySell:isBuySell
                                           LimitOrStop:LIMIT];
    NSString *stopSymbol    = [self getSymbleByBuySell:isBuySell
                                           LimitOrStop:STOP];
    if (self.instrumentName == nil || [self.instrumentName isEqualToString:@""]) {
        NSLog(@"get instrumentName failed !!!");
        return;
    }
    //    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:self.instrumentName];
    //    int self.digist = [inst getDigits];
    
    double limitPriceValue  = [CommDataUtil getLimitPrice:self.instrumentName   bunysell:isBuySell];
    double stopPriceValue   = [CommDataUtil getStopPrice:self.instrumentName    bunysell:isBuySell];
    
    NSString *limitPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    limitPrice = [limitPrice stringByAppendingFormat:@"%@%@):", limitSymbol, [DecimalUtil formatDoubleByNoStyle:limitPriceValue digit:self.digist]];
    
    NSString *stopPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    stopPrice = [stopPrice stringByAppendingFormat:@"%@%@):", stopSymbol, [DecimalUtil formatDoubleByNoStyle:stopPriceValue digit:self.digist]];
    
    [ocoPageView.limitView.limitPriceLabel  setText:limitPrice];
    [ocoPageView.stopView.stopPriceLabel    setText:stopPrice];
    [ocoPageView.ocoView.limitPriceLabel    setText:limitPrice];
    [ocoPageView.ocoView.stopPriceLabel     setText:stopPrice];
}

- (NSString *)getSymbleByBuySell:(Boolean)buySell LimitOrStop:(int)limitStop {
    NSString *symbol = nil;
    if (buySell) {
        symbol = limitStop == LIMIT ?  @"<" : @">";
    } else {
        symbol = limitStop == LIMIT ? @">" : @"<";
    }
    return symbol;
}

#pragma quoteView Delegate
- (void)didClickQuoteViewAtType:(int)buySellType {
    // buy sell type属性 暂时不需要
    [self updatePriceNotice];
}

#pragma dotrade
- (void)doTrade:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        NSInteger tag = [(UIButton *)sender tag];
        switch (tag) {
            case OrderTradeTypeAdd:
                [self doAddOpenOrder];
                break;
            case OrderTradeTypeModify:
                [self doModifyOpenOrder];
                break;
            default:
                break;
        }
    }
}

- (void)doAddOpenOrder {
    SegmentTradeType type   = self.segmentControl.currentSelectIndex;
    double amount           = [self.ocoPageView getAmountByType:type];
    double limitPrice       = [self.ocoPageView getLimitValueByTradeType:type];
    double stopPrice        = [self.ocoPageView getStopValueByTradeType:type];
    double stopMoveGap = [self.ocoPageView getStopMoveValueByType:type];
    int minMoveStopGap = [[[APIDoc getSystemDocCaptain] getInstrument:_instrumentName] getMoveStopMinGap];
    Boolean isBuySell = ([self.quoteView currentBuySell] == BUY);
    
    if (![self checkPriceValidateLimitPrice:limitPrice stopPrice:stopPrice isBuySell:isBuySell withType:type]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PriceErr"]
                                                            delegate:nil];
        return;
    }
    
    if (self.segmentControl.currentSelectIndex != TradeTypeLimitView) {
        // -1 为 解析失败 不能小于最小， 但是可以为0
        if ((stopMoveGap < minMoveStopGap || stopMoveGap == -1) && stopMoveGap != 0) {
            [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                              andMessage:[[LangCaptain getInstance] getLangByCode:@"StopMoveInvalied"]
                                                                delegate:nil];
            return;
        }
    }
    
    if (![CheckUtils checkAmount:amount buySell:isBuySell instrument:self.instrumentName]) {
        return;
    }
    
    CheckWarningNode *node = [self checkAndShowWarning:limitPrice
                                             stopPrice:stopPrice
                                              ifdLimit:-1
                                               ifdStop:-1];
    
    if (![node isSucceed]) {
        isAddOrModify = true;
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                          andMessage:[node errorMsg]
                                                            delegate:self];
        return;
    }
    
    [self doAddOpenOrderTrade];
    
    
}

- (void)doModifyOpenOrder {
    SegmentTradeType type   = self.segmentControl.currentSelectIndex;
    double amount           = [self.ocoPageView getAmountByType:type];
    double limitPrice       = [self.ocoPageView getLimitValueByTradeType:type];
    double stopPrice        = [self.ocoPageView getStopValueByTradeType:type];
    double stopMoveGap = [self.ocoPageView getStopMoveValueByType:type];
    int minMoveStopGap = [[[APIDoc getSystemDocCaptain] getInstrument:_instrumentName] getMoveStopMinGap];
    Boolean isBuySell = ([self.quoteView currentBuySell] == BUY);
    
    if (![self checkPriceValidateLimitPrice:limitPrice stopPrice:stopPrice isBuySell:isBuySell withType:type]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PriceErr"]
                                                            delegate:nil];
        return;
    }
    
    if (self.segmentControl.currentSelectIndex != TradeTypeLimitView) {
        // -1 为 解析失败 不能小于最小， 但是可以为0
        if ((stopMoveGap < minMoveStopGap || stopMoveGap == -1) && stopMoveGap != 0) {
            [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                              andMessage:[[LangCaptain getInstance] getLangByCode:@"StopMoveInvalied"]
                                                                delegate:nil];
            return;
        }
    }
    
    if (![CheckUtils checkAmount:amount buySell:isBuySell instrument:self.instrumentName]) {
        return;
    }
    
    CheckWarningNode *node = [self checkAndShowWarning:limitPrice
                                             stopPrice:stopPrice
                                              ifdLimit:-1
                                               ifdStop:-1];
    if (![node isSucceed]) {
        isAddOrModify = false;
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                          andMessage:[node errorMsg]
                                                            delegate:self];
        return;
    }
    
    [self doModifyOpenOrderTrade];
}

- (Boolean)checkPriceValidateLimitPrice:(double)limitPrice
                              stopPrice:(double)stopPrice
                              isBuySell:(Boolean)isBuySell
                               withType:(SegmentTradeType)type {
    Boolean limitPriceIsZero = (limitPrice >= 0.00001 ? false : true);
    Boolean stopPriceIsZero = (stopPrice >= 0.00001 ? false : true);
    
    switch (type) {
        case TradeTypeLimitView:
            if (limitPriceIsZero) {
                return false;
            }
            break;
        case TradeTypeStopView:
            if (stopPriceIsZero) {
                return false;
            }
            break;
        case TradeTypeOCOView:
            if (limitPriceIsZero || stopPriceIsZero) {
                return false;
            }
            break;
            
        default:
            break;
    }
    
    double limitPriceValue  = [CommDataUtil getLimitPrice:self.instrumentName   bunysell:isBuySell];
    double stopPriceValue   = [CommDataUtil getStopPrice:self.instrumentName    bunysell:isBuySell];
    NSString *limitSymbol   = [self getSymbleByBuySell:isBuySell
                                           LimitOrStop:LIMIT];
    NSString *stopSymbol    = [self getSymbleByBuySell:isBuySell
                                           LimitOrStop:STOP];
    if (!limitPriceIsZero) {
        if ([limitSymbol isEqualToString:@">"]) {
            if (limitPrice <= limitPriceValue) {
                return false;
            }
        }
        if ([limitSymbol isEqualToString:@"<"]) {
            if (limitPrice >= limitPriceValue) {
                return false;
            }
        }
    }
    
    if (!stopPriceIsZero) {
        if ([stopSymbol isEqualToString:@">"]) {
            if (stopPrice <= stopPriceValue) {
                return false;
            }
        }
        if ([stopSymbol isEqualToString:@"<"]) {
            if (stopPrice >= stopPriceValue) {
                return false;
            }
        }
    }
    return true;
}

- (void)doCancel {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_11];
    // 如果取消 跳轉 報價list界面
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
}

- (void)doDelete {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_10];
    TTrade *trade = [[JumpDataCenter getInstance] openOrderTrade];
    TOrder *order = [[JumpDataCenter getInstance] modifyOrder];
    if (trade == nil) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"TradeNotExsit"]
                                                            delegate:nil];
        return;
    }
    
    if (order == nil) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderNotExsit"]
                                                            delegate:nil];
        return;
    }
    
    if (![CommDataUtil isUptradeOrder:[trade getCorOrderID]]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]
                                                            delegate:nil];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[trade getCorOrderID]]) {
        [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]
                                                            delegate:nil];
        return;
    }
    
    [[TradeActionUtil getInstance] doDeleteOpenOrder:[trade getCorOrderID]];
    
}

#pragma ZLDelegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    
    if (text == nil || [text length] == 0) {
        return false;
    }
    
    Boolean isEditAble = true;
    
    NSUInteger length = [text length];
    if ([textField isKindOfClass:[BlackgroundTextField class]]) {
        TextFieldStyle style = [(BlackgroundTextField *)textField inputStyle];
        if (style == TextFieldStyleDigist) {
            [textField insertText:text];
            
            NSArray *stringArray = [textField.text componentsSeparatedByString:@"."];
            NSString *integerString = [@([[stringArray objectAtIndex:0] intValue]) stringValue];
            if ([integerString length] > 3) {
                isEditAble = false;
            }
            
            if ([textField.text containsString:@"."]) {
                NSString *digistString = [stringArray objectAtIndex:1];
                if ([digistString length] > self.digist) {
                    isEditAble = false;
                }
            }
            
            for (int i = 0; i < length; i++) {
                [textField deleteBackward];
            }
        }
    }
    
    if ([text length] >= 3) {
        [textField setText:@""];
        //        [textField selectAll:self];
    }
    
    return isEditAble;
}

- (void)textFiledBeginEdit:(UITextField *)textField {
    ZLKeyboardView *inputView = (ZLKeyboardView *)textField.inputView;
    ZLTradeNumberKeyboard *keyboardView = [inputView getTradeNumberKeyboard];
    CGRect superRect = self.bounds;
    [keyboardView setFrame:CGRectMake(0, superRect.size.height - 200, superRect.size.width, 200)];
    [self addSubview:keyboardView];
    [keyboardView setHidden:false];
}

- (void)textFieldDidEdit:(UITextField *)textField {
    //    [self updateIDTPriceNotice];
}

- (void)textFieldEndEdit:(UITextField *)textField {
    if ([textField isKindOfClass:[BlackgroundTextField class]]) {
        TextFieldStyle style = [(BlackgroundTextField *)textField inputStyle];
        
        double value = [self getDoubleValue:textField.text];
        NSString *stringValue = @"";
        if (style == TextFieldStyleAmount || style == TextFieldStyleStopMove) {
            stringValue = [DecimalUtil formatNumber:value];
        } else {
            stringValue = [DecimalUtil formatDoubleByNoStyle:value digit:self.digist];
        }
        
        if (value <= 0.00001 && value >= -0.00001) {
            stringValue = @"";
        }
        [textField setText:stringValue];
    }
    ZLTradeNumberKeyboard *keyboardView = [(ZLKeyboardView *)textField.inputView getTradeNumberKeyboard];
    [keyboardView setHidden:true];
}

- (double)getDoubleValue:(NSString *)value {
    if (value == nil || [value length] == 0) {
        return 0.0f;
    }
    return [[value stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

#pragma alert delegate
-(void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index {
    [alertView setDelegate:nil];
    if (index == 1) {
        if (isAddOrModify) {
            [self doAddOpenOrderTrade];
        } else {
            [self doModifyOpenOrderTrade];
        }
    }
}
// 防呆检查
- (CheckWarningNode *)checkAndShowWarning:(double)limitPrice stopPrice:(double)stopPrice ifdLimit:(double)ifdLimit ifdStop:(double)ifdStop {
    double percent = [[InstWarnConfig getInstance] getWarningPerc];
    Boolean isBuySell = ([self.quoteView currentBuySell] == BUY);
    return [WarningUtil checkAndShowWarningBuySell:isBuySell
                                        limitPrice:limitPrice
                                         stopPrice:stopPrice
                                     ifdLimitPrice:ifdLimit
                                      ifdStopPrice:ifdStop
                                        instrument:self.instrumentName
                                           percent:percent];
}

- (void)doAddOpenOrderTrade {
    SegmentTradeType type   = self.segmentControl.currentSelectIndex;
    double limitPrice       = [self.ocoPageView getLimitValueByTradeType:type];
    double stopPrice        = [self.ocoPageView getStopValueByTradeType:type];
    double stopMoveGap = [self.ocoPageView getStopMoveValueByType:type];
    Boolean isBuySell = ([self.quoteView currentBuySell] == BUY);
    
    int expireType          = (int)[self.ocoPageView getExpireType:type];
    NSString *expireTime    = [self.ocoPageView     getExpireTime:type];
    
    [[TradeActionUtil getInstance] doAddOpenOrderTradeInstrument:self.instrumentName
                                                       isBuySell:isBuySell
                                                      limitPrice:limitPrice
                                                    oriStopPrice:stopPrice
                                                     stopMoveGap:stopMoveGap
                                                   toCloseTicket:[[[JumpDataCenter getInstance] openOrderTrade] getTicket]
                                                      expireType:expireType
                                                      expireTime:expireTime];
}

- (void)doModifyOpenOrderTrade {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_9];
    SegmentTradeType type   = self.segmentControl.currentSelectIndex;
    double amount           = [self.ocoPageView getAmountByType:type];
    double limitPrice       = [self.ocoPageView getLimitValueByTradeType:type];
    double stopPrice        = [self.ocoPageView getStopValueByTradeType:type];
    double stopMoveGap = [self.ocoPageView getStopMoveValueByType:type];
    
    int expireType          = (int)[self.ocoPageView getExpireType:type];
    NSString *expireTime    = [self.ocoPageView     getExpireTime:type];
    [[TradeActionUtil getInstance] doModifyOpenOrderTradeOrderID:[[[JumpDataCenter getInstance] openOrderTrade] getCorOrderID]
                                                          amount:amount
                                                     stopMoveGap:stopMoveGap
                                                      limitPrice:limitPrice
                                                    oriStopPrice:stopPrice
                                                      expireType:expireType
                                                      expireTime:expireTime];
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
    if (self.instrumentName != nil && [self.instrumentName length] > 0) {
        CDS_PriceSnapShot *pss  = [[QuoteDataStore getInstance] getQuoteData:_instrumentName];
        [self updateValue:pss];
    }
}

@end
