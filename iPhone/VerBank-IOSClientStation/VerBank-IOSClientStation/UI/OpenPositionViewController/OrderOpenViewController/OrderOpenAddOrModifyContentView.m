//
//  OrderOpenContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderOpenAddOrModifyContentView.h"
#import "QuoteDataStore.h"
#import "APIDoc.h"
#import "DataCenter.h"
#import "LangCaptain.h"
#import "AccountUtil.h"
#import "MTP4CommDataInterface.h"
#import "DecimalUtil.h"
#import "ZLKeyboard.h"
#import "ScreenAuotoSizeScale.h"
#import "ResizeForKeyboard.h"
#import "IosLayoutDefine.h"
#import "UIFormat.h"
#import "IosLogic.h"
#import "CommDataUtil.h"
//#import "DropDownView.h"
#import "TimeSelectView.h"
#import "ClientAPI.h"
#import "ShowAlert.h"
#import "TradeResult_OrderCFD.h"
#import "TradeApi.h"
#import "CertificateUtil.h"
#import "PhonePinInputView.h"
#import "TranslateUtil.h"
#import "LimitDigistField.h"
#import "CheckWarningNode.h"
#import "InstWarnConfig.h"
#import "ClientUIUtil.h"
#import "DateTypePickerView.h"
#import "LeftViewController.h"
#import "IosLogic.h"
#import "OpenPositionContentView.h"

#import "OptRecordTable.h"
#import "OperationRecordsSave.h"

#define LimitView 0
#define StopView 1
#define OcoView 2

#define TypeDay     0
#define TypeWeek    1
#define TypeGtc     2
#define TypeUser    3

//const int defaultStopMoveGap = 5;

@interface OrderOpenAddOrModifyContentView ()<API_Event_QuoteDataStore, CustomSecmentControlViewDelegate, ZLKeyboardDelegate, UITextFieldDelegate,  UIAlertViewDelegate> {
    TTrade *_trade;
    TOrder *_order;
    
    NSString *_instrument;
    //    int _digist;
    double _limitPriceValue;
    double _stopPriceValue;
    Boolean _isBuySell;
    
    NSString *_limitSymbol;
    NSString *_stopSymbol;
    
    ZLKeyboard *_keyboard;
    
    UITextField *currentField;
    
    //    DropDownView *dropView;
    //    DropDownView *_limitDropView;
    //    DropDownView *_stopDropView;
    //    DropDownView *_ocoDropView;
    
    //    int _currentType;
    
    TimeSelectView *_timeView;
    
    NSDate *_pickDate;
    
    UIView *_backgroundView;
    
    int minMoveStopGap;
    
    DateTypePickerView *_dateTypePickerView;
    
    int _expireType;
    
    NSArray *pickerArray;
}

@end

@implementation OrderOpenAddOrModifyContentView

@synthesize floatPLStatus = _floatPLStatus;
@synthesize quoteSegmentControl = _quoteSegmentControl;

@synthesize accountLabel = _accountLabel;
@synthesize instrumentLabel = _instrumentLabel;
@synthesize timeLabel = _timeLabel;

@synthesize limitView = _limitView;
@synthesize stopView = _stopView;
@synthesize ocoView = _ocoView;

@synthesize thirdSegmentControl = _thirdSegmentControl;

// limitView
@synthesize limitPrice_limitLabel = _limitPrice_limitLabel;
@synthesize amount_limitLabel = _amount_limitLabel;
@synthesize valueTime_limitLabel = _valueTime_limitLabel;

@synthesize limitPrice_limitField = _limitPrice_limitField;
@synthesize amount_limitField = _amount_limitField;
@synthesize valueTime_limitButton = _valueTime_limitButton;

// stopView
@synthesize stopPrice_stopLabel = _stopPrice_stopLabel;
@synthesize amount_stopLabel = _amount_stopLabel;
@synthesize stopMove_ocoLabel = _stopMove_stopLabel;
@synthesize valueTime_stopLabel = _valueTime_stopLabel;

@synthesize stopPrice_stopField = _stopPrice_stopField;
@synthesize amount_stopField = _amount_stopField;
@synthesize stopMove_stopField = _stopMove_stopField;
@synthesize valueTime_stopButton = _valueTime_stopButton;

// ocoView
@synthesize limitPrice_ocoLabel = _limitPrice_ocoLabel;
@synthesize stopPrice_ocoLabel = _stopPrice_ocoLabel;
@synthesize amount_ocoLabel = _amount_ocoLabel;
@synthesize stopMove_stopLabel = _stopMove_ocoLabel;
@synthesize valueTime_ocoLabel = _valueTime_ocoLabel;

@synthesize limitPrice_ocoField = _limitPrice_ocoField;
@synthesize stopPrice_ocoField = _stopPrice_ocoField;
@synthesize amount_ocoField = _amount_ocoField;
@synthesize stopMove_ocoField = _stopMove_ocoField;
@synthesize valueTime_ocoButton = _valueTime_ocoButton;

+ (OrderOpenAddOrModifyContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderOpenAddOrModifyContentView" owner:self options:nil];
    OrderOpenAddOrModifyContentView *orderOpenAddOrModifyContentView = [nib objectAtIndex:0];
    [orderOpenAddOrModifyContentView setFrame:ContentRect];
    [orderOpenAddOrModifyContentView initContentView];
    return orderOpenAddOrModifyContentView;
}

- (void)initContentView {
    [self initData];
    
    if (_instrument == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"InstrumentIsNull"]];
        return;
    }
    
    [self initUI];
    [self initKeyboard];
    [self initBackgroundView];
    //    [self addListener];
}

- (void)initData {
    _trade = [[DataCenter getInstance] trade];
    _order = [[APIDoc getUserDocCaptain] getOrder:[_trade getCorOrderID]];
    _instrument = [_trade getInstrument];
    minMoveStopGap = [[[APIDoc getSystemDocCaptain] getInstrument:_instrument] getMoveStopMinGap];
    _isBuySell = !([_trade getBuysell] == IndexBuy);
    if (_order == nil) {
        _expireType = ORDER_EXPIRE_TYPE_GTC;
    } else {
        _expireType = [_order getExpireType];
    }
    [self resetTimeButtonTitle];
}

- (void)initDatePickerView {
    pickerArray = [[NSArray alloc] initWithObjects:
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_DAY],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_WEEK],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_GTC],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_USER_DEFINED],nil];
    _dateTypePickerView  = [DateTypePickerView newInstanceWithArray:pickerArray];
    [_dateTypePickerView.doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)doneAction {
    NSInteger selectedProvinceIndex = [_dateTypePickerView.datePicker selectedRowInComponent:0];
    
    // 自定义
    //    int type = (int)selectedProvinceIndex - 6;
    int type = [[pickerArray objectAtIndex:selectedProvinceIndex] intValue];
    if (type > 1000) {
        _pickDate = [NSDate dateWithTimeIntervalSinceNow:type];
    }
    _expireType = type;
    [_dateTypePickerView removeFromSuperview];
    
    if (type == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        [self otherAction];
    } else {
        if (type > 1000) {
            _expireType = ORDER_EXPIRE_TYPE_USER_DEFINED;
        }
        [ResizeForKeyboard setViewPosition:[self superview] forY:SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT];
        [self resetTimeButtonTitle];
    }
}

- (void)otherAction {
    // 选择 other time
    if (_timeView == nil) {
        _timeView = [TimeSelectView newInstance];
        
        if ([[[LangCaptain getInstance] getLangConfig] isEqualToString:LangConfig_TW]) {
            [_timeView.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hant_CN"]];
        } else {
            [_timeView.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        }
        
        [self addDoneAction:_timeView];
        [_timeView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
        
        [[[self superview] superview] addSubview:_backgroundView];
        
        [[[self superview] superview] addSubview:_timeView];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [_timeView setFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        if (_order != nil && [_order getExpireType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
            [_timeView.datePicker setDate:[_order getExpiryTime]];
        }
        // 盖住button
        [ResizeForKeyboard setViewPosition:[self superview] forY:-70];
        
        [UIView commitAnimations];
    }
}

- (void)showSelectPicker {
    [self rebackOrigin];
    [[[self superview] superview] addSubview:_dateTypePickerView];
    [_dateTypePickerView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    [_dateTypePickerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [ResizeForKeyboard setViewPosition:[self superview] forY:-70];
    
    [UIView commitAnimations];
}

- (void)initUI {
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrument];
    //    [self initDropDownView];
    [self initSymbol];
    [self initSimpleUI:pss];
    [self initQuoteSegment:pss];
    [self initMainView];
}

- (void)addKChartView {
    //    [((LeftViewController *)[[[IosLogic getInstance] getWindow] rootViewController]) popKChartView:_instrument];
}

- (void)initSymbol {
    if (_isBuySell) {
        _limitSymbol = @"<";
        _stopSymbol = @">";
    } else {
        _limitSymbol = @">";
        _stopSymbol = @"<";
    }
}

- (void)initSimpleUI:(CDS_PriceSnapShot *)pss {
    // instrument
    [_instrumentLabel setText:_instrument];
    // account
    [_accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    // time
    [self updateTime:[pss snapshotTime]];
}

- (void)initQuoteSegment:(CDS_PriceSnapShot *)pss {
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int extraDigit = [inst getExtraDigit];
    //    _digist = [inst getDigits];
    // quotesegment
    [_quoteSegmentControl setStyle:STYLE_NORMAL];
    if ([_trade getBuysell] == IndexBuy) {
        [_quoteSegmentControl setSelectIndex:IndexSell];
    } else {
        [_quoteSegmentControl setSelectIndex:IndexBuy];
    }
    [_quoteSegmentControl setExtradigit:extraDigit];
    _quoteSegmentControl.userInteractionEnabled = false;
    [self updateSegmentControlAsk:[pss getAsk] bid:[pss getBid]];
}

- (void)initBackgroundView {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)initKeyboard {
    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:TradeNumberKeyboard];
    keyboard.delegate = self;
    _keyboard = keyboard;
    
    [self reInitTextField:_limitPrice_limitField];
    [self reInitTextField:_amount_limitField];
    
    [self reInitTextField:_stopPrice_stopField];
    [self reInitTextField:_amount_stopField];
    [self reInitTextField:_stopMove_stopField];
    
    [self reInitTextField:_stopPrice_ocoField];
    [self reInitTextField:_limitPrice_ocoField];
    [self reInitTextField:_amount_ocoField];
    [self reInitTextField:_stopMove_ocoField];
}

- (void)reInitTextField:(UITextField *)textField{
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    CGFloat radio = textField.frame.size.height / 2 - 4.0f;
    textField.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:radio];
    textField.layer.borderWidth = 1.0f;
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    [textField setBackgroundColor:[UIColor clearColor]];
    
    // 暂时在这定义颜色
    //    if (textField == _amount_limitField || textField == _amount_stopField || textField == _amount_ocoField) {
    //        [textField setTextColor:[UIColor grayColor]];
    //    } else {
    //        [textField setTextColor:[UIColor whiteColor]];
    //    }
    [textField setTextColor:[UIColor whiteColor]];
    
    textField.inputView = _keyboard;
    [textField setDelegate:self];
    
    if ([textField isKindOfClass:[LimitDigistField class]]) {
        Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
        int _digist = [inst getDigits];
        [((LimitDigistField *)textField) setDigist:_digist];
    }
}

- (void)initPreData {
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    int type = 0;
    if (_order != nil) {
        if (!([_order getLimitPrice] <= 0.00001)) {
            type |= 1;
        }
        if (!([_order getCurrentStopPrice] <= 0.00001)) {
            type |= 2;
        }
    }
    [self customSecmentControlClick:type - 1];
    [_thirdSegmentControl setSelectIndex:type - 1];
    
    _amount_limitField.userInteractionEnabled = false;
    _amount_stopField.userInteractionEnabled = false;
    _amount_ocoField.userInteractionEnabled = false;
    
    [_amount_limitField setText:[DecimalUtil formatNumber:[_trade getAmount]]];
    [_amount_stopField setText:[DecimalUtil formatNumber:[_trade getAmount]]];
    [_amount_ocoField setText:[DecimalUtil formatNumber:[_trade getAmount]]];
    
    //    [_stopMove_stopField setText:[@(defaultStopMoveGap) stringValue]];
    //    [_stopMove_ocoField setText:[@(defaultStopMoveGap) stringValue]];
    if (_order == nil) {
        return;
    }
    if ([_order getLimitPrice] > 0.00001) {
        [_limitPrice_limitField setText:[DecimalUtil formatMoney:[_order getLimitPrice] digist:_digist]];
        [_limitPrice_ocoField setText:[DecimalUtil formatMoney:[_order getLimitPrice] digist:_digist]];
    }
    
    if ([_order getCurrentStopPrice] > 0.00001) {
        [_stopPrice_stopField setText:[DecimalUtil formatMoney:[_order getCurrentStopPrice] digist:_digist]];
        [_stopPrice_ocoField setText:[DecimalUtil formatMoney:[_order getCurrentStopPrice] digist:_digist]];
    }
    
    if ([_order getStopMoveGap] > 0.00001) {
        [_stopMove_stopField setText:[@([_order getStopMoveGap]) stringValue]];
        [_stopMove_ocoField setText:[@([_order getStopMoveGap]) stringValue]];
    }
}

- (void)initMainView {
    [self initLimitView];
    [self initStopView];
    [self initOcoView];
    [self initPreData];
    [self updatePrice];
    [self initDatePickerView];
    [self initValueTimeButton];
    
    // bottom button
    if (_order != nil) {
        [self addModifyButton];
    } else {
        [self addAddButton];
    }
    
    [self setBackgroundColor:[UIColor backgroundColor]];
}

- (void)initValueTimeButton {
    if (_order != nil) {
        if ([_order getExpireType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
            _pickDate = [_order getExpiryTime];
            NSString *title = [NSString stringWithFormat:@"  %@", [self getTime:false]];
            [_valueTime_limitButton setTitle:title forState:UIControlStateNormal];
            [_valueTime_stopButton setTitle:title forState:UIControlStateNormal];
            [_valueTime_ocoButton setTitle:title forState:UIControlStateNormal];
        } else {
            _expireType  =[_order getExpireType];
            [self resetTimeButtonTitle];
        }
        
    }
    [_valueTime_limitButton addTarget:self action:@selector(showSelectPicker) forControlEvents:UIControlEventTouchUpInside];
    [_valueTime_stopButton addTarget:self action:@selector(showSelectPicker) forControlEvents:UIControlEventTouchUpInside];
    [_valueTime_ocoButton addTarget:self action:@selector(showSelectPicker) forControlEvents:UIControlEventTouchUpInside];
    
    // style
    //    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTimeButton, _touchButton, nil];
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTime_limitButton, _valueTime_stopButton, _valueTime_ocoButton, nil];
    for (UIButton *button in buttonArray) {
        CGFloat radio = button.frame.size.height / 2 - 4.0f;
        [button setBackgroundColor:[UIColor clearColor]];
        button.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:radio];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (void)addAddButton {
    CGFloat edage = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    CGFloat heigh = [ScreenAuotoSizeScale CGAutoMakeFloat:25.0f];
    CGFloat width = SCREEN_WIDTH - edage * 2;
    CGFloat y = self.frame.size.height - 45.0f;
    CGRect confirmRect = CGRectMake(edage,                          y, width / 2 - 2.0f, heigh);
    CGRect cancelRect = CGRectMake(edage + width / 2 + 2.0f,       y, width / 2 - 2.0f, heigh);
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:confirmRect];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelRect];
    
    [confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"CommfirmAdd"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    //    [UIFormat setViewStyle:confirmButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:confirmButton];
    [UIFormat setComplexBlueButtonColor:confirmButton];
    
    //    [UIFormat setViewStyle:cancelButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cancelButton];
    [UIFormat setComplexGrayButtonColor:cancelButton];
    
    [self addSubview:confirmButton];
    [self addSubview:cancelButton];
    
    [confirmButton addTarget:self action:@selector(checkCAAddOrModify) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addModifyButton {
    CGFloat edage = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    CGFloat heigh = [ScreenAuotoSizeScale CGAutoMakeFloat:25.0f];
    CGFloat width = SCREEN_WIDTH - edage * 2;
    CGFloat y = self.frame.size.height - 45.0f;
    CGRect modifyRect = CGRectMake(edage,                          y, width / 3 - 4.0f, heigh);
    CGRect deleteRect = CGRectMake(edage + width / 3 + 2.0f,       y, width / 3 - 4.0f, heigh);
    CGRect cancelRect = CGRectMake(edage + width / 3 * 2 + 4.0f,   y, width / 3 - 4.0f, heigh);
    
    UIButton *modifyButton = [[UIButton alloc] initWithFrame:modifyRect];
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:deleteRect];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelRect];
    
    [modifyButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Modify"] forState:UIControlStateNormal];
    [deleteButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Delete"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    //    [UIFormat setViewStyle:modifyButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:modifyButton];
    [UIFormat setComplexBlueButtonColor:modifyButton];
    
    //    [UIFormat setViewStyle:deleteButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:deleteButton];
    [UIFormat setComplexRedButtonColor:deleteButton];
    
    //    [UIFormat setViewStyle:cancelButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cancelButton];
    [UIFormat setComplexGrayButtonColor:cancelButton];
    
    [self addSubview:modifyButton];
    [self addSubview:deleteButton];
    [self addSubview:cancelButton];
    
    [modifyButton addTarget:self action:@selector(checkCAAddOrModify) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton addTarget:self action:@selector(checkCADelete) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initLimitView {
    // limitView
    NSString *amount = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    NSString *valueTime = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]];
    [_amount_limitLabel setText:amount];
    [_valueTime_limitLabel setText:valueTime];
}

- (void)initStopView {
    // stopView
    NSString *amount = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    NSString *valueTime = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]];
    NSString *stopMove = [NSString stringWithFormat:@"%@(>=%d):", [[LangCaptain getInstance] getLangByCode:@"StopMovePrice"], [[[APIDoc getSystemDocCaptain] getInstrument:_instrument] getMoveStopMinGap]];
    
    [_amount_stopLabel setText:amount];
    [_valueTime_stopLabel setText:valueTime];
    [_stopMove_stopLabel setText:stopMove];
}

- (void)initOcoView {
    //ocoView
    NSString *amount = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    
    NSString *valueTime = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]];
    NSString *stopMove = [NSString stringWithFormat:@"%@(>=%d):", [[LangCaptain getInstance] getLangByCode:@"StopMovePrice"], [[[APIDoc getSystemDocCaptain] getInstrument:_instrument] getMoveStopMinGap]];
    
    [_amount_ocoLabel setText:amount];
    [_stopMove_ocoLabel setText:stopMove];
    [_valueTime_ocoLabel setText:valueTime];
}

#pragma updateFunc

- (void)updateSegmentControlAsk:(double)ask bid:(double)bid{
    if (_instrument == nil) {
        return;
    }
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrument];
    [_quoteSegmentControl refreshSegmentAsk:[instUtil formatClientPrice:ask]
                                   bidPrice:[instUtil formatClientPrice:bid]];
}

- (void)updateTime:(long long)time{
    NSLog(@"...................");
    //    @synchronized(_timeLabel) {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    NSString *stringDate = [JEDIDateTime stringUIFromTime:date];
    [_timeLabel setText:stringDate];
    //    }
}

- (void)updatePrice {
    
    if (_instrument == nil) {
        return;
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    [self updateData];
    
    NSString *limitPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    limitPrice = [limitPrice stringByAppendingFormat:@"%@%@):", _limitSymbol, [DecimalUtil formatDoubleByNoStyle:_limitPriceValue digit:_digist]];
    
    NSString *stopPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    stopPrice = [stopPrice stringByAppendingFormat:@"%@%@):", _stopSymbol, [DecimalUtil formatDoubleByNoStyle:_stopPriceValue digit:_digist]];
    
    [_limitPrice_limitLabel setText:limitPrice];
    [_limitPrice_ocoLabel setText:limitPrice];
    [_stopPrice_stopLabel setText:stopPrice];
    [_stopPrice_ocoLabel setText:stopPrice];
}

- (void)updateData {
    if (_instrument == nil) {
        return;
    }
    _limitPriceValue = [CommDataUtil getLimitPrice:_instrument bunysell:_isBuySell];
    _stopPriceValue = [CommDataUtil getStopPrice:_instrument bunysell:_isBuySell];
}

#pragma customSecment delegate
- (void)customSecmentControlClick:(NSInteger)index{
    switch (index) {
        case LimitView:
            [self.limitView setHidden:false];
            [self.stopView setHidden:true];
            [self.ocoView setHidden:true];
            break;
        case StopView:
            [self.limitView setHidden:true];
            [self.stopView setHidden:false];
            [self.ocoView setHidden:true];
            break;
        case OcoView:
            [self.limitView setHidden:true];
            [self.stopView setHidden:true];
            [self.ocoView setHidden:false];
            break;
        default:
            break;
    }
    [self rebackOrigin];
}

#pragma listener

- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
    [_thirdSegmentControl setSegmentDelegate:self];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
    [_thirdSegmentControl setSegmentDelegate:nil];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self removeListener];
    
    [_floatPLStatus removeFromSuperview];
    _floatPLStatus = nil;
    
    _order = nil;
    _instrument = nil;
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:_instrument]) {
            [self updateSegmentControlAsk:[snapshot getAsk] bid:[snapshot getBid]];
            [self updateTime:[snapshot snapshotTime]];
            [self updatePrice];
        }
    });
    
}
#pragma keyboardDelegate
- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
    //    [self updateOccupyMargin];
    //    if ([string length] >= 2 && (currentField == _stopMove_stopField || currentField == _stopMove_ocoField)) {
    //        if ([currentField.text length] >= 2) {
    //            [keyboard resetInputString:[currentField.text substringWithRange:NSMakeRange(0, 2)]];
    //        } else {
    //            currentField.text = [string substringWithRange:NSMakeRange(0, 2)];
    //            [keyboard resetInputString:currentField.text];
    //        }
    //    } else {
    //        currentField.text = string;
    //    }
    //    if ([string length] >= 2 && (currentField == _stopMove_stopField || currentField == _stopMove_ocoField)) {
    //        currentField.text = [string substringWithRange:NSMakeRange(0, 2)];
    //        [keyboard resetInputString:currentField.text];
    //    }
}

- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string{
    if ([string isEqualToString:@""]) {
        currentField.text = @"";
    } else {
        currentField.text = string;
    }
}

- (void)keyboardReturn {
    [currentField resignFirstResponder];
    currentField = nil;
    [ResizeForKeyboard setViewPosition:[[self superview] superview]forY:0];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self rebackOrigin];
    currentField = textField;
    [_keyboard resetInputString:textField.text];
    [_keyboard setCurrentTextField:currentField];
    //    currentY = [[textField superview] superview].frame.origin.y;
    double currentY = textField.frame.origin.y + [textField superview].frame.origin.y + [[textField superview] superview].frame.origin.y;
    CGFloat distance = 0.0f;
    if (DISTANCE_FROM_TOP - currentY <= 0.0f) {
        distance = DISTANCE_FROM_TOP - currentY;
    }
    [ResizeForKeyboard setViewPosition:[[self superview] superview] forY:distance];
}


#pragma trade action
- (void)doCancel {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_11];
    [OpenPositionContentView setSelectTicket:[NSString stringWithFormat:@"%lld(%d)", [_trade getTicket], [_trade getSplitno]]];
    [[IosLogic getInstance] gotoOpenPositionViewController];
}

// 暫時這麼寫 ， 有時間改
- (void)checkCADelete {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_10];
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
                                           action:@selector(phonePinCancelDelete:)
                                 forControlEvents:UIControlEventTouchUpInside];
        [phonePinInputView.commitButton addTarget:self
                                           action:@selector(phonePinCommitDelete:)
                                 forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self doDeleteOrder];
    }
}

- (void)phonePinCancelDelete:(id)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)phonePinCommitDelete:(id)sender {
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
            [self doDeleteOrder];
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

- (void)doDeleteOrder {
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    if (_trade == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"TradeNotExsit"]];
        return;
    }
    
    if (_order == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderNotExsit"]];
        return;
    }
    
    if (![CommDataUtil isUptradeOrder:[_trade getCorOrderID]]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[_trade getCorOrderID]]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    IP_TRADESERV5105 *_ip5105 = [[TradeApi getInstance] createDeleteOrderTradeAccount:[[ClientAPI getInstance] getAccount]
                                                                              orderID:[_trade getCorOrderID]];
    
    NSString *signature = [CertificateUtil getPkcs7sin:_ip5105];
    //    if (signature == nil) {
    //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
    //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"SignFailed"]];
    //        return;
    //    }
    //            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
    //                                                andMessage:signature];
    //            return;
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult *reslut = [[TradeApi getInstance] doDeleteOrderTrade:_ip5105
                                                               signature:signature];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            
            if ([reslut succeed]) {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"DeleteSuccess"]];
                [[IosLogic getInstance] gotoOpenPositionViewController];
            } else {
                NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[reslut errCode]];
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:errMsg];
            }
        });
    });
}

- (void)checkCAAddOrModify {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_9];
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
    
    if (![self check]) {
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
                                           action:@selector(phonePinCancelAddOrModify:)
                                 forControlEvents:UIControlEventTouchUpInside];
        [phonePinInputView.commitButton addTarget:self
                                           action:@selector(phonePinCommitAddOrModify:)
                                 forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self orderAddOrModify];
    }
}

- (void)phonePinCancelAddOrModify:(id)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)phonePinCommitAddOrModify:(id)sender {
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
            [self orderAddOrModify];
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

- (void)orderAddOrModify {
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    if (![self checkInputData]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]];
        return;
    }
    
    double amount = [self getAmount];
    // 金額不可修改
    if (amount < 0.000001) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountNill"]];
        return;
    }
    
    double limitPrice = [self getLimit];
    double stopPrice = [self getStop];
    
    //    if (![self check]) {
    //        return;
    //    }
    
    CheckWarningNode *node = [self checkAndShowWarning:limitPrice
                                             stopPrice:stopPrice
                                              ifdLimit:-1
                                               ifdStop:-1];
    
    if (![node isSucceed]) {
        [[ShowAlert getInstance] showChooseableAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                      andMessage:[node errorMsg]
                                                        delegate:self];
        return;
    }
    [self doTrade];
}

- (void)doTrade {
    double amount = [self getAmount];
    double limitPrice = [self getLimit];
    double stopPrice = [self getStop];
    int stopMoveGap = [self getStopMove];
    
    if ([_thirdSegmentControl selectIndex] != LimitView) {
        if (stopMoveGap < minMoveStopGap || stopMoveGap == -1) {
            if (stopMoveGap != 0) {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"StopMoveInvalied"]];
                return;
            }
        }
    }
    
    Boolean isValidate = true;
    if (limitPrice >= 0.00001) {
        if ([_limitSymbol isEqualToString:@">"]) {
            if (limitPrice <= _limitPriceValue) {
                isValidate = false;
            }
        }
        if ([_limitSymbol isEqualToString:@"<"]) {
            if (limitPrice >= _limitPriceValue) {
                isValidate = false;
            }
        }
    }
    
    if (stopPrice >= 0.00001) {
        if ([_stopSymbol isEqualToString:@">"]) {
            if (stopPrice <= _stopPriceValue) {
                isValidate = false;
            }
        }
        if ([_stopSymbol isEqualToString:@"<"]) {
            if (stopPrice >= _stopPriceValue) {
                isValidate = false;
            }
        }
    }
    
    if (!isValidate) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PriceErr"]];
        return;
    }
    
    // 合法性检查 时间
    if (_order == nil) {
        // 新建
        IP_TRADESERV5103 *_ip5103 =
        [[TradeApi getInstance] createOpen_Close_1_FIXED_TRADE_ORDER_CFDTradeAccount:[[ClientAPI getInstance] getAccount]
                                                                          instrument:_instrument
                                                                        isBuyNotSell:_isBuySell
                                                                          limitPrice:limitPrice
                                                                        oriStopPrice:stopPrice
                                                                         stopMoveGap:stopMoveGap
                                                                       toCloseTicket:[_trade getTicket]
         //                                                                          expiryType:[self arrayTypeToExprieType:[_limitDropView getSelectIndex]]
                                                                          expiryType:_expireType
                                                                          expireTime:[self getTime:true]];
        
        NSString *signature = [CertificateUtil getPkcs7sin:_ip5103];
        //        if (signature == nil) {
        //            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"SignFailed"]];
        //            return;
        //        }
        //                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                                        andMessage:signature];
        //                    return;
        // 获取CA签名
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            TradeResult_OrderCFD *result = [[TradeApi getInstance] doOpen_CLOSE_1_FIXED_TRADE_ORDER_CFDTrade:_ip5103
                                                                                                   signature:signature];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                [self doresult:result];
            });
        });
    } else {
        if (![CommDataUtil isUptradeOrder:[_trade getCorOrderID]]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
            return;
        }
        
        if (![CommDataUtil isPriceReached:[_trade getCorOrderID]]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
            return;
        }
        // 修改
        IP_TRADESERV5104 *_ip5104 =
        [[TradeApi getInstance] createModifyOrderAccount:[[ClientAPI getInstance] getAccount]
                                                 orderID:[_trade getCorOrderID]
                                                  amount:amount
                                             stopMoveGap:stopMoveGap
                                              linutPirce:limitPrice
                                            oriStopPrice:stopPrice
         //                                              expiryType:[self arrayTypeToExprieType:[_limitDropView getSelectIndex]]
                                              expiryType:_expireType
                                              expiryTime:[self getTime:true]
                                           IFDLimitPrice:0
                                            IFDStopPrice:0];
        NSString *signature = [CertificateUtil getPkcs7sin:_ip5104];
        //        if (signature == nil) {
        //            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"SignFailed"]];
        //            return;
        //        }
        //                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                                        andMessage:signature];
        //                    return;
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            TradeResult_OrderCFD *result = [[TradeApi getInstance] doModifyOrder:_ip5104
                                                                       signature:signature];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                [self doresult:result];
            });
        });
    }
}

// 防呆检查
- (CheckWarningNode *)checkAndShowWarning:(double)limitPrice stopPrice:(double)stopPrice ifdLimit:(double)ifdLimit ifdStop:(double)ifdStop {
    double percent = [[InstWarnConfig getInstance] getWarningPerc];
    return [ClientUIUtil checkAndShowWarningBuySell:_isBuySell
                                         limitPrice:limitPrice
                                          stopPrice:stopPrice
                                      ifdLimitPrice:ifdLimit
                                       ifdStopPrice:ifdStop
                                         instrument:_instrument
                                            percent:percent];
}

- (void)doresult:(TradeResult_OrderCFD*)result {
    if ([result result] == RESULT_SUCCEED) {
        [[ShowAlert getInstance] showJumpAlertView:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderSuccess"]
                                          delegate:self];
        //        [[[ShowAlert getInstance] alertView] setDelegate:self];
        //        [[IosLogic getInstance] gotoOpenPositionViewController];
    } else  {
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]];
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:errMsg];
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView == [[ShowAlert getInstance] chooseableAlertView]) {
        if (buttonIndex == 0) {
            return;
        }
        
        if (buttonIndex == 1) {
            [self doTrade];
        }
    }
    
    if (alertView == [[ShowAlert getInstance] jumpAlertView]) {
        [[[ShowAlert getInstance] jumpAlertView] setDelegate:nil];
        [[ShowAlert getInstance] setJumpAlertView:nil];
        [OpenPositionContentView setSelectTicket:[NSString stringWithFormat:@"%lld(%d)", [_trade getTicket], [_trade getSplitno]]];
        [[IosLogic getInstance] gotoOpenPositionViewController];
    }
    [alertView setDelegate:nil];
    alertView = nil;
    
}

- (Boolean)check {
    // 富掛單不做價格限制
    NSString *tradeAmtLeg = [[APIDoc getGeneralCheckUtil] isTradeAmountLegal4MKTTrade2:_instrument
                                                                                  acid:[[ClientAPI getInstance] getAccount]
                                                                               buySell:_isBuySell == BUY ? TRUE : FALSE
                                                                                amount:(long)[_trade getAmount]];
    if (tradeAmtLeg != nil) {
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:tradeAmtLeg];
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:errMsg];
        return false;
    }
    return true;
}

- (double)getAmount {
    switch ([_thirdSegmentControl selectIndex]) {
        case LimitView:
            return [self getDefaultAmount:_amount_limitField.text];
        case StopView:
            return [self getDefaultAmount:_amount_stopField.text];
        case OcoView:
            return [self getDefaultAmount:_amount_ocoField.text];
        default:
            break;
    }
    return 0.0f;
}

- (double)getDefaultAmount:(NSString *)amountString {
    if (amountString == nil || [amountString isEqualToString:@""]) {
        //        return [CommDataUtil getDefaultCcy1Amount:_instrument];
        // 若为默认， 则返回0
        return 0.0f;
    } else {
        return [self getDoubleValue:amountString];
    }
}

- (double)getLimit {
    switch ([_thirdSegmentControl selectIndex]) {
        case LimitView:
            return [self getDoubleValue:_limitPrice_limitField.text];
        case StopView:
            return 0.0f;
        case OcoView:
            return [self getDoubleValue:_limitPrice_ocoField.text];
        default:
            break;
    }
    return 0.0f;
}

- (double)getStop {
    switch ([_thirdSegmentControl selectIndex]) {
        case LimitView:
            return 0.0f;
        case StopView:
            return [self getDoubleValue:_stopPrice_stopField.text];
        case OcoView:
            return [self getDoubleValue:_stopPrice_ocoField.text];
        default:
            break;
    }
    return 0.0f;
}

- (int)getStopMove {
    switch ([_thirdSegmentControl selectIndex]) {
        case LimitView:
            return 0;
        case StopView:
            return [self getIntValue:_stopMove_stopField.text];
        case OcoView:
            return [self getIntValue:_stopMove_ocoField.text];
        default:
            break;
    }
    return 0.0f;
}

- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

- (int)getIntValue:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return 0;
    }
    if ([self isPureInt:string]) {
        return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] intValue];
    } else {
        return -1;
    }
}

- (Boolean)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

#pragma time component
//- (void)initDropDownView {
//
//    NSString *gtc   = [NSString stringWithFormat:@"  GTC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
//    NSString *week  = [NSString stringWithFormat:@"  GTW %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
//    NSString *day   = [NSString stringWithFormat:@"  NYC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
//    NSString *other = [NSString stringWithFormat:@"  Other %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
//    NSArray *arr = [[NSArray alloc] initWithObjects:day, week, gtc, other, nil];
//
//    _limitDropView = [[DropDownView alloc] initWithRect:self.valueTime_limitButton array:arr direction:true];
//    [[self.valueTime_limitButton superview] addSubview:_limitDropView];
//    [_limitDropView setDelegate:self];
//
//    _stopDropView = [[DropDownView alloc] initWithRect:self.valueTime_stopButton array:arr direction:true];
//    [[self.valueTime_stopButton superview] addSubview:_stopDropView];
//    [_stopDropView setDelegate:self];
//
//    _ocoDropView = [[DropDownView alloc] initWithRect:self.valueTime_ocoButton array:arr direction:true];
//    [[self.valueTime_ocoButton superview] addSubview:_ocoDropView];
//    [_ocoDropView setDelegate:self];
//
//    if (_order == nil) {
//        [_limitDropView setSelectIndex:TypeGtc];
//        [_stopDropView setSelectIndex:TypeGtc];
//        [_ocoDropView setSelectIndex:TypeGtc];
//    } else {
//        [_limitDropView setSelectIndex:[self exprieTypeToArrayType: [_order getExpireType]]];
//        [_stopDropView setSelectIndex:[self exprieTypeToArrayType: [_order getExpireType]]];
//        [_ocoDropView setSelectIndex:[self exprieTypeToArrayType: [_order getExpireType]]];
//
//        if ([_order getExpireType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
//            _pickDate = [_order getExpiryTime];
//            NSString *title = [NSString stringWithFormat:@"  %@", [self getTime]];
//            [self.valueTime_limitButton setTitle:title forState:UIControlStateNormal];
//            [self.valueTime_stopButton setTitle:title forState:UIControlStateNormal];
//            [self.valueTime_ocoButton setTitle:title forState:UIControlStateNormal];
//        }
//    }
//
//    [self.valueTime_limitButton addTarget:self action:@selector(dropDownViewAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.valueTime_stopButton addTarget:self action:@selector(dropDownViewAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.valueTime_ocoButton addTarget:self action:@selector(dropDownViewAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    // style
//    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTime_limitButton, _valueTime_ocoButton, _valueTime_stopButton, nil];
//    for (UIButton *button in buttonArray) {
//        CGFloat radio = button.frame.size.height / 2 - 4.0f;
//        [button setBackgroundColor:[UIColor clearColor]];
//        button.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:radio];
//        button.layer.borderWidth = 1.0f;
//        button.layer.borderColor = [UIColor whiteColor].CGColor;
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//}

//- (void)dropDownViewAction:(UIButton *)sender {
//
//    if (sender == self.valueTime_limitButton) {
//        if ([_limitDropView isShowState] == false) {
//            [self rebackOrigin];
//            [_limitDropView showDropDown];
//        } else {
//            [_limitDropView hideDropDown];
//        }
//    }
//
//    if (sender == self.valueTime_stopButton) {
//        if ([_stopDropView isShowState] == false) {
//            [self rebackOrigin];
//            [_stopDropView showDropDown];
//        } else {
//            [_stopDropView hideDropDown];
//        }
//    }
//
//    if (sender == self.valueTime_ocoButton) {
//        if ([_ocoDropView isShowState] == false) {
//            [self rebackOrigin];
//            [_ocoDropView showDropDown];
//        } else {
//            [_ocoDropView hideDropDown];
//        }
//    }
//
//}

//- (void)otherAction:(int)index atView:(UIView *)atView{
//
//    [_limitDropView setSelectIndex:index];
//    [_stopDropView setSelectIndex:index];
//    [_ocoDropView setSelectIndex:index];
//
//    // 选择 other time
//    if (index == TypeUser) {
//        if (_timeView == nil) {
//            _timeView = [TimeSelectView newInstance];
//
//            if ([[[LangCaptain getInstance] getLangConfig] isEqualToString:LangConfig_TW]) {
//                [_timeView.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hant_CN"]];
//            } else {
//                [_timeView.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
//            }
//
//            [self addDoneAction:_timeView];
//            [_timeView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
//
//            [[[self superview] superview] addSubview:_backgroundView];
//
//            [[[self superview] superview] addSubview:_timeView];
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.5f];
//            [_timeView setFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
//            [_timeView.datePicker setDate:[_order getExpiryTime]];
//
//            // 盖住button
//            [ResizeForKeyboard setViewPosition:[self superview] forY:-70];
//
//            [UIView commitAnimations];
//        }
//    } else {
//        if (_timeView != nil) {
//            [self hideTimeView];
//        }
//    }
//}

- (void)hideTimeView {
    [UIView transitionWithView:_timeView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        [_timeView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
                    }
                    completion:^(BOOL finished){
                        [_timeView removeFromSuperview];
                        _timeView = nil;
                    }];
    [ResizeForKeyboard setViewPosition:[self superview] forY:SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT];
}

- (void)hideTimeTypeView {
    [_dateTypePickerView removeFromSuperview];
    [ResizeForKeyboard setViewPosition:[self superview] forY:SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT];
}

- (void)getTimeFromTimeView{
    [self rebackOrigin];
    //    [_timeView.datePicker ]
    _pickDate = _timeView.datePicker.date;
    NSString *prettyVersion = [NSString stringWithFormat:@"  %@", [self getTime:false]];
    [_valueTime_limitButton setTitle:prettyVersion forState:UIControlStateNormal];
    [_valueTime_stopButton setTitle:prettyVersion forState:UIControlStateNormal];
    [_valueTime_ocoButton setTitle:prettyVersion forState:UIControlStateNormal];
    [_backgroundView removeFromSuperview];
    
    [self hideTimeView];
}

- (NSDate *)getValueTime {
    //    if ([self exprieTypeToArrayType:[_limitDropView getSelectIndex]] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
    if (_expireType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        return _pickDate;
    }
    return nil;
}

- (NSString *)getTime:(Boolean)isTrade {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if (isTrade) {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return [dateFormat stringFromDate:[self getValueTime]];
}

- (void)addDoneAction:(UIView *)timeView {
    for (NSObject *object in [timeView subviews]) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)object;
            [button addTarget:self action:@selector(getTimeFromTimeView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)rebackOrigin {
    [self keyboardReturn];
    [self hideTimeView];
    [self hideTimeTypeView];
    //    [_limitDropView hideDropDown];
    //    [_stopDropView hideDropDown];
    //    [_ocoDropView hideDropDown];
}

- (void)dealloc {
    [[DataCenter getInstance] setTrade:nil];
}

- (Boolean)checkInputData {
    
    NSInteger type = [_thirdSegmentControl selectIndex];
    
    switch (type) {
        case LimitView:
            if ([self isNullString:_limitPrice_limitField.text]) {
                return false;
            }
            break;
        case StopView:
            if ([self isNullString:_stopPrice_stopField.text]) {
                return false;
            }
            break;
        case OcoView:
            if ([self isNullString:_limitPrice_ocoField.text] || [self isNullString:_stopPrice_ocoField.text]) {
                return false;
            }
            break;
        default:
            break;
    }
    return true;
}



- (Boolean)isNullString:(NSString *)string {
    if (string == nil || [string isEqualToString:@""]) {
        return true;
    }
    return false;
}

//- (int)exprieTypeToArrayType:(int)exprieTye {
//    switch (exprieTye) {
//        case ORDER_EXPIRE_TYPE_GTC:
//            return TypeGtc;
//            break;
//        case ORDER_EXPIRE_TYPE_DAY:
//            return TypeDay;
//            break;
//        case ORDER_EXPIRE_TYPE_WEEK:
//            return TypeWeek;
//            break;
//        case ORDER_EXPIRE_TYPE_USER_DEFINED:
//            return TypeUser;
//            break;
//        default:
//            break;
//    }
//    return 0;
//}
//
//- (int)arrayTypeToExprieType:(int)arrayType {
//    switch (arrayType) {
//        case TypeGtc:
//            return ORDER_EXPIRE_TYPE_GTC;
//            break;
//        case TypeDay:
//            return ORDER_EXPIRE_TYPE_DAY;
//            break;
//        case TypeWeek:
//            return ORDER_EXPIRE_TYPE_WEEK;
//            break;
//        case TypeUser:
//            return ORDER_EXPIRE_TYPE_USER_DEFINED;
//            break;
//        default:
//            break;
//    }
//    return 0;
//}

- (void)resetTimeButtonTitle {
    // time
    //    NSString *gtc   = [NSString stringWithFormat:@"  GTC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
    //    NSString *week  = [NSString stringWithFormat:@"  GTW %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
    //    NSString *day   = [NSString stringWithFormat:@"  NYC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
    //    NSString *other = [NSString stringWithFormat:@"  Other %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
    //    NSArray *timearr = [[NSArray alloc] initWithObjects:gtc, day, week, other, nil];
    //    if (_expireType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
    //        NSString *title = [NSString stringWithFormat:@"  %@", [self getTime]];
    //        [_valueTime_limitButton setTitle:title forState:UIControlStateNormal];
    //        [_valueTime_stopButton setTitle:title forState:UIControlStateNormal];
    //        [_valueTime_ocoButton setTitle:title forState:UIControlStateNormal];
    //    } else {
    //        [_valueTime_limitButton setTitle:[timearr objectAtIndex:_expireType] forState:UIControlStateNormal];
    //        [_valueTime_stopButton setTitle:[timearr objectAtIndex:_expireType] forState:UIControlStateNormal];
    //        [_valueTime_ocoButton setTitle:[timearr objectAtIndex:_expireType] forState:UIControlStateNormal];
    //    }
    if (_expireType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        NSString *title = [NSString stringWithFormat:@"  %@", [self getTime:false]];
        [_valueTime_limitButton setTitle:title forState:UIControlStateNormal];
        [_valueTime_stopButton setTitle:title forState:UIControlStateNormal];
        [_valueTime_ocoButton setTitle:title forState:UIControlStateNormal];
    } else {
        [_valueTime_limitButton setTitle:[TranslateUtil translatePickDate:_expireType] forState:UIControlStateNormal];
        [_valueTime_stopButton setTitle:[TranslateUtil translatePickDate:_expireType] forState:UIControlStateNormal];
        [_valueTime_ocoButton setTitle:[TranslateUtil translatePickDate:_expireType] forState:UIControlStateNormal];
    }
}


@end
