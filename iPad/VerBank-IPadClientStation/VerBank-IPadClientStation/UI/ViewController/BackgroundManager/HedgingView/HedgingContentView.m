//
//  HedgingContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "HedgingContentView.h"
#import "LangCaptain.h"
#import "JumpDataCenter.h"
#import "UIColor+CustomColor.h"
#import "UIFormat.h"
#import "TradeActionUtil.h"
#import "ShowAlertManager.h"
#import "CheckUtils.h"
#import "BackgoundContentView.h"

#import "API_IDEventCaptain.h"
#import "APIDoc.h"
#import "DecimalUtil.h"

@implementation HedgingContentView

@synthesize titleLabel;
@synthesize instrumentLabel;
@synthesize leftHedgingSubView;
@synthesize rightHedgingSubView;
@synthesize commitButton;
@synthesize cancelButton;

- (void)initContent {
    
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"Hedging"]];
    [self.titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [self.leftHedgingSubView setHedgingType:HedgingTypeSell];
    [self.rightHedgingSubView setHedgingType:HedgingTypeBuy];
    
    [self.commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"CommfirmAdd"]
                       forState:UIControlStateNormal];
    [self.cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"]
                       forState:UIControlStateNormal];
    [self.commitButton addTarget:self action:@selector(doHedgingTrade) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(doCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.leftHedgingSubView withCorner:10.0f];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.rightHedgingSubView withCorner:10.0f];
}

- (void)resetContentView {
    [self.instrumentLabel setText:[[JumpDataCenter getInstance] hedgingInstrumentName]];
    [self.leftHedgingSubView reloadDataByNotify:false];
    [self.rightHedgingSubView reloadDataByNotify:false];
}

#pragma action
- (void)doHedgingTrade {
    
    double leftSum = [self.leftHedgingSubView getSumAmount];
    double rightSum = [self.rightHedgingSubView getSumAmount];
    if (leftSum < 0.00001 && rightSum < 0.00001) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PleaseSelectHedgingTicket"]
                                                            delegate:nil];
        return;
    }
    
    if (fabs(leftSum - rightSum) > 0.00001 ) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"SellBuyNotSame"]
                                                            delegate:nil];
        return;
    }
    
    if (leftSum < 0.0001 || rightSum < 0.0001) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountNill"]
                                                            delegate:nil];
        return;
    }
    
    if (![CheckUtils isLegalTradeAmount:leftSum] || ![CheckUtils isLegalTradeAmount:rightSum]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountErr"]
                                                            delegate:nil];
        return;
    }
    
    if (![self.leftHedgingSubView isRemainLegal]) {
        NSString *errMessage = [NSString stringWithFormat:@"%@ %@ %@", [[LangCaptain getInstance] getLangByCode:@"LessThanMin"], [[APIDoc getSystemDocCaptain] getSystemBasicCurrency], [DecimalUtil formatMoney:[[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMinAmount] digist:2]];
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:errMessage
                                                            delegate:nil];
        return;
    }
    
    if (![self.rightHedgingSubView isRemainLegal]) {
        NSString *errMessage = [NSString stringWithFormat:@"%@ %@ %@", [[LangCaptain getInstance] getLangByCode:@"LessThanMin"], [[APIDoc getSystemDocCaptain] getSystemBasicCurrency], [DecimalUtil formatMoney:[[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMinAmount] digist:2]];
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:errMessage
                                                            delegate:nil];
        return;
    }
    
    NSArray *sellTradeArray = [self.leftHedgingSubView getTradeArray];
    NSArray *buyTradeArray = [self.rightHedgingSubView getTradeArray];
    
    int checkCode = [CheckUtils isHeadgeTradeAmountValiedBuyTicket:buyTradeArray sellNodes:sellTradeArray];
    if (checkCode != CheckCode_Valid) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[CheckUtils transCheckCode:checkCode]
                                                            delegate:nil];
        return;
    }
    
//    if (![self.leftHedgingSubView checkAmount]) {
//        return;
//    }
//    
//    if (![self.rightHedgingSubView checkAmount]) {
//        return;
//    }
    
    [[TradeActionUtil getInstance] doHedgingTradeInstrument:[[JumpDataCenter getInstance] hedgingInstrumentName]
                                         closeBuyTradeNodes:buyTradeArray
                                        closeSellTradeNodes:sellTradeArray];
}

- (void)doCancelAction {
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

#pragma Listener
- (void)addListener {
    [API_IDEventCaptain addListener:DATA_ON_Trade_Changed observer:self listener:@selector(tradeChange:)];
}

- (void)removeListener {
    [API_IDEventCaptain removeListener:DATA_ON_Trade_Changed observer:self];
}

- (void)tradeChange:(NSNotification *)notify {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self.leftHedgingSubView reloadDataByNotify:true];
        [self.rightHedgingSubView reloadDataByNotify:true];
        [self addListener];
    });
}

@end
