//
//  PriceWarningAddOrModifyContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PriceWarningAddOrModifyContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "AccountUtil.h"
#import "QuoteDataStore.h"
#import "InstrumentUtil.h"
#import "APIDoc.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "DropDownView.h"
#import "MTP4CommDataInterface.h"
#import "TimeSelectView.h"
#import "ResizeForKeyboard.h"
#import "ZLKeyboard.h"
#import "UIFormat.h"
#import "IosLogic.h"
#import "TradeApi.h"
#import "ShowAlert.h"
#import "ClientAPI.h"
#import "DecimalUtil.h"
#import "DataCenter.h"
#import "ClientSystemConfig.h"
#import "LimitDigistField.h"
#import "DateTypePickerView.h"
#import "TranslateUtil.h"
#import "CheckWarningNode.h"
#import "InstWarnConfig.h"
#import "ClientUIUtil.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

//#define TypeDay     0
//#define TypeWeek    1
//#define TypeGtc     2
//#define TypeUser    3

#define Comparway_Bigger 1
#define Comparway_Smaller 2



@interface PriceWarningAddOrModifyContentView() <API_Event_QuoteDataStore, ZLKeyboardDelegate, UITextFieldDelegate> {
    NSDate *_pickDate;
    
    TimeSelectView *_timeSelectView;
    UIView *_backgroundView;
    
    ZLKeyboard *_keyboard;
    
    UITextField *_currentField;
    
    DateTypePickerView *_dateTypePickerView;
    
    int _expireType;
    NSArray *pickerArray;
}
@end

@implementation PriceWarningAddOrModifyContentView

//@synthesize floatPLStatus = _floatPLStatus;
@synthesize accountLabel = _accountLabel;
@synthesize instrumentLabel = _instrumentLabel;
@synthesize timeLabel = _timeLabel;
@synthesize quoteSegmentControl = _quoteSegmentControl;

@synthesize priceLabel = _priceLabel;
@synthesize priceTextField = _priceTextField;
@synthesize valueTimeButton = _valueTimeButton;

@synthesize valueTimeLabel = _valueTimeLabel;

@synthesize lhSlideView = _lhSlideView;


+ (PriceWarningAddOrModifyContentView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PriceWarningAddOrModifyContentView" owner:self options:nil];
    PriceWarningAddOrModifyContentView *contentView = [nib objectAtIndex:0];
    [contentView setFrame:ContentRect];
    [contentView initContentView];
    return [nib objectAtIndex:0];
}

- (void)initContentView {
    
    [self initData];
    
    if (_instrument == nil) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"InstrumentIsNull"]];
        return;
    }
    
    [self initUI];
    
    [self addGestureRecognizer];
    [self initKeyboard];
    //    [self addListener];
}

- (void)initData {
    _instrument = [[DataCenter getInstance] priceWarningInstrument];
    _priceWarning = [[DataCenter getInstance] priceWarning];
    if (_priceWarning == nil) {
        _expireType = ORDER_EXPIRE_TYPE_GTC;
    } else {
        _expireType = [_priceWarning getExpiryType];
    }
    [self resetTimeButtonTitle];
}

- (void)initUI {
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrument];
    // 根据各个UI来初始化 // 方便维护
    [self initDatePickerView];
    [self initSimpleUI:pss];
    [self initQuoteSegment:pss];
    [self initLHSlider:pss];
    [self initMainView:pss];
    [self initBackgroundView];
    
}

- (void)initDatePickerView {
    pickerArray = [[NSArray alloc] initWithObjects:
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H1],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H2],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H4],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H8],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H12],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H16],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_DAY],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_WEEK],
                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_GTC], nil];
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
    if (_timeSelectView == nil) {
        _timeSelectView = [TimeSelectView newInstance];
        
        if ([[[LangCaptain getInstance] getLangConfig] isEqualToString:LangConfig_TW]) {
            [_timeSelectView.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hant_CN"]];
        } else {
            [_timeSelectView.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        }
        
        [self addDoneAction:_timeSelectView];
        [_timeSelectView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
        
        [[[self superview] superview] addSubview:_backgroundView];
        
        [[[self superview] superview] addSubview:_timeSelectView];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [_timeSelectView setFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        // 没有Other
        // 盖住button
        [ResizeForKeyboard setViewPosition:[self superview] forY:-70];
        
        [UIView commitAnimations];
    }
}

- (void)showSelectPicker {
    [self rebackOriginSender:nil];
    [[[self superview] superview] addSubview:_dateTypePickerView];
    [_dateTypePickerView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    [_dateTypePickerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [ResizeForKeyboard setViewPosition:[self superview] forY:-70];
    
    [UIView commitAnimations];
}

- (void)initSimpleUI:(CDS_PriceSnapShot *)pss {
    // 初始化 不需要复杂赋值 不需要监听的简单控件
    [self.accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    [self.instrumentLabel setText:_instrument];
    [self updateTime:[pss snapshotTime]];
}

- (void)initQuoteSegment:(CDS_PriceSnapShot *)pss {
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int extraDigit = [inst getExtraDigit];
    
    [self updateSegmentControlAsk:[pss getAsk] bid:[pss getBid]];
    [_quoteSegmentControl setStyle:STYLE_MIX];
    [_quoteSegmentControl setExtradigit:extraDigit];
    
    _quoteSegmentControl.userInteractionEnabled = false;
}

- (void)initLHSlider:(CDS_PriceSnapShot *)pss {
    double midPrice = ([pss getAsk] + [pss getBid]) / 2;
    double percent = (midPrice - [pss lowPrice]) / ([pss highPrice] - [pss lowPrice]);
    [_lhSlideView updateCurrentPercent:percent];
}

- (void)initMainView:(CDS_PriceSnapShot *)pss {
    //    [self.touchLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"PirceTouch"]]];
    //    [self updateValuePriceAsk:[pss getAsk] bid:[pss getBid]];
    
    NSString *price = [NSString stringWithFormat:@"%@:",[[LangCaptain getInstance] getLangByCode:@"WarningPrice"]];
    [self.priceLabel setText:price];
    
    [self.valueTimeLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"ValidDateTo"]]];
    
    if (_priceWarning != nil) {
        Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
        int digist = [inst getDigits];
        [self.priceTextField setText:[DecimalUtil formatMoney:[_priceWarning getPrice] digist:digist]];
        [self.priceTextField setPlaceholder:[[LangCaptain getInstance] getLangByCode:@"PleaseInputWarningPrice"]];
        
        
        if ([_priceWarning getExpiryType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
            _pickDate = [_priceWarning getExpiryTime];
            NSString *title = [NSString stringWithFormat:@"  %@", [self getTime]];
            [self.valueTimeButton setTitle:title forState:UIControlStateNormal];
        } else {
            _expireType  =[_priceWarning getExpiryType];
            [self resetTimeButtonTitle];
        }
        
    }
    [self.valueTimeButton addTarget:self action:@selector(showSelectPicker) forControlEvents:UIControlEventTouchUpInside];
    
    // style
    //    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTimeButton, _touchButton, nil];
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTimeButton, nil];
    for (UIButton *button in buttonArray) {
        CGFloat radio = _valueTimeButton.frame.size.height / 2 - 4.0f;
        [button setBackgroundColor:[UIColor clearColor]];
        button.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:radio];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    [self addConfirmButton];
    
    [self setBackgroundColor:[UIColor backgroundColor]];
    
}

- (void)initBackgroundView {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)addGestureRecognizer {
    if (_priceWarning == nil) {
        self.instrumentLabel.userInteractionEnabled = true;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseInstrumentAction:)];
        
        [self.instrumentLabel addGestureRecognizer:tapAction];
        
    }
}

#pragma init

-(void) chooseInstrumentAction:(UITapGestureRecognizer *)recognizer{
    
    //    NSArray *allInstrument = [[APIDoc getSystemDocCaptain] getInstrumentArray];
    //    NSArray *unSelectInstrument = [[ClientSystemConfig getInstance] unselectInstrumentArray];
    //    NSMutableArray *selectInstrument = [[NSMutableArray alloc] init];
    //    for (Instrument *instrument in allInstrument) {
    //        if (![unSelectInstrument containsObject:[instrument getInstrument]]) {
    //            [selectInstrument addObject:instrument];
    //        }
    //    }
    
    //    [[IosLogic getInstance] gotoChooseViewController:InstrumentChoose chooseArray:selectInstrument];
    [[IosLogic getInstance] gotoChooseViewController:InstrumentChoose
                                         chooseArray:[[ClientSystemConfig getInstance] getSelectedInstrumentArray]];
    
}

- (void)initKeyboard {
    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:TradeNumberKeyboard];
    keyboard.delegate = self;
    _keyboard = keyboard;
    [self reInitTextField:self.priceTextField];
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

- (void)addConfirmButton {
    CGFloat edage = [ScreenAuotoSizeScale CGAutoMakeFloat:10.0f];
    CGFloat heigh = [ScreenAuotoSizeScale CGAutoMakeFloat:25.0f];
    CGFloat width = SCREEN_WIDTH - edage * 2;
    CGFloat y = self.frame.size.height - 50.0f;
    CGRect confirmRect = CGRectMake(edage,                         y, width / 2 - 2.0f, heigh);
    CGRect cancelRect = CGRectMake(edage + width / 2 + 2.0f,       y, width / 2 - 2.0f, heigh);
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:confirmRect];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelRect];
    
    [confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ConfirmSend"] forState:UIControlStateNormal];
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
    
    [confirmButton addTarget:self action:@selector(priceWarningAddOrModify) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)priceWarningAddOrModify {
    
    if (![self checkPrice]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PriceErr"]];
        return;
    }
    
    if (![self checkIsReached]) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountPassed"]];
        return;
    }
    
    CheckWarningNode *node = [self checkAndShowPriceWarning:[self getValuePrice]
                                                 instrument:_instrument];
    
    if (![node isSucceed]) {
        [[ShowAlert getInstance] showChooseableAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                      andMessage:[node errorMsg]
                                                        delegate:self];
        return;
    }
    [self doTrade];
}

- (void)doTrade {
    if (_priceWarning == nil) {
        
        //        if (![self checkType]) {
        //            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"TouchTypeErr"]];
        //            return;
        //        }
        
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsDealing"] onView:self];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            PriceWarning *pw = [[TradeApi getInstance] addPriceWarningAccount:[[ClientAPI getInstance] getAccount]
                                                                   instrument:_instrument
                                                                        price:[self getValuePrice]
                                //                                                                    priceType:[_dropDownTouchView getSelectIndex] + 1
                                                                    priceType:PRIVATE_MODDLE // 都使用中間價
                                //                                                                   expiryType:[self arrayTypeToExprieType:[_dropDownValueTimeView getSelectIndex]]
                                                                   expiryType:_expireType
                                                                   expiryTime:[self getValueTime]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowAlert getInstance] hidenAlertWaitView];
                if (pw == nil) {
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"AddPriceWarningFailed"]];
                } else {
                                        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"AddPriceWarningSuccess"]];
                    [[DataCenter getInstance] queryPriceWarning];
                    [[IosLogic getInstance] gotoPriceWarningViewController];
                }
            });
        });
    } else {
        [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsDealing"] onView:self];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            PriceWarning *pw = [[TradeApi getInstance] modPriceWarning:[_priceWarning getGuid]
                                                                 price:[self getValuePrice]
                                //                                                            expiryType:[self arrayTypeToExprieType:[_dropDownValueTimeView getSelectIndex]]
                                                            expiryType:_expireType
                                                            expiryTime:[self getValueTime]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (pw == nil) {
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"ModifyPriceWarningFailed"]];
                } else {
                    [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                        andMessage:[[LangCaptain getInstance] getLangByCode:@"ModifyPriceWarningSuccess"]];
                    [[DataCenter getInstance] queryPriceWarning];
                    [[IosLogic getInstance] gotoPriceWarningViewController];
                }
            });
        });
    }
}

- (Boolean)checkPrice {
    double biggerPrice = [self getPriceLevel:Comparway_Bigger];
    double smallerPrice = [self getPriceLevel:Comparway_Smaller];
    
    if (self.priceTextField.text == nil || [self.priceTextField.text isEqualToString:@""]) {
        return false;
    }
    
    if ([self getValuePrice] < biggerPrice && [self getValuePrice] > smallerPrice) {
        return false;
    }
    
    return true;
}

- (double)getPriceLevel:(int)compareWay {
    double priceLevel = 0;
    CDS_PriceSnapShot *lastQuote = [[QuoteDataStore getInstance] getQuoteData:_instrument];
    if (lastQuote != nil) {
        priceLevel = ([lastQuote getAsk] + [lastQuote getBid]) / 2;
    }
    
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    
    int minGap = 1;
    switch (compareWay) {
        case Comparway_Bigger:
            priceLevel += minGap * pow(10, -1 * [inst getDigits]);
            break;
        case Comparway_Smaller:
            priceLevel -= minGap * pow(10, -1 * [inst getDigits]);
            break;
        default:
            break;
    }
    return priceLevel;
}

- (Boolean)checkIsReached {
    if (_priceWarning == nil) {
        return true;
    }
    if (!([_priceWarning getIsPriceReach] == 0)) {
        return false;
    }
    return true;
}

- (void)doCancel {
    
    [[IosLogic getInstance] gotoPriceWarningViewController];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self rebackOriginSender:nil];
    _currentField = textField;
    [_keyboard resetInputString:textField.text];
    [_keyboard setCurrentTextField:_currentField];
    //    currentY = [[textField superview] superview].frame.origin.y;
    CGFloat currentY = textField.frame.origin.y;
    CGFloat distance = 0.0f;
    if (120 - currentY <= 0.0f) {
        distance = 120 - currentY;
    }
    [ResizeForKeyboard setViewPosition:[[self superview] superview] forY:distance];
}

- (void)addDoneAction:(UIView *)timeView {
    for (NSObject *object in [timeView subviews]) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)object;
            [button addTarget:self action:@selector(getTimeFromTimeView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma getFunc

- (void)getTimeFromTimeView{
    [self rebackOriginSender:nil];
    //    [_timeView.datePicker ]
    _pickDate = _timeSelectView.datePicker.date;
    NSString *prettyVersion = [NSString stringWithFormat:@"  %@", [self getTime]];
    [_valueTimeButton setTitle:prettyVersion forState:UIControlStateNormal];
    [_backgroundView removeFromSuperview];
    
    [self hideTimeView];
}

- (NSString *)getTime {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:[self getValueTime]];
}

- (NSDate *)getValueTime {
    //    if ([self arrayTypeToExprieType:[_dropDownValueTimeView getSelectIndex]] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
    if (_expireType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        return _pickDate;
    }
    return nil;
}

- (double)getValuePrice {
    return [self getDoubleValue:self.priceTextField.text];
}

- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

- (void)hideTimeView {
    [UIView transitionWithView:_timeSelectView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        [_timeSelectView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
                    }
                    completion:^(BOOL finished){
                        [_timeSelectView removeFromSuperview];
                        _timeSelectView = nil;
                    }];
    [ResizeForKeyboard setViewPosition:[self superview] forY:SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT];
}

- (void)rebackOriginSender:(id)sender {
    [self keyboardReturn];
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
    //    [self removeListener];
    
    [_floatPLStatus removeFromSuperview];
    _floatPLStatus = nil;
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_instrument == nil) {
            return;
        }
        
        if ([[snapshot instrumentName] isEqualToString:_instrument]) {
            [self updateSegmentControlAsk:[snapshot getAsk] bid:[snapshot getBid]];
            
            //            [self updatePrice];
            //            [self updateValuePriceAsk:[snapshot getAsk] bid:[snapshot getBid]];
            double midPrice = ([snapshot getAsk] + [snapshot getBid]) / 2;
            double percent = (midPrice - [snapshot lowPrice]) / ([snapshot highPrice] - [snapshot lowPrice]);
            [_lhSlideView updateCurrentPercent:percent];
            [self updateTime:[snapshot snapshotTime]];
        }
    });
    
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
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    [_timeLabel setText:[JEDIDateTime stringUIFromTime:date]];
}

//- (void)updateValuePriceAsk:(double)ask bid:(double)bid {
//    if (_instrument == nil) {
//        return;
//    }
////    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrument];
////    NSString *price = [[LangCaptain getInstance] getLangByCode:@"Value"];
////    price = [price stringByAppendingString:[NSString stringWithFormat:@"(>%@或<%@):", [instUtil formatClientPrice:ask], [instUtil formatClientPrice:bid]]];
////    [self.priceLabel setText:price];
//}

#pragma keyboardDelegate
- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
    _currentField.text = string;
    //    [self updateOccupyMargin];
    //    [self updateUI];
}

- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string{
    if ([string isEqualToString:@""]) {
        _currentField.text = @"";
    } else {
        //        double amount = [CommDataUtil numberFromString:string];
        //        amountFeild.text = [DecimalUtil formatDoubleByNoStyle:amount digit:0];
        //        amountFeild.text = [DecimalUtil formatNumber:amount];
        //        amountFeild.text = [@(amount) stringValue];
        _currentField.text = string;
    }
    //    [self updateUI];
    //    [self updateOccupyMargin];
}

- (void)keyboardReturn {
    [_currentField resignFirstResponder];
    _currentField = nil;
    [ResizeForKeyboard setViewPosition:[[self superview] superview]forY:0];
}

- (void)resetTimeButtonTitle {
    // time
    //    NSString *day   = [NSString stringWithFormat:@"  NYC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
    //    NSString *week  = [NSString stringWithFormat:@"  GTW %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
    //    NSString *gtc   = [NSString stringWithFormat:@"  GTC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
    
    //    NSString *other = [NSString stringWithFormat:@"  Other %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
    //    NSArray *timearr = [[NSArray alloc] initWithObjects:day, week, gtc, nil];
    if (_expireType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        NSString *title = [NSString stringWithFormat:@"  %@", [self getTime]];
        [self.valueTimeButton setTitle:title forState:UIControlStateNormal];
    } else {
        [self.valueTimeButton setTitle:[TranslateUtil translatePickDate:_expireType] forState:UIControlStateNormal];
    }
}

#pragma 防呆检测
// 防呆检查
- (CheckWarningNode *)checkAndShowPriceWarning:(double)price instrument:(NSString *)instrument {
    double percent = [[InstWarnConfig getInstance] getWarningPerc];
    return [ClientUIUtil checkAndShowPriceWarning:price
                                       instrument:instrument
                                          percent:percent];
    //    return [ClientUIUtil checkAndShowWarningBuySell:_isBuySell
    //                                         limitPrice:limitPrice
    //                                          stopPrice:stopPrice
    //                                      ifdLimitPrice:ifdLimit
    //                                       ifdStopPrice:ifdStop
    //                                         instrument:_instrument
    //                                            percent:percent];
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    // 若点确定
    if (alertView == [[ShowAlert getInstance] chooseableAlertView] && buttonIndex == 1) {
        [self doTrade];
        return;
    }
}

- (void)dealloc {
    _quoteSegmentControl = nil;
    _timeLabel = nil;
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
//
//    return 0;
//    //        ORDER_EXPIRE_TYPE_GTC = 0,
//    //        ORDER_EXPIRE_TYPE_DAY = 1,
//    //        ORDER_EXPIRE_TYPE_WEEK = 2,
//    //        ORDER_EXPIRE_TYPE_USER_DEFINED = 3,
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

//- (void)initDropDownView {
//
//    // touch
//    //    NSString *buyString = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"Sell"]];
//    //    NSString *sellString = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"Buy"]];
//    //    NSString *middleString = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"Middle"]];
//    //    NSArray *toucharr = [[NSArray alloc] initWithObjects:buyString, sellString, middleString,  nil];
//    //    _dropDownTouchView = [[DropDownView alloc] initWithRect:self.touchButton array:toucharr direction:true];
//    //    [[self.touchButton superview] addSubview:_dropDownTouchView];
//    //    [_dropDownTouchView setDelegate:self];
//
//    //    if (_priceWarning == nil) {
//    //        //        [self.touchButton setUserInteractionEnabled:true];
//    //        [_dropDownTouchView setSelectIndex:0];
//    //        //        [self.touchButton addTarget:self action:@selector(touchDropDownViewAction:) forControlEvents:UIControlEventTouchUpInside];
//    //    } else {
//    //        //        [self.touchButton setUserInteractionEnabled:false];
//    //        [_dropDownTouchView setSelectIndex:[_priceWarning getPriceType] - 1];
//    //    }
//
//    // time
//    NSString *gtc   = [NSString stringWithFormat:@"  GTC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
//    NSString *week  = [NSString stringWithFormat:@"  GTW %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
//    NSString *day   = [NSString stringWithFormat:@"  NYC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
//    NSString *other = [NSString stringWithFormat:@"  Other %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
//    NSArray *timearr = [[NSArray alloc] initWithObjects:day, week, gtc, other, nil];
//    _dropDownValueTimeView = [[DropDownView alloc] initWithRect:self.valueTimeButton array:timearr direction:true];
//    [[self.valueTimeButton superview] addSubview:_dropDownValueTimeView];
//    [_dropDownValueTimeView setDelegate:self];
//
//    if (_priceWarning == nil) {
//        [_dropDownValueTimeView setSelectIndex:TypeGtc];
//
//    } else {
//        [_dropDownValueTimeView setSelectIndex:[self exprieTypeToArrayType: [_priceWarning getExpiryType]]];
//
//        if ([_priceWarning getExpiryType] == ORDER_EXPIRE_TYPE_USER_DEFINED) {
//            _pickDate = [_priceWarning getExpiryTime];
//            NSString *title = [NSString stringWithFormat:@"  %@", [self getTime]];
//            [self.valueTimeButton setTitle:title forState:UIControlStateNormal];
//        }
//    }
//    //    [self.valueTimeButton addTarget:self action:@selector(timeDropDownViewAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.valueTimeButton addTarget:self action:@selector(showSelectPicker) forControlEvents:UIControlEventTouchUpInside];
//
//    // style
//    //    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTimeButton, _touchButton, nil];
//    NSArray *buttonArray = [[NSArray alloc] initWithObjects:_valueTimeButton, nil];
//    for (UIButton *button in buttonArray) {
//        CGFloat radio = _valueTimeButton.frame.size.height / 2 - 4.0f;
//        [button setBackgroundColor:[UIColor clearColor]];
//        button.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:radio];
//        button.layer.borderWidth = 1.0f;
//        button.layer.borderColor = [UIColor whiteColor].CGColor;
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//}


@end
