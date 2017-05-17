//
//  PriceWarningView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PriceWarningView.h"
#import "LangCaptain.h"
#import "ZLKeyboardView.h"
#import "ActionUtils.h"
#import "QuoteDataStore.h"
#import "JumpDataCenter.h"
#import "AccountUtil.h"
#import "APIDoc.h"
#import "ValueTimeButton.h"
#import "DecimalUtil.h"
#import "ShowAlertManager.h"
#import "MTP4CommDataInterface.h"
#import "TradeActionUtil.h"
#import "LayoutCenter.h"
#import "BlackgroundTextField.h"
#import "CheckWarningNode.h"
#import "InstWarnConfig.h"
#import "WarningUtil.h"
#import "ShowAlertManager.h"

typedef NS_ENUM(NSUInteger, Comparway) {
    ComparwayBigger     = 0,
    ComparwaySmall      = 1,
};

@interface PriceWarningView()<ZLKeyboardDelegate, API_Event_QuoteDataStore, CustomAlertDelegate> {
    Boolean isAddOrModify;
}

@end

@implementation PriceWarningView

@synthesize accountLabel;
@synthesize instrumentLabel;
@synthesize timeLabel;

@synthesize quoteView;
@synthesize lhSlideView;

@synthesize pushPriceLabel;
@synthesize pushPriceTextField;

@synthesize buttonPanelView;

@synthesize instrumentName;
@synthesize digist;

- (void)initContent {
    [self setBackgroundColor:[UIColor blackColor]];
    [self.pushPriceLabel setText:[NSString stringWithFormat:@"%@ :", [[LangCaptain getInstance] getLangByCode:@"WarningPrice"]]];
    [self.valueTimeLabel setText:[NSString stringWithFormat:@"%@ :", [[LangCaptain getInstance] getLangByCode:@"ValidDate"]]];
    [accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    [self.valueTimeButton addTarget:[ActionUtils getInstance]
                             action:@selector(showDatePickView:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.valueTimeButton setValueTimeButtonType:2];
    
    [self.valueTimeButton setTimeShowButton:self.showTimeButton];
    
    CGFloat radio = self.showTimeButton.frame.size.height / 2 - 4.0f;
    [self.showTimeButton setBackgroundColor:[UIColor clearColor]];
    self.showTimeButton.layer.cornerRadius = radio;
    self.showTimeButton.layer.borderWidth = 1.0f;
    self.showTimeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.showTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self initKeyboard];
}

- (void)initKeyboard {
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLeftTradeNumber];
    self.pushPriceTextField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.pushPriceTextField];
    [self.pushPriceTextField  setDelegate:(id)inputView];
    [inputView setKeyboardDelegate:self];
}

#pragma abstract
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)updateView {
    CDS_PriceSnapShot *pss  = [[QuoteDataStore getInstance] getQuoteData:self.instrumentName];
    [instrumentLabel setText:self.instrumentName];
    
    [self updateValue:pss];
}

- (void)resetInputValue {
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            [(UITextField *)subview setText:@""];
        }
        if ([subview isKindOfClass:[ValueTimeButton class]]) {
            [(ValueTimeButton *)subview setDateType:ORDER_EXPIRE_TYPE_GTC];
        }
    }
}

#pragma quoteDataStore
- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:self.instrumentName]) {
            [self updateValue:snapshot];
        }
    });
}

// 更新时间 QuoteView LHSlider
- (void)updateValue:(CDS_PriceSnapShot *)pss {
    [self updateQuoteViewAsk:[pss getAsk] bid:[pss getBid]];
    double midPrice = ([pss getAsk] + [pss getBid]) / 2;
    double percent = (midPrice - [pss lowPrice]) / ([pss highPrice] - [pss lowPrice]);
    [lhSlideView updateCurrentPercent:percent];
    [self updateTime:[pss snapshotTime]];
}

- (void)updateQuoteViewAsk:(double)ask bid:(double)bid{
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:self.instrumentName];
//    [self.quoteView.leftSubview      updateValue:[instUtil formatClientPrice:bid isFloor:true]];
//    [self.quoteView.rightSubview     updateValue:[instUtil formatClientPrice:ask isFloor:true]];
    
    [self.quoteView.leftSubview     updateValue:[instUtil formatClientPrice:bid]];
    [self.quoteView.rightSubview    updateValue:[instUtil formatClientPrice:ask]];
}

- (void)updateTime:(long long)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    [self.timeLabel setText:[JEDIDateTime stringUIFromTime:date]];
}

#pragma ZLKeyboard delegate
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
    //    [self updateOccupyMargin];
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
        CDS_PriceSnapShot *pss  = [[QuoteDataStore getInstance] getQuoteData:self.instrumentName];
        [self updateValue:pss];
    }
}

- (void)initAddOrModify:(AddOrModifyType)type {
    switch (type) {
        case AddType:
            [self typeAddPriceWarning];
            break;
        case ModifyType:
            [self typeModifyPriceWarning];
            break;
        default:
            break;
    }
}

- (void)initWithPriceWarning:(PriceWarning *)priceWarning {
    [self.pushPriceTextField setText:[DecimalUtil formatMoney:[priceWarning getPrice] digist:digist]];
    [self.valueTimeButton setDateType:[priceWarning getExpiryType]];
    [self.valueTimeButton setDateValueTime:[priceWarning getExpiryTime]];
    
}

- (void)typeAddPriceWarning {
    [self setPanelHidden:true];
//    [self.valueTimeButton setUserInteractionEnabled:true];
    [self.buttonPanelView.addCommitButton addTarget:self
                                             action:@selector(doTrade:)
                                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonPanelView.addCancelButton addTarget:self
                                             action:@selector(doCancel)
                                   forControlEvents:UIControlEventTouchUpInside];
}

- (void)typeModifyPriceWarning {
    [self setPanelHidden:false];
//    [self.valueTimeButton setUserInteractionEnabled:false];
    [self.buttonPanelView.modifyCommitButton addTarget:self
                                                action:@selector(doTrade:)
                                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonPanelView.modifyCancelButton addTarget:self
                                                action:@selector(doCancel)
                                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonPanelView.modifyDeleteButton addTarget:self
                                                action:@selector(doDelete)
                                      forControlEvents:UIControlEventTouchUpInside];
}

- (void)setPanelHidden:(Boolean)isAddPanel {
    [self.buttonPanelView.modifyButtonPanel   setHidden:isAddPanel];
    [self.buttonPanelView.addButtonPanel      setHidden:!isAddPanel];
}

#pragma tradeAction
- (void)doTrade:(id)sender {
    if (![self checkPrice]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PriceErr"]
                                                            delegate:nil];
        return;
    }
    
    CheckWarningNode *node = [self checkAndShowPriceWarning:[self getValuePrice]
                                                 instrument:instrumentName];
    
    
    
    if ([sender isKindOfClass:[UIButton class]]) {
        NSInteger tag = [(UIButton *)sender tag];
        if (tag == OrderTradeTypeAdd) {
            isAddOrModify = true;
        }
        if (tag == OrderTradeTypeModify) {
            isAddOrModify = false;
        }
        
        if (![node isSucceed]) {
            [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                              andMessage:[node errorMsg]
                                                                delegate:self];
            return;
        }
        
        switch (tag) {
            case OrderTradeTypeAdd:
                [self doAddOrder];
                break;
            case OrderTradeTypeModify:
                [self doModifyOrder];
                break;
            default:
                break;
        }
    }
}

- (void)doAddOrder {
    int expireType          = (int)[self.valueTimeButton getDateType];
    NSDate *expireTime    = [self.valueTimeButton getDateValueDate];
    
    [[TradeActionUtil getInstance] doAddPriceWarningInstrument:self.instrumentName
                                                         price:[self getValuePrice]
                                                     priceType:PRIVATE_MODDLE
                                                    expireType:expireType
                                                    expireTime:expireTime];
}

- (void)doModifyOrder {
    int expireType          = (int)[self.valueTimeButton getDateType];
    NSDate *expireTime    = [self.valueTimeButton getDateValueDate];
    
    if (![self checkIsReached]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountPassed"]
                                                            delegate:nil];
        return;
    }
    [[TradeActionUtil getInstance] doModifyPriceWarningGuid:[[[JumpDataCenter getInstance] priceWarning] getGuid]
                                                      price:[self getValuePrice]
                                                 expireType:expireType
                                                 expireTime:expireTime];
    
}

#pragma alert delegate
-(void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index {
    [alertView setDelegate:nil];
    if (index == 1) {
        if (isAddOrModify) {
            [self doAddOrder];
        } else {
            [self doModifyOrder];
        }
    }
}


- (void)doCancel {
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
}

- (void)doDelete {
    if (![self checkIsReached]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountPassed"]
                                                            delegate:nil];
        return;
    }
    
    [[TradeActionUtil getInstance] doDeletePriceWarningGuid:[[[JumpDataCenter getInstance] priceWarning] getGuid]];
}

#pragma private Function
- (Boolean)checkPrice {
    double biggerPrice = [self getPriceLevel:ComparwayBigger];
    double smallerPrice = [self getPriceLevel:ComparwaySmall];
    
    if (self.pushPriceTextField.text == nil || [self.pushPriceTextField.text isEqualToString:@""]) {
        return false;
    }
    
    if ([self getValuePrice] < biggerPrice && [self getValuePrice] > smallerPrice) {
        return false;
    }
    
    return true;
}

- (double)getPriceLevel:(int)compareWay {
    double priceLevel = 0;
    CDS_PriceSnapShot *lastQuote = [[QuoteDataStore getInstance] getQuoteData:self.instrumentName];
    if (lastQuote != nil) {
        priceLevel = ([lastQuote getAsk] + [lastQuote getBid]) / 2;
    }
    
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:self.instrumentName];
    
    int minGap = 1;
    switch (compareWay) {
        case ComparwayBigger:
            priceLevel += minGap * pow(10, -1 * [inst getDigits]);
            break;
        case ComparwaySmall:
            priceLevel -= minGap * pow(10, -1 * [inst getDigits]);
            break;
        default:
            break;
    }
    return priceLevel;
}

- (Boolean)checkIsReached {
    if ([[JumpDataCenter getInstance] priceWarning] == nil) {
        return true;
    }
    if (!([[[JumpDataCenter getInstance] priceWarning] getIsPriceReach] == PRICE_REACH_STATE_NORMAL)) {
        return false;
    }
    return true;
}

- (double)getValuePrice {
    return [self getDoubleValue:self.pushPriceTextField.text];
}

- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

// 防呆检查
- (CheckWarningNode *)checkAndShowPriceWarning:(double)price instrument:(NSString *)instrument {
    double percent = [[InstWarnConfig getInstance] getWarningPerc];
    return [WarningUtil checkAndShowPriceWarning:price
                                      instrument:instrument
                                         percent:percent];
}

@end
