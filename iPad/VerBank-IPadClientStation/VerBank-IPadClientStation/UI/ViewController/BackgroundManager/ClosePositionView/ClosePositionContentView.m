//
//  ClosePositionContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/31.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ClosePositionContentView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "JumpDataCenter.h"
#import "DecimalUtil.h"
#import "MTP4CommDataInterface.h"
#import "QuoteDataStore.h"
#import "APIDoc.h"
#import "TradeActionUtil.h"
#import "ToCloseTradeNode.h"
#import "BackgoundContentView.h"

@interface ClosePositionContentView()<API_Event_QuoteDataStore> {
    NSString *_instrumentName;
    int _digist;
    int _buySell;
}

@end

@implementation ClosePositionContentView

@synthesize titleLabel;
@synthesize instrumentLabel;
@synthesize amountLabel;
@synthesize buySellLabel;
@synthesize priceLabel;

@synthesize commitButton;
@synthesize cancelButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ConfirmClosePosition"] forState:UIControlStateNormal];
    [self.cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"ClosePositionTrade"]];
    [self.titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [self.commitButton addTarget:self
                          action:@selector(doCloseTrade)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelButton addTarget:self
                          action:@selector(doCancelAction)
                forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetContentView {
    TTrade *trade = [[JumpDataCenter getInstance] closePositionTrade];
    _instrumentName = [trade getInstrument];
    _buySell = [trade getBuysell];
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:[trade getInstrument]];
    _digist  = [[[APIDoc getSystemDocCaptain] getInstrument:[trade getInstrument]] getDigits];
    
    [self.instrumentLabel setText:[trade getInstrument]];
    [self.amountLabel setText:[DecimalUtil formatNumber:[trade getAmount]]];
    NSString *buySell = [trade getBuysell] == BUY ? [[LangCaptain getInstance] getLangByCode:@"Sell"] : [[LangCaptain getInstance] getLangByCode:@"Buy"];
    [self.buySellLabel setText:buySell];
    
    
    NSString *mktPrice = [trade getBuysell] == BUY ? [DecimalUtil formatMoney:[pss getBid] digist:_digist] : [DecimalUtil formatMoney:[pss getAsk] digist:_digist];
    [self.priceLabel setText:mktPrice];
}

#pragma Listener
- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_instrumentName isEqualToString:[snapshot instrumentName]]) {
            NSString *mktPrice = _buySell == BUY ? [DecimalUtil formatMoney:[snapshot getBid] digist:_digist] : [DecimalUtil formatMoney:[snapshot getAsk] digist:_digist];
            self.priceLabel.text = mktPrice;
        }
    });
}

- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

#pragma action
- (void)doCloseTrade {
    TTrade *closeTrade = [[JumpDataCenter getInstance] closePositionTrade];
    Boolean isBuySell = ([closeTrade getBuysell] == BUY);
    
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrumentName];
    double price = isBuySell ? [pss getAsk] : [pss getBid];
    
    ToCloseTradeNode *node = [[ToCloseTradeNode alloc] init];
    [node setAmount:[closeTrade getAmount]];
    [node setSplitno:[closeTrade getSplitno]];
    [node setTicket:[closeTrade getTicket]];
    
    [[TradeActionUtil getInstance] doClosePositionInstrument:_instrumentName
                                                isBuyNotSell:isBuySell
                                                      amount:[closeTrade getAmount]
                                                       price:price
                                             closeTradeNodes:[[NSArray alloc] initWithObjects:node, nil]];
}

- (void)doCancelAction {
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

@end
