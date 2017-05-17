//
//  OpenPositionView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MarketTradeView.h"
#import "UIFormat.h"
#import "JumpDataCenter.h"
#import "QuoteDataStore.h"
#import "APIDoc.h"
#import "LangCaptain.h"
#import "AccountUtil.h"
#import "DecimalUtil.h"
#import "CommDataUtil.h"
#import "ClientAPI.h"
//#import "ZLKeyboard.h"
#import "IOSLayoutDefine.h"
#import "QuoteDataStore.h"

#import "ShowAlertManager.h"
#import "TradeActionUtil.h"

#import "LayoutCenter.h"

#import "ZLKeyboardView.h"
#import "TextFieldController.h"

#import "CheckUtils.h"
#import "ActionUtils.h"

#import "BlackgroundTextField.h"

@interface MarketTradeView()<API_Event_QuoteDataStore, ZLKeyboardDelegate> {
    NSString *_instrumentName;
}

@end

@implementation MarketTradeView

@synthesize accountLabel;
@synthesize instrumentLabel;
@synthesize timeLabel;

@synthesize quoteView;
@synthesize lhSlideView;

@synthesize amountLabel;
@synthesize amountTextField;
@synthesize marginCallLabel;
@synthesize commitButton;
@synthesize cancelButton;

#pragma init
- (void)initContent {
    [self setBackgroundColor:[UIColor blackColor]];
    
    [commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"TradeCommit"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    [self.quoteView setIsNeedChangeBuySell:true];
    
    [self initKeyboard];
    
    [self.commitButton addTarget:self action:@selector(doMKTTrade) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [instrumentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:[ActionUtils getInstance]
                                                                                  action:@selector(instrumentPick)]];
}

- (void)initKeyboard {
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLeftTradeNumber];
    self.amountTextField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.amountTextField];
    [self.amountTextField  setDelegate:(id)inputView];
    [inputView setKeyboardDelegate:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma abstract
- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)updateView {
    _instrumentName         = [[JumpDataCenter getInstance] createTradeInstrument];
    int buySellType         = [[JumpDataCenter getInstance] marketTradeType];
    if (buySellType == BUY) {
        [self.quoteView setBuyStatus];
    } else {
        [self.quoteView setSellStatus];
    }
    CDS_PriceSnapShot *pss  = [[QuoteDataStore getInstance] getQuoteData:_instrumentName];
    
    [accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    [instrumentLabel setText:_instrumentName];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrumentName];
    [amountLabel setText:[NSString stringWithFormat:@"%@: ", [[LangCaptain getInstance] getLangByCode:@"Amount"]]];
    //    [marginCallLabel setText:[[LangCaptain getInstance] getLangByCode:@"OccupyMargin"]];
    NSString *placeholder = [NSString stringWithFormat:@"%@ %@", [inst getCcy1], [DecimalUtil formatNumber:[CommDataUtil getDefaultCcy1Amount:_instrumentName]]];
    self.amountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    [self updateValue:pss];
    [self.amountTextField setText:@""];
    [self updateOccupyMargin];
}

#pragma privateFunc

- (void)updateOccupyMargin{
    double openMarginPercentage = [[[APIDoc getSystemDocCaptain] getInstrument:_instrumentName] getOpenMarginPercentage];
    NSString *ccy1 = [[[APIDoc getSystemDocCaptain] getInstrument:_instrumentName] getCcy1];
    double m = [[APIDoc getExchangeUtil] exchangeToAccountBasicCcy:[[ClientAPI getInstance] accountID]
                                                              Ccy1:ccy1
                                                            Amount:[self getAmount]];
    
    NSString *value = [DecimalUtil formatMoney:m * openMarginPercentage digist:2];
    [self.marginCallLabel setText:[NSString stringWithFormat:@"%@   %@", [[LangCaptain getInstance] getLangByCode:@"OccupyMargin"], value]];
}

- (double)getAmount{
    NSString *ocMarginValueString = self.amountTextField.text;
    if (ocMarginValueString == nil || [ocMarginValueString isEqualToString:@""]) {
        // 若为默认 则返回0
        return 0.0f;
    } else {
        return [CommDataUtil numberFromString:self.amountTextField.text];
    }
}

#pragma quoteDataStore

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:_instrumentName]) {
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
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrumentName];
//    [self.quoteView.leftSubview      updateValue:[instUtil formatClientPrice:bid isFloor:true]];
//    [self.quoteView.rightSubview     updateValue:[instUtil formatClientPrice:ask isFloor:true]];
    [self.quoteView.leftSubview updateValue:[instUtil formatClientPrice:bid]];
    [self.quoteView.rightSubview updateValue:[instUtil formatClientPrice:ask]];
}

- (void)updateTime:(long long)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    [self.timeLabel setText:[JEDIDateTime stringUIFromTime:date]];
}

#pragma dotrade
- (void)doMKTTrade{
    [[TextFieldController getInstance] keyboardReturen];
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrumentName];
    if (pss == nil) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"UpdateFailed"]
                                                            delegate:nil];
        return;
    }
    
    Boolean isBuySell = ([self.quoteView currentBuySell] == BUY);
    double amount = [self getAmount];
    if (![CheckUtils checkAmount:amount buySell:isBuySell instrument:_instrumentName]) {
        return;
    }
    
    [[TradeActionUtil getInstance]doMKTTradeInstrumentName:_instrumentName
                                                 isBuySell:isBuySell
                                                    amount:[self getAmount]
                                             priceSnapshot:pss];
}

- (void)doCancelAction {
    // 如果取消 跳轉 報價list界面
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
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
            
//            if ([textField.text containsString:@"."]) {
//                NSString *digistString = [stringArray objectAtIndex:1];
//                if ([digistString length] > self.digist) {
//                    isEditAble = false;
//                }
//            }
            
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
    //    double amount = [self getDoubleAmount:textField.text];
    [self updateOccupyMargin];
}

- (void)textFieldEndEdit:(UITextField *)textField {
    double amount = [self getDoubleAmount:textField.text];
    NSString *value = [DecimalUtil formatNumber:amount];
    if (amount <= 0.00001 && amount >= -0.00001) {
        value = @"";
    }
    [textField setText:value];
    ZLTradeNumberKeyboard *keyboardView = [(ZLKeyboardView *)textField.inputView getTradeNumberKeyboard];
    [keyboardView setHidden:true];
}

- (double)getDoubleAmount:(NSString *)amount {
    if (amount == nil || [amount length] == 0) {
        return 0.0f;
    }
    return [[amount stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
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
    if (_instrumentName != nil && [_instrumentName length] > 0) {
        CDS_PriceSnapShot *pss  = [[QuoteDataStore getInstance] getQuoteData:_instrumentName];
        [self updateValue:pss];
    }
}

@end
