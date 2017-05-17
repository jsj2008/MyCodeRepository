//
//  OrderModifyContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderAddOrModifyContentView.h"
#import "UIColor+CustomColor.h"
#import "ScreenAuotoSizeScale.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "AccountUtil.h"
#import "JEDIDateTime.h"
#import "QuoteDataStore.h"
#import "CDS_PriceSnapShot.h"
#import "InstrumentUtil.h"
#import "APIDoc.h"
#import "CommDataUtil.h"
#import "DecimalUtil.h"
#import "MTP4CommDataInterface.h"
#import "ZLKeyboard.h"
#import "ResizeForKeyboard.h"
#import "ScreenAuotoSizeScale.h"
#import "UIFormat.h"
#import "TradeUtil.h"
#import "ShowAlert.h"
#import "ClientAPI.h"
#import "MTP4CommDataInterface.h"
#import "IosLogic.h"
#import "InstWarnConfig.h"
#import "ClientUIUtil.h"
#import "JEDIDateTime.h"
#import "ImageUtils.h"

#import "TimeSelectView.h"

#import "TradeApi.h"

#import "CertificateUtil.h"
#import "PhonePinInputView.h"
#import "TranslateUtil.h"

//#import "DropDownView.h"
#import "MTP4CommDataInterface.h"

#import "ResizeForKeyboard.h"

#import "LeftViewController.h"
#import "ClientSystemConfig.h"
#import "LimitDigistField.h"

#import "DateTypePickerView.h"
#import "OrderPositionContentView.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

#define LimitView 0
#define StopView 1
#define OcoView 2

#define TypeDay     0
#define TypeWeek    1
#define TypeGtc     2
#define TypeUser    3


@interface OrderAddOrModifyContentView()<API_Event_QuoteDataStore, CustomSecmentControlViewDelegate, QuoteSegmentControlDelegate, ZLKeyboardDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    
    double _limitPriceValue;
    double _stopPriceValue;
    double _IDTLimitPriceValue;
    double _IDTStopPriceValue;
    
    //    int _digist;
    
    NSString *_limitSymbol;
    NSString *_stopSymbol;
    // sell false
    // buy true
    Boolean _isBuySell;
    
    ZLKeyboard *_keyboard;
    UITextField *currentField;
    CGFloat currentY;
    
    //    DropDownView *dropView;
    //    DropDownView *_limitDropView;
    //    DropDownView *_stopDropView;
    //    DropDownView *_ocoDropView;
    
    TimeSelectView *_timeView;
    
    NSDate *_pickDate;
    //    int _currentType;
    
    UIView *_backgroundView;
    
    DateTypePickerView *_dateTypePickerView;
    int _expireType;
    
    NSArray *pickerArray;
    
    TradeResult_OrderCFD *orderResult;
    
    UIAlertView *_successAlertView;
}


@end

@implementation OrderAddOrModifyContentView

@synthesize order = _order;
@synthesize instrument = _instrument;

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
@synthesize IDTlimit_limitLabel = _IDTlimit_limitLabel;
@synthesize IDTStop_limitLabel = _IDTStop_limitLabel;
@synthesize valueTime_limitLabel = _valueTime_limitLabel;

@synthesize limitPrice_limitField = _limitPrice_limitField;
@synthesize amount_limitField = _amount_limitField;
@synthesize IDTlimit_limitField = _IDTlimit_limitField;
@synthesize IDTStop_limitField = _IDTStop_limitField;
//@synthesize valueTime_limitField = _valueTime_limitField;
@synthesize valueTime_limitButton = _valueTime_limitButton;

// stopView
@synthesize stopPrice_stopLabel = _stopPrice_stopLabel;
@synthesize amount_stopLabel = _amount_stopLabel;
@synthesize IDTlimit_stopLabel = _IDTlimit_stopLabel;
@synthesize IDTStop_stopLabel = _IDTStop_stopLabel;
@synthesize valueTime_stopLabel = _valueTime_stopLabel;

@synthesize stopPrice_stopField = _stopPrice_stopField;
@synthesize amount_stopField = _amount_stopField;
@synthesize IDTlimit_stopField = _IDTlimit_stopField;
@synthesize IDTStop_stopField = _IDTStop_stopField;
//@synthesize valueTime_stopField = _valueTime_stopField;
@synthesize valueTime_stopButton = _valueTime_stopButton;

// ocoView
@synthesize limitPrice_ocoLabel = _limitPrice_ocoLabel;
@synthesize stopPrice_ocoLabel = _stopPrice_ocoLabel;
@synthesize amount_ocoLabel = _amount_ocoLabel;
@synthesize valueTime_ocoLabel = _valueTime_ocoLabel;

@synthesize limitPrice_ocoField = _limitPrice_ocoField;
@synthesize stopPrice_ocoField = _stopPrice_ocoField;
@synthesize amount_ocoField = _amount_ocoField;
//@synthesize valueTime_ocoField = _valueTime_ocoField;
@synthesize valueTime_ocoButton = _valueTime_ocoButton;

+ (OrderAddOrModifyContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderAddOrModifyContentView" owner:self options:nil];
    OrderAddOrModifyContentView *orderAddOrModifyContentView = [nib objectAtIndex:0];
    [orderAddOrModifyContentView setFrame:ContentRect];
    [orderAddOrModifyContentView initContentView];
    return orderAddOrModifyContentView;
}

- (void)initContentView {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_2];
    [self initData];
    
    if (_instrument == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"InstrumentIsNull"]];
        return;
    }
    
    [self initUI];
    [self initKeyboard];
    //    [self addListener];
}

- (void)initData {
    _order = [[DataCenter getInstance] order];
    _instrument = [[DataCenter getInstance] orderInstrument];
    if (_order == nil) {
        self.instrumentLabel.userInteractionEnabled = true;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseInstrumentAction:)];
        [self.instrumentLabel addGestureRecognizer:tapAction];
        _expireType = ORDER_EXPIRE_TYPE_GTC;
    } else {
        _expireType = [_order getExpireType];
    }
    [self resetTimeButtonTitle];
}

- (void)initUI {
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrument];
    //    [self initDropDownView];
    [self initDatePickerView];
    [self initSimpleUI:pss];
    [self initQuoteSegment:pss];
    [self initThirdSegmentView];
    [self updateSymbol];
    [self initMainView];
}

- (void)addKChartView {
    //    [((LeftViewController *)[[[IosLogic getInstance] getWindow] rootViewController]) popKChartView:_instrument];
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

- (void)initThirdSegmentView {
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
}

- (void)initQuoteSegment:(CDS_PriceSnapShot *)pss {
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int extraDigit = [inst getExtraDigit];
    [_quoteSegmentControl setStyle:STYLE_NORMAL];
    
    if (_order != nil) {
        [_quoteSegmentControl setSelectIndex:[_order getBuysell]];
        _quoteSegmentControl.userInteractionEnabled = false;
    } else {
        [_quoteSegmentControl setSelectIndex:IndexSell];
        _quoteSegmentControl.userInteractionEnabled = true;
    }
    
    [_quoteSegmentControl setDelegate:self];
    [_quoteSegmentControl setExtradigit:extraDigit];
    [self updateSegmentControlAsk:[pss getAsk] bid:[pss getBid]];
}

- (void)initSimpleUI:(CDS_PriceSnapShot *)pss {
    [_instrumentLabel setText:_instrument];
    // account
    [_accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    // time
    [self updateTime:[pss snapshotTime]];
}

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

- (void)initMainView {
    // add button
    if (_order != nil) {
        [self addModifyButton];
    } else {
        [self addAddButton];
    }
    
    [self initLimitView];
    [self initStopView];
    [self initOcoView];
    
    [self updateLimitIDT];
    [self updateStopIDT];
    
    [self initPlaceholder];
    
    [self initBackgroundView];
    [self setBackgroundColor:[UIColor backgroundColor]];
    [self initValueTimeButton];
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
    //        NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTimeButton, _touchButton, nil];
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

- (void)initPlaceholder {
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    
    NSString *placeholder = [NSString stringWithFormat:@"%@ %@", [inst getCcy1], [DecimalUtil formatNumber:[CommDataUtil getDefaultCcy1Amount:_instrument]]];
    _amount_limitField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    _amount_stopField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    _amount_ocoField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (void)initBackgroundView {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)addAddButton {
    CGFloat edage = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    CGFloat heigh = [ScreenAuotoSizeScale CGAutoMakeFloat:25.0f];
    CGFloat width = SCREEN_WIDTH - edage * 2;
    CGFloat y = self.frame.size.height - 50.0f;
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
    
    [confirmButton addTarget:self action:@selector(orderAddOrModify) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addModifyButton {
    CGFloat edage = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    CGFloat heigh = [ScreenAuotoSizeScale CGAutoMakeFloat:25.0f];
    CGFloat width = SCREEN_WIDTH - edage * 2;
    CGFloat y = self.frame.size.height - 50.0f;
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
    
    [modifyButton addTarget:self action:@selector(orderAddOrModify) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton addTarget:self action:@selector(checkCADelete) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initLimitView {
    // limitView
    [self updateLimitIDT];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    NSString *limitPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    limitPrice = [limitPrice stringByAppendingFormat:@"%@%@):", _limitSymbol, [DecimalUtil formatDoubleByNoStyle:_limitPriceValue digit:_digist]];
    
    NSString *amount = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    NSString *valueTime = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]];
    
    [_limitPrice_limitLabel setText:limitPrice];
    [_amount_limitLabel setText:amount];
    [_valueTime_limitLabel setText:valueTime];
    
    if (_order != nil) {
        [_limitPrice_limitField setText:[DecimalUtil formatMoney:[_order getLimitPrice] digist:_digist]];
        [_amount_limitField setText:[DecimalUtil formatNumber:[_order getAmount]]];
        [_IDTlimit_limitField setText:[DecimalUtil formatMoney:[_order getIFDLimitPrice] digist:_digist]];
        [_IDTStop_limitField setText:[DecimalUtil formatMoney:[_order getIFDStopPrice] digist:_digist]];
        
        if ([_order getLimitPrice] <= 0.00001) {
            [_limitPrice_limitField setText:@""];
        }
        
        if ([_order getIFDLimitPrice] <= 0.00001) {
            [_IDTlimit_limitField setText:@""];
        }
        
        if ([_order getIFDStopPrice] <= 0.00001) {
            [_IDTStop_limitField setText:@""];
        }
    }
}

- (void)initStopView {
    // stopView
    [self updateStopIDT];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    NSString *stopPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    stopPrice = [stopPrice stringByAppendingFormat:@"%@%@):", _stopSymbol, [DecimalUtil formatDoubleByNoStyle:_stopPriceValue digit:_digist]];
    
    NSString *amount = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    NSString *valueTime = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]];
    
    [_stopPrice_stopLabel setText:stopPrice];
    [_amount_stopLabel setText:amount];
    [_valueTime_stopLabel setText:valueTime];
    
    if (_order != nil) {
        [_stopPrice_stopField setText:[DecimalUtil formatMoney:[_order getCurrentStopPrice] digist:_digist]];
        [_amount_stopField setText:[DecimalUtil formatNumber:[_order getAmount]]];
        [_IDTlimit_stopField setText:[DecimalUtil formatMoney:[_order getIFDLimitPrice] digist:_digist]];
        [_IDTStop_stopField setText:[DecimalUtil formatMoney:[_order getIFDStopPrice] digist:_digist]];
        
        if ([_order getCurrentStopPrice] <= 0.00001) {
            [_stopPrice_stopField setText:@""];
        }
        
        if ([_order getIFDLimitPrice] <= 0.00001) {
            [_IDTlimit_stopField setText:@""];
        }
        
        if ([_order getIFDStopPrice] <= 0.00001) {
            [_IDTStop_stopField setText:@""];
        }
    }
}

- (void)initOcoView {
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    NSString *limitPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    limitPrice = [limitPrice stringByAppendingFormat:@"%@%@):", _limitSymbol, [DecimalUtil formatDoubleByNoStyle:_limitPriceValue digit:_digist]];
    
    NSString *stopPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    stopPrice = [stopPrice stringByAppendingFormat:@"%@%@):", _stopSymbol, [DecimalUtil formatDoubleByNoStyle:_stopPriceValue digit:_digist]];
    
    NSString *amount = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"Amount"]];
    
    NSString *valueTime = [NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]];
    
    [_limitPrice_ocoLabel setText:limitPrice];
    [_stopPrice_ocoLabel setText:stopPrice];
    [_amount_ocoLabel setText:amount];
    [_valueTime_ocoLabel setText:valueTime];
    
    if (_order != nil) {
        [_limitPrice_ocoField setText:[DecimalUtil formatMoney:[_order getLimitPrice] digist:_digist]];
        [_stopPrice_ocoField setText:[DecimalUtil formatMoney:[_order getCurrentStopPrice] digist:_digist]];
        [_amount_ocoField setText:[DecimalUtil formatNumber:[_order getAmount]]];
        
        if ([_order getLimitPrice] <= 0.00001) {
            [_limitPrice_ocoField setText:@""];
        }
        
        if ([_order getCurrentStopPrice] <= 0.00001) {
            [_stopPrice_ocoField setText:@""];
        }
        
    }
}

- (void)updateData:(int)type {
    [self updateSymbol];
    _limitPriceValue = [CommDataUtil getLimitPrice:_instrument bunysell:_isBuySell];
    _stopPriceValue = [CommDataUtil getStopPrice:_instrument bunysell:_isBuySell];
    _IDTLimitPriceValue = [self getIDFLimitPrice:_isBuySell selectType:type];
    _IDTStopPriceValue = [self getIDFStopPrice:_isBuySell selectType:type];
}

- (double)getIDFStopPrice:(Boolean)buySell selectType:(int)type{
    double price  = 0.0f;
    if (type == LimitView) {
        price = [_limitPrice_limitField.text doubleValue];
        if (price <= 0.00001) {
            price = _limitPriceValue;
        }
    } else {
        price = [_stopPrice_stopField.text doubleValue];
        if (price <= 0.00001) {
            price = _stopPriceValue;
        }
    }
    
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrument];
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    double ifdStopPrice = 0.0f;
    double stopMinGap = [inst getSafeGap4OpenOrder];
    if (buySell) {
        //        ifdStopPrice = price - stopMinGap * [instUtil getOnePointPrice] * 2;
        ifdStopPrice = price - stopMinGap * [instUtil getOnePointPrice];
    } else {
        //        ifdStopPrice = price + stopMinGap * [instUtil getOnePointPrice] * 2;
        ifdStopPrice = price + stopMinGap * [instUtil getOnePointPrice];
    }
    return ifdStopPrice;
}

- (double)getIDFLimitPrice:(Boolean)buySell selectType:(int)type{
    double price  = 0.0f;
    if (type == LimitView) {
        price = [_limitPrice_limitField.text doubleValue];
        if (price <= 0.00001) {
            price = _limitPriceValue;
        }
    } else {
        price = [_stopPrice_stopField.text doubleValue];
        if (price <= 0.00001) {
            price = _stopPriceValue;
        }
    }
    
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrument];
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    double ifdLimitPrice = 0.0f;
    double stopMinGap = [inst getSafeGap4OpenOrder];
    if (buySell) {
        //        ifdLimitPrice = price + stopMinGap * [instUtil getOnePointPrice] * 2;
        ifdLimitPrice = price + stopMinGap * [instUtil getOnePointPrice];
    } else {
        //        ifdLimitPrice = price - stopMinGap * [instUtil getOnePointPrice] * 2;
        ifdLimitPrice = price - stopMinGap * [instUtil getOnePointPrice];
    }
    return ifdLimitPrice;
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


#pragma privatefunc

- (void)updateSegmentControlAsk:(double)ask bid:(double)bid{
    if (_instrument == nil) {
        return;
    }
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrument];
    [_quoteSegmentControl refreshSegmentAsk:[instUtil formatClientPrice:ask]
                                   bidPrice:[instUtil formatClientPrice:bid]];
}

- (void)updateTime:(long long)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    [_timeLabel setText:[JEDIDateTime stringUIFromTime:date]];
}

- (void)updatePrice {
    if (_instrument == nil) {
        return;
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    _limitPriceValue = [CommDataUtil getLimitPrice:_instrument bunysell:_isBuySell];
    _stopPriceValue = [CommDataUtil getStopPrice:_instrument bunysell:_isBuySell];
    
    NSString *limitPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"LimitPrice"]];
    limitPrice = [limitPrice stringByAppendingFormat:@"%@%@):", _limitSymbol, [DecimalUtil formatDoubleByNoStyle:_limitPriceValue digit:_digist]];
    
    NSString *stopPrice = [NSString stringWithFormat:@"%@(", [[LangCaptain getInstance] getLangByCode:@"StopPrice"]];
    stopPrice = [stopPrice stringByAppendingFormat:@"%@%@):", _stopSymbol, [DecimalUtil formatDoubleByNoStyle:_stopPriceValue digit:_digist]];
    
    [_limitPrice_limitLabel setText:limitPrice];
    [_limitPrice_ocoLabel setText:limitPrice];
    [_stopPrice_stopLabel setText:stopPrice];
    [_stopPrice_ocoLabel setText:stopPrice];
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

- (void)buttonClicked {
    //    [self updateData];
    [self updateSymbol];
    [self updatePrice];
}

#pragma privateFunc

- (void)updateSymbol {
    _isBuySell = [_quoteSegmentControl selectIndex] == IndexBuy;
    if (_isBuySell) {
        _limitSymbol = @"<";
        _stopSymbol = @">";
    } else {
        _limitSymbol = @">";
        _stopSymbol = @"<";
    }
}

- (void)updateLimitIDT {
    [self updateData:LimitView];
    
    if (_instrument == nil) {
        return;
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    NSString *IDTlimit = [NSString stringWithFormat:@"IDT(%@", [[LangCaptain getInstance] getLangByCode:@"Limit"]];
    IDTlimit = [IDTlimit stringByAppendingFormat:@"%@%@):", _stopSymbol, [DecimalUtil formatDoubleByNoStyle:_IDTLimitPriceValue digit:_digist]];
    
    NSString *IDTStop = [NSString stringWithFormat:@"IDT(%@", [[LangCaptain getInstance] getLangByCode:@"Stop"]];
    IDTStop = [IDTStop stringByAppendingFormat:@"%@%@):", _limitSymbol, [DecimalUtil formatDoubleByNoStyle:_IDTStopPriceValue digit:_digist]];
    
    [_IDTlimit_limitLabel setText:IDTlimit];
    [_IDTStop_limitLabel setText:IDTStop];
}

- (void)updateStopIDT {
    [self updateData:StopView];
    
    if (_instrument == nil) {
        return;
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int _digist = [inst getDigits];
    
    NSString *IDTlimit = [NSString stringWithFormat:@"IDT(%@", [[LangCaptain getInstance] getLangByCode:@"Limit"]];
    IDTlimit = [IDTlimit stringByAppendingFormat:@"%@%@):", _stopSymbol, [DecimalUtil formatDoubleByNoStyle:_IDTLimitPriceValue digit:_digist]];
    
    NSString *IDTStop = [NSString stringWithFormat:@"IDT(%@", [[LangCaptain getInstance] getLangByCode:@"Stop"]];
    IDTStop = [IDTStop stringByAppendingFormat:@"%@%@):", _limitSymbol, [DecimalUtil formatDoubleByNoStyle:_IDTStopPriceValue digit:_digist]];
    
    [_IDTlimit_stopLabel setText:IDTlimit];
    [_IDTStop_stopLabel setText:IDTStop];
}

- (void)updateUI {
    if (currentField == _limitPrice_limitField) {
        [self updateLimitIDT];
    }
    
    if (currentField == _stopPrice_stopField) {
        [self updateStopIDT];
    }
    
    //    if (currentField == _amount_limitField || currentField == _amount_ocoField || currentField == _amount_stopField) {
    ////        currentField.text = [DecimalUtil formatNumber:[self getAmount]];
    //        NSString *text = [DecimalUtil formatNumber:[self getAmount]];
    //        currentField.text = text;
    //        if ([text isEqualToString:@"0"]) {
    //            currentField.text = @"";
    //        }
    //
    //    }
}

#pragma keyboardDelegate
- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
    //    currentField.text = string;
    //    [self updateOccupyMargin];
    [self updateUI];
}

- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string{
    //    if ([string isEqualToString:@""] || [string isEqualToString:@"0"]) {
    if (string == nil || [string isEqualToString:@""]) {
        currentField.text = @"";
    } else {
        //        double amount = [CommDataUtil numberFromString:string];
        //        amountFeild.text = [DecimalUtil formatDoubleByNoStyle:amount digit:0];
        //        amountFeild.text = [DecimalUtil formatNumber:amount];
        //        amountFeild.text = [@(amount) stringValue];
        
        //        currentField.text = string;
        
    }
    [self updateUI];
    //    [self updateOccupyMargin];
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
    currentY = textField.frame.origin.y + [textField superview].frame.origin.y + [[textField superview] superview].frame.origin.y;
    CGFloat distance = 0.0f;
    if (DISTANCE_FROM_TOP - currentY <= 0.0f) {
        distance = DISTANCE_FROM_TOP - currentY;
    }
    [ResizeForKeyboard setViewPosition:[[self superview] superview] forY:distance];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [currentField resignFirstResponder];
//    [ResizeForKeyboard setViewPosition:[[self superview] superview]forY:0];
//    return true;
//}

#pragma alert delegate

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    [alertView setDelegate:nil];
    
    // 若点确定
    if (alertView == [[ShowAlert getInstance] chooseableAlertView] && buttonIndex == 1) {
        [self checkCAOrderTrade];
        //        [[[ShowAlert getInstance] chooseableAlertView] setDelegate:nil];
        //        [[ShowAlert getInstance] setChooseableAlertView:nil];
        //        return;
    }
    
    //    if (alertView == [[ShowAlert getInstance] jumpAlertView] && buttonIndex == 0) {
    
    if (alertView == _successAlertView) {
        //        [[[ShowAlert getInstance] jumpAlertView] setDelegate:nil];
        
        if (orderResult != nil) {
            NSLog(@"order id is %lld", [[orderResult order] getOrderID]);
            [OrderPositionContentView setScrollOrderID:[NSString stringWithFormat:@"%lld", [[orderResult order] getOrderID]]];
        }
        [[IosLogic getInstance] gotoOrderPositionViewController];
        
        //         [[ShowAlert getInstance] setJumpAlertView:nil];
        //        return;
    }
    
    
}

#pragma dotrade

- (void)orderAddOrModify {
    if (![self checkInputData]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"InputIsNull"]];
        return;
    }
    
    [self rebackOrigin];
    
    double amount           = [self getAmount];
    double limitPrice       = [self getLimit];
    double stopPrice        = [self getStop];
    double ifdLimitPrice    = [self getIDTLimit];
    double ifdStopPrice     = [self getIDTStop];
    
    if (amount < 0.000001) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountNill"]];
        return;
    }
    
    CheckWarningNode *node = [self checkAndShowWarning:limitPrice
                                             stopPrice:stopPrice
                                              ifdLimit:ifdLimitPrice
                                               ifdStop:ifdStopPrice];
    
    if (![node isSucceed]) {
        [[ShowAlert getInstance] showChooseableAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                      andMessage:[node errorMsg]
                                                        delegate:self];
        return;
    }
    [self checkCAOrderTrade];
}

- (Boolean)check {
    double amount = [self getAmount];
    if (![TradeUtil isLegalTradeAmount:amount]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountErr"]];
        return false;
    }
    
    NSString *tradeAmtLeg = [[APIDoc getGeneralCheckUtil] isTradeAmountLegal4MKTTrade2:_instrument
                                                                                  acid:[[ClientAPI getInstance] getAccount]
                                                                               buySell:_isBuySell == BUY ? TRUE : FALSE
                                                                                amount:amount];
    
    if (tradeAmtLeg != nil) {
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:tradeAmtLeg];
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:errMsg];
        return false;
    }
    return true;
}

- (void)checkCAOrderTrade {
    if (![self check]) {
        return;
    }
    
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
                                           action:@selector(phonePinCancelOrderTrade:)
                                 forControlEvents:UIControlEventTouchUpInside];
        [phonePinInputView.commitButton addTarget:self
                                           action:@selector(phonePinCommitOrderTrade:)
                                 forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self doOrderTrade];
    }
}

- (void)phonePinCancelOrderTrade:(id)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)phonePinCommitOrderTrade:(id)sender {
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
            [self doOrderTrade];
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

- (void)doOrderTrade {
   
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    double amount           = [self getAmount];
    
    double limitPrice       = [self getLimit];
    double stopPrice        = [self getStop];
    double ifdLimitPrice    = [self getIDTLimit];
    double ifdStopPrice     = [self getIDTStop];
    
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
    
    // 新建下单 和 修改下单
    if (_order == nil) {
        // 新建下单
        IP_TRADESERV5103 *ip = [[TradeApi getInstance] createOpenNormalOrderCFDTradeAccount:[[ClientAPI getInstance] getAccount]
                                                                                 instrument:_instrument
                                                                               isBuyNotSell:_isBuySell
                                                                                     amount:amount
                                                                                 limitPrice:limitPrice
                                                                               oriStopPrice:stopPrice
                                                                                  toOpenNew:true
                                                                             toCloseTickets:[[NSMutableArray alloc] init]
                                //                                                                                 expiryType:[self arrayTypeToExprieType:[_limitDropView getSelectIndex]]
                                                                                 expiryType:_expireType
                                                                                nexpireTime:[self getTime:true]
                                                                              IFDLimitPrice:ifdLimitPrice
                                                                               IFDStopPrice:ifdStopPrice];
        NSString *signature = [CertificateUtil getPkcs7sin:ip];
        
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            orderResult = [[TradeApi getInstance] doOpenNormalOrderCFDTrade:ip
                                                                  signature:signature];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                
                [self doresult:orderResult];
            });
        });
        
    } else {
        if (![CommDataUtil isUptradeOrder:[_order getOrderID]]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
            return;
        }
        
        if (![CommDataUtil isPriceReached:[_order getOrderID]]) {
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
            return;
        }
        // 修改下单
        IP_TRADESERV5104 *ip = [[TradeApi getInstance] createModifyOrderAccount:[[ClientAPI getInstance] getAccount]
                                                                        orderID:[_order getOrderID]
                                                                         amount:amount
                                                                    stopMoveGap:INT32_MAX
                                                                     linutPirce:limitPrice
                                                                   oriStopPrice:stopPrice
                                //                                                                     expiryType:[self arrayTypeToExprieType:[_limitDropView getSelectIndex]]
                                                                     expiryType:_expireType
                                                                     expiryTime:[self getTime:true]
                                                                  IFDLimitPrice:ifdLimitPrice
                                                                   IFDStopPrice:ifdStopPrice];
        NSString *signature = [CertificateUtil getPkcs7sin:ip];
        
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            orderResult = [[TradeApi getInstance] doModifyOrder:ip
                                                      signature:signature];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                [self doresult:orderResult];
            });
        });
    }
}
//_errMessage	__NSCFString *	@"Expire time error!Sat Mar 07 03:00:00 CST 2015"	0x7d003ce0
- (void)doresult:(TradeResult_OrderCFD*)result {
    if ([result result] == RESULT_SUCCEED) {
        [self showJumpAlertView:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                     andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderSuccess"]
                       delegate:self];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_3];
    } else  {
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]];
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:errMsg];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_4];
    }
}

// 趕時間 有時間的時候修改
- (void)checkCADelete {
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
                                           action:@selector(phonePinCancelDelete :)
                                 forControlEvents:UIControlEventTouchUpInside];
        [phonePinInputView.commitButton addTarget:self
                                           action:@selector(phonePinCommitDelete :)
                                 forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self doDeleteOrder];
    }
}

- (void)phonePinCancelDelete :(id)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)phonePinCommitDelete :(id)sender {
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
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_6];
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    [self rebackOrigin];
    if (_order == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderNotExsit"]];
        return;
    }
    
    if (![CommDataUtil isUptradeOrder:[_order getOrderID]]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    if (![CommDataUtil isPriceReached:[_order getOrderID]]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"OrderLocked"]];
        return;
    }
    
    IP_TRADESERV5105 *ip = [[TradeApi getInstance] createDeleteOrderTradeAccount:[[ClientAPI getInstance] getAccount] orderID:[_order getOrderID]];
    NSString *signature = [CertificateUtil getPkcs7sin:ip];
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TradeResult *result = [[TradeApi getInstance] doDeleteOrderTrade:ip signature:signature];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            
            if ([result succeed]) {
                [self showJumpAlertView:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                             andMessage:[[LangCaptain getInstance] getLangByCode:@"DeleteSuccess"]
                               delegate:self];
            } else {
                NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result errCode]];
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:errMsg];
            }
        });
    });
}

- (void)doCancel {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_7];
    if (_order != nil) {
        [OrderPositionContentView setScrollOrderID:[NSString stringWithFormat:@"%lld", [_order getOrderID]]];
    }
    [[IosLogic getInstance] gotoOrderPositionViewController];
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


#pragma getFunc
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

- (double)getIDTLimit {
    switch ([_thirdSegmentControl selectIndex]) {
        case LimitView:
            return [self getDoubleValue:_IDTlimit_limitField.text];
        case StopView:
            return [self getDoubleValue:_IDTlimit_stopField.text];
        case OcoView:
            return 0.0f;
        default:
            break;
    }
    return 0.0f;
}

- (double)getIDTStop {
    switch ([_thirdSegmentControl selectIndex]) {
        case LimitView:
            return [self getDoubleValue:_IDTStop_limitField.text];
        case StopView:
            return [self getDoubleValue:_IDTStop_stopField.text];
        case OcoView:
            return 0.0f;
        default:
            break;
    }
    return 0.0f;
}

- (NSDate *)getValueTime {
    //    if ([self arrayTypeToExprieType:[_limitDropView getSelectIndex]] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
    if (_expireType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        return _pickDate;
    }
    return nil;
}

- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

#pragma return origin
- (void)rebackOrigin {
    [self keyboardReturn];
    [self hideTimeView];
    [self hideTimeTypeView];
    //    [dropView hideDropDown];
    //    [_limitDropView hideDropDown];
    //    [_stopDropView hideDropDown];
    //    [_ocoDropView hideDropDown];
}

#pragma private keyboard init

-(void) chooseInstrumentAction:(UITapGestureRecognizer *)recognizer{
    //    NSArray *allInstrument = [[APIDoc getSystemDocCaptain] getInstrumentArray];
    //    NSArray *unSelectInstrument = [[ClientSystemConfig getInstance] unselectInstrumentArray];
    //    NSMutableArray *selectInstrument = [[NSMutableArray alloc] init];
    //    for (Instrument *instrument in allInstrument) {
    //        if (![unSelectInstrument containsObject:[instrument getInstrument]]) {
    //            [selectInstrument addObject:instrument];
    //        }
    //    }
    //
    //    [[IosLogic getInstance] gotoChooseViewController:OrderChoose
    //                                         chooseArray:selectInstrument];
    
    
    [[IosLogic getInstance] gotoChooseViewController:OrderChoose
                                         chooseArray:[[ClientSystemConfig getInstance] getSelectedInstrumentArray]];
    
}

- (void)initKeyboard {
    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:TradeNumberKeyboard];
    keyboard.delegate = self;
    _keyboard = keyboard;
    //    self.userNameTextFild.inputView = self.keyboard;
    
    [self reInitTextField:_limitPrice_limitField];
    [self reInitTextField:_amount_limitField];
    [self reInitTextField:_IDTlimit_limitField];
    [self reInitTextField:_IDTStop_limitField];
    
    [self reInitTextField:_stopPrice_stopField];
    [self reInitTextField:_amount_stopField];
    [self reInitTextField:_IDTlimit_stopField];
    [self reInitTextField:_IDTStop_stopField];
    
    [self reInitTextField:_stopPrice_ocoField];
    [self reInitTextField:_limitPrice_ocoField];
    [self reInitTextField:_amount_ocoField];
}

- (void)reInitTextField:(UITextField *)textField{
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    CGFloat radio = textField.frame.size.height / 2 - 4.0f;
    textField.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:radio];
    textField.layer.borderWidth = 1.0f;
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setTextColor:[UIColor whiteColor]];
    textField.inputView = _keyboard;
    [textField setDelegate:self];
    
    if ([textField isKindOfClass:[LimitDigistField class]]) {
        Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
        int _digist = [inst getDigits];
        [((LimitDigistField *)textField) setDigist:_digist];
    }
}

#pragma action
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
//}

//- (void)otherAction:(int)index atView:(DropDownView *)atView{
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
//            //            [_timeView.datePicker setMinimumDate:[NSDate new]];
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

- (void)addDoneAction:(UIView *)timeView {
    for (NSObject *object in [timeView subviews]) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)object;
            [button addTarget:self action:@selector(getTimeFromTimeView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
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

- (NSString *)getTime:(Boolean)isTrade {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if (isTrade) {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return [dateFormat stringFromDate:[self getValueTime]];
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

#pragma util
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

- (void)dealloc {
    //    [[[ShowAlert getInstance] jumpAlertView] setDelegate:nil];
    //    [[[ShowAlert getInstance] jumpAlertView] dismissWithClickedButtonIndex:0 animated:NO];
}

- (void)showJumpAlertView:(NSString *)title andMessage:(NSString *)message delegate:(id)delegate{
    
    _successAlertView = [[UIAlertView alloc] initWithTitle:title
                                                   message:message
                                                  delegate:delegate
                                         cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                                         otherButtonTitles:nil];
    [_successAlertView show];
}

@end
