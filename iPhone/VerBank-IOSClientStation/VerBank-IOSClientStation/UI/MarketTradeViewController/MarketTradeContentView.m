//
//  MarketTradeContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MarketTradeContentView.h"
#import "FloatPLStatus.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "APIDoc.h"
#import "ClientAPI.h"
#import "LangCaptain.h"
#import "QuoteDataStore.h"
#import "VerLabel.h"
#import "QuoteSegmentControl.h"
#import "LHSlideView.h"
#import "DecimalUtil.h"
#import "UIFormat.h"
#import "TradeApi.h"
#import "ToOpenTradeNode.h"
#import "IosLogic.h"
#import "CommDataUtil.h"
#import "ShowAlert.h"
#import "ZLKeyboard.h"
#import "AccountUtil.h"
#import "OpenPositonResultView.h"
#import "ImageUtils.h"
#import "LeftViewController.h"
#import "OpenPositionFailed.h"
#import "UnableTextField.h"
#import "CertificateUtil.h"
#import "PhonePinInputView.h"
#import "TranslateUtil.h"
#import "AmountTextField.h"
#import "OpenPositionContentView.h"
#import "KChartView.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"
#import "TradeUtil.h"

#define Edage 10

@interface MarketTradeContentView()<API_Event_QuoteDataStore, ZLKeyboardDelegate, UIAlertViewDelegate, UITextFieldDelegate>{
    NSString *_instrument;
    int _isBuySell;
    FloatPLStatus *floatPLStatus;
    
    QuoteSegmentControl *segmentControl;
    UILabel *ocMarginValueLabel;
    VerLabel *timeLabel;
    AmountTextField *amountFeild;
    LHSlideView *lhSlideView;
    
    ZLKeyboard *_keyboard;
    
    UIView *_backgroundView;
    
    PhonePinInputView *phonePinInputView;
}

@property (nonatomic, strong) ZLKeyboard *keyboard;

@end

@implementation MarketTradeContentView

@synthesize keyboard = _keyboard;

- (id)initWithFrame:(CGRect)frame instrument:(NSString *)instrument buySell:(int)buySell{
    if (self = [super initWithFrame:frame]) {
        _isBuySell = buySell;
        _instrument = instrument;
        [self initFloatPLStatusBar];
        [self initLayout];
        //        [self addListener];
        [self initKeyboard];
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

- (void)addKChartView {
    [((LeftViewController *)[[[IosLogic getInstance] getWindow] rootViewController]) addKChartView:_instrument];
    [NSThread detachNewThreadSelector:@selector(runreloadHisToricData) toTarget:self withObject:nil];
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_8];
}

- (void)runreloadHisToricData {
    [NSThread sleepForTimeInterval:2.0f];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[KChartView getInstance] reloadHistoricData];
    });
}

- (void)initLayout{
    
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrument];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:_instrument];
    int extraDigit = [inst getExtraDigit];
    
    CGFloat width = IPHONE5_WIDTH - Edage * 2;
    
    CGRect accountRect          = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage, 35.0f, width / 3, 25.0f)];
    CGRect instrumentRect       = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage + width / 3, 35, width / 3, 25.0f)];
    CGRect timeRect             = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage + width / 3 * 2, 35, width / 3, 25.0f)];
    CGRect quoteSegmentRect     = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage, 65.0f, width, 60.0f)];
    CGRect lhSliderRect         = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage, 130.0f, width, 25.0f)];
    CGRect amountRect           = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage, 160.0f, 40.0f, 30.0f)];
    CGRect amountFeildRect      = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage + 40.0f, 160.0f, width - 40.0f, 30.0f)];
    CGRect occupyMarginNameRect = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage, 195.0f, 80.0f, 20.0f)];
    CGRect occupyMarginValueRect= [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage + 80.0f, 195.0f, width - 80.0f, 20.0f)];
    CGRect commitRect           = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage, 240.0f, width / 2 - 2.0f, 30.0f)];
    CGRect cancelRect           = [ScreenAuotoSizeScale CGAutoMakeRect:CGRectMake(Edage + width / 2 + 2.0f, 240.0f, width / 2 - 2.0f, 30.0f)];
    
    VerLabel *accountLabel      = [[VerLabel alloc] initWithFrame:accountRect];
    VerLabel *instrumentLabel   = [[VerLabel alloc] initWithFrame:instrumentRect];
    timeLabel                   = [[VerLabel alloc] initWithFrame:timeRect];
    segmentControl              = [[QuoteSegmentControl alloc] init];
    [segmentControl setFrame:quoteSegmentRect];
    [segmentControl setStyle:STYLE_NORMAL];
    [segmentControl setSelectIndex:_isBuySell];
    
    lhSlideView                 = [[LHSlideView alloc] initWithFrame:lhSliderRect];
    double midPrice = ([pss getAsk] + [pss getBid]) / 2;
    double percent = (midPrice - [pss lowPrice]) / ([pss highPrice] - [pss lowPrice]);
    [lhSlideView updateCurrentPercent:percent];
    
    UILabel *amountLabel        = [[UILabel alloc] initWithFrame:amountRect];
    amountFeild                 = [[AmountTextField alloc] initWithFrame:amountFeildRect];
    //    [amountFeild setDelegate:self];
    UILabel *ocMarginNameLabel  = [[UILabel alloc] initWithFrame:occupyMarginNameRect];
    ocMarginValueLabel          = [[UILabel alloc] initWithFrame:occupyMarginValueRect];
    UIButton *commitButton      = [[UIButton alloc] initWithFrame:commitRect];
    UIButton *cancelButton      = [[UIButton alloc] initWithFrame:cancelRect];
    
    [self addSubview:accountLabel];
    [self addSubview:instrumentLabel];
    [self addSubview:timeLabel];
    [self addSubview:segmentControl];
    [self addSubview:lhSlideView];
    [self addSubview:amountLabel];
    [self addSubview:amountFeild];
    [self addSubview:ocMarginNameLabel];
    [self addSubview:ocMarginValueLabel];
    [self addSubview:commitButton];
    [self addSubview:cancelButton];
    
    [accountLabel setText:[NSString stringWithFormat:@"%@:  %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
    //    [accountLabel setText:[AccountUtil getAccountID]];
    [instrumentLabel setText:_instrument];
    
    [self updateTime:[pss snapshotTime]];
    [amountLabel setText:[NSString stringWithFormat:@"%@: ", [[LangCaptain getInstance] getLangByCode:@"Amount"]]];
    [ocMarginNameLabel setText:[[LangCaptain getInstance] getLangByCode:@"OccupyMargin"]];
    NSString *placeholder = [NSString stringWithFormat:@"%@ %@", [inst getCcy1], [DecimalUtil formatNumber:[CommDataUtil getDefaultCcy1Amount:_instrument]]];
    amountFeild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    //    [amountFeild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self updateOccupyMargin];
    [commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"TradeCommit"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    [accountLabel setTextColor:[UIColor whiteColor]];
    [instrumentLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setTextColor:[UIColor whiteColor]];
    [amountLabel setTextColor:[UIColor whiteColor]];
    [amountFeild setTextColor:[UIColor whiteColor]];
    [ocMarginNameLabel setTextColor:[UIColor whiteColor]];
    [ocMarginValueLabel setTextColor:[UIColor whiteColor]];
    
    //    [UIFormat setViewStyle:commitButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:commitButton];
    [UIFormat setComplexBlueButtonColor:commitButton];
    
    //    [UIFormat setViewStyle:cancelButton
    //       withBackgroundColor:nil
    //        andTextNormalColor:[UIColor whiteColor]
    //          andTextHighColor:[UIColor whiteColor]
    //               andTextFont:nil
    //                 andCorner:UIRectCornerAllCorners];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:cancelButton];
    [UIFormat setComplexGrayButtonColor:cancelButton];
    
    [accountLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:10.0f]]];
    [instrumentLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:19.0f]]];
    [timeLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:10.0f]]];
    [amountLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:14.0f]]];
    [amountFeild setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:16.0f]]];
    [ocMarginNameLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:10.0f]]];
    
    [accountLabel setTextAlignment:NSTextAlignmentLeft];
    [accountLabel setVerticalAlignment:VerticalAlignmentBottom];
    [instrumentLabel setTextAlignment:NSTextAlignmentCenter];
    [instrumentLabel setVerticalAlignment:VerticalAlignmentBottom];
    [timeLabel setTextAlignment:NSTextAlignmentRight];
    [timeLabel setVerticalAlignment:VerticalAlignmentBottom];
    [amountLabel setTextAlignment:NSTextAlignmentLeft];
    [amountFeild setTextAlignment:NSTextAlignmentLeft];
    
    [segmentControl setExtradigit:extraDigit];
    [self updateSegmentControlAsk:[pss getAsk] bid:[pss getBid]];
    [amountFeild setBorderStyle:UITextBorderStyleRoundedRect];
    amountFeild.layer.cornerRadius = [ScreenAuotoSizeScale CGAutoMakeFloat:15.0f];
    amountFeild.layer.borderWidth = 1.0f;
    amountFeild.layer.borderColor = [UIColor whiteColor].CGColor;
    [amountFeild setBackgroundColor:[UIColor clearColor]];
    
    [self setBackgroundColor:[UIColor backgroundColor]];
    
    [commitButton addTarget:self action:@selector(checkCA) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    //    phonePinInputView = [PhonePinInputView newInstance];
}

- (void)initKeyboard{
    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:TradeNumberKeyboard];
    keyboard.delegate = self;
    self.keyboard = keyboard;
    [keyboard setCurrentTextField:amountFeild];
    amountFeild.inputView = self.keyboard;
}

#pragma quoteListener

- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    //    [self removeListener];
    
    [floatPLStatus removeFromSuperview];
    floatPLStatus = nil;
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:_instrument]) {
            [self updateSegmentControlAsk:[snapshot getAsk] bid:[snapshot getBid]];
            
            double midPrice = ([snapshot getAsk] + [snapshot getBid]) / 2;
            double percent = (midPrice - [snapshot lowPrice]) / ([snapshot highPrice] - [snapshot lowPrice]);
            [lhSlideView updateCurrentPercent:percent];
            [self updateTime:[snapshot snapshotTime]];
        }
    });
}

#pragma private

- (void)updateSegmentControlAsk:(double)ask bid:(double)bid{
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrument];
    [segmentControl refreshSegmentAsk:[instUtil formatClientPrice:ask]
                             bidPrice:[instUtil formatClientPrice:bid]];
}

- (void)updateTime:(long long)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    if (timeLabel != nil) {
        [timeLabel setText:[JEDIDateTime stringUIFromTime:date]];
    }
    
}

- (void)updateOccupyMargin{
    double openMarginPercentage = [[[APIDoc getSystemDocCaptain] getInstrument:_instrument] getOpenMarginPercentage];
    NSString *ccy1 = [[[APIDoc getSystemDocCaptain] getInstrument:_instrument] getCcy1];
    double m = [[APIDoc getExchangeUtil] exchangeToAccountBasicCcy:[[ClientAPI getInstance] getAccount]
                                                              Ccy1:ccy1
                                                            Amount:[self getAmount]];
    [ocMarginValueLabel setText:[DecimalUtil formatMoney:m * openMarginPercentage digist:2]];
}

- (double)getAmount{
    NSString *ocMarginValueString = amountFeild.text;
    if (ocMarginValueString == nil || [ocMarginValueString isEqualToString:@""]) {
        //        return [CommDataUtil getDefaultCcy1Amount:_instrument];
        // 若为默认 则返回0
        return 0.0f;
    } else {
        return [CommDataUtil numberFromString:amountFeild.text];
    }
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

#pragma trade
- (void)checkCA {
    [self keyboardReturn];
    
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
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Boolean isNeedReputPhonePin = [CertificateUtil checkPhonePinByValidate];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            if (isNeedReputPhonePin) {
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                phonePinInputView = [PhonePinInputView newInstance];
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
                [self doMKTTrade];
            }
        });
    });
    
    
    
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
            [self doMKTTrade];
        } else {
            if (checkType == USERIDENTIFY_RESULT_ERR_NETERR) {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:[[LangCaptain getInstance] getResultByCode:[@(USERIDENTIFY_RESULT_ERR_NETERR) stringValue]]];
                return;
            }
            [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                andMessage:[[LangCaptain getInstance] getLangByCode:@"PhonePinErr"]];
            [[DataCenter getInstance] phonePinErr];
        }
    });
}

- (void)doMKTTrade{
    [CertificateUtil resetTimeTickIsEnterBackground:false];
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrument];
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[pss instrumentName]];
    int digist = [inst getDigits];
    
    if (pss == nil) {
        return;
    }
    
    Boolean isBuy = segmentControl.selectIndex == IndexBuy;
    double price = isBuy ? [pss getAsk] : [pss getBid];
    
    double amount = [self getAmount];
    ToOpenTradeNode *node = [[ToOpenTradeNode alloc] init];
    [node setInstrumentName:_instrument];
    [node setAmount:amount];
    [node setBuySell:segmentControl.selectIndex];
    
    IP_TRADESERV5101 * ip = [[TradeApi getInstance] createMktCFDTradeIPAccount:[[ClientAPI getInstance] getAccount]
                                                                instrumentName:_instrument
                                                                  isBuyNotSell:isBuy
                                                                        amount:amount
                                                                         price:price
                                                                   mktPirceGap:0
                                                             toCloseTradeNodes:[[NSArray alloc] init]
                                                               toOpenTradeNode:node
                                                                  IFDStopPrice:0.0f
                                                                 IFDLimitPrice:0.0f];
    if (amountFeild != nil) {
        [amountFeild resignFirstResponder];
    }
    
    NSString *signature = [CertificateUtil getPkcs7sin:ip];
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
        TradeResult_MktCFD *result = [[TradeApi getInstance] doMKTCFDTrade:ip
                                                                 signature:signature];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            if ([result result] == RESULT_SUCCEED) {
                
                OpenPositonResultView *openResult = [OpenPositonResultView newInstance];
                [openResult setFrame:OpenSuccessViewRect];
                
                [openResult.accountLabel setText:[NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
                
                [openResult.instrumentLabel setText:_instrument];
                [openResult.amountLabel setText:[DecimalUtil formatNumber:amount]];
                [openResult.buySellLabel setText:isBuy == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"]];
                
                if ([result orderHis] != nil) {
                    [openResult.priceLabel setText:[DecimalUtil formatMoney:[[result orderHis] getLimitPrice] digist:digist]];
//                    NSDate *openTime = [[result orderHis] getOpenTime];
                    NSDate *openTime = [self getOpenTime:[result orderHis]];
                    [openResult.timeLabel setText:[JEDIDateTime stringUIFromDate:openTime]];
                } else {
                    [openResult.priceLabel setText:[DecimalUtil formatMoney:price digist:digist]];
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[pss snapshotTime] / 1000.0];
                    [openResult.timeLabel setText:[JEDIDateTime stringUIFromDate:date]];
                }
                
                UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
                UIImage *backImage = [ImageUtils imageWithView:rootView];
                backImage = [backImage blurredImageWithRadius:kDefaultRadius iterations:kDefaultIterations tintColor:[UIColor blackColor]];
                _backgroundView.backgroundColor = [UIColor colorWithPatternImage:backImage];
                [_backgroundView addSubview:openResult];
                
                //                [self addSubview:openResult];
                [rootView addSubview:_backgroundView];
                
                [OpenPositionContentView setSelectTicket:[@([self getTicket:[result orderHis]]) stringValue]];
                
                [openResult.confirmButton addTarget:self action:@selector(openPositionSuccess) forControlEvents:UIControlEventTouchUpInside];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_6];
            } else {
                NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]];
                
                //                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"OpenTradeFaild"] andMessage:errMsg];
                
                OpenPositionFailed *failedView = [OpenPositionFailed newInstance];
                
                [failedView.contentView setText:errMsg];
                [failedView setFrame:OpenFailedViewRect];
                
                UIView *rootView = [[[IosLogic getInstance] getWindow] rootViewController].view;
                UIImage *backImage = [ImageUtils imageWithView:rootView];
                backImage = [backImage blurredImageWithRadius:kDefaultRadius iterations:kDefaultIterations tintColor:[UIColor blackColor]];
                _backgroundView.backgroundColor = [UIColor colorWithPatternImage:backImage];
                [_backgroundView addSubview:failedView];
                
                //                [self addSubview:openResult];
                [rootView addSubview:_backgroundView];
                [failedView.confirmButton addTarget:self action:@selector(openPositionFailed) forControlEvents:UIControlEventTouchUpInside];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_7];
            }
        });
    });
}

- (NSDate *)getOpenTime:(TOrderHis *)orderHis {
    if (orderHis == nil) {
        return nil;
    }
    long long ticketId = [self getTicket:orderHis];
    TTrade *trade = [[APIDoc getUserDocCaptain] getTrade:ticketId];
    return trade != nil ? [trade getOpenTime] : nil;
}

- (long long)getTicket:(TOrderHis *)orderHis {
    if (orderHis == nil) {
        return 0;
    }
    NSArray *ticketVec = [[orderHis getopenedTicket] componentsSeparatedByString:@"_"];
    if ([ticketVec count] > 0) {
        return [[ticketVec objectAtIndex:0] longLongValue];
    }
    return 0;
}

- (void)doCancel{
    [amountFeild resignFirstResponder];
    [[IosLogic getInstance] gotoQuoteListViewController];
}

#pragma alertDelegate

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[IosLogic getInstance] gotoOpenPositionViewController];
//    }
//}

- (void)openPositionSuccess {
//        [OpenPositionContentView setSelectInstrument:_instrument];
//    [OpenPositionContentView setSelectTicket:<#(NSString *)#>];
    [[IosLogic getInstance] gotoOpenPositionViewController];
}

- (void)openPositionFailed {
    [_backgroundView removeFromSuperview];
    [[_backgroundView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma keyboardDelegate
- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
    //    double amount = [CommDataUtil numberFromString:string];
    //    amountFeild.text = [DecimalUtil formatNumber:amount];
    //    amountFeild.text = [DecimalUtil formatDoubleByNoStyle:amount digit:0];
    //    amountFeild.text = string;
    [self updateOccupyMargin];
}

- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string{
    //    if ([string isEqualToString:@""] || [string isEqualToString:@"0"]) {
    if (string == nil || [string isEqualToString:@""] ) {
        amountFeild.text = @"";
        
    } else {
        //        double amount = [CommDataUtil numberFromString:string];
        //        amountFeild.text = [DecimalUtil formatDoubleByNoStyle:amount digit:0];
        //        amountFeild.text = [DecimalUtil formatNumber:amount];
        //        amountFeild.text = [@(amount) stringValue];
        //        amountFeild.text = string;
    }
    [self updateOccupyMargin];
}

- (void)keyboardReturn {
    if (amountFeild != nil) {
        [amountFeild resignFirstResponder];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [[phonePinInputView superview] removeFromSuperview];
    //     [self keyboardReturn];
}

- (void)rotate {
    [[phonePinInputView superview] removeFromSuperview];
    [self keyboardReturn];
}

//- (void)dealloc {
//    amountFeild.inputView = nil;
//    self.keyboard.delegate = nil;
//    self.keyboard = nil;
//}

@end
