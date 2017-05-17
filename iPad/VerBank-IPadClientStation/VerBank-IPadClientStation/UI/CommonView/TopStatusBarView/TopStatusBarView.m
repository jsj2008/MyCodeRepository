//
//  TopStatusBarView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TopStatusBarView.h"
#import "UIColor+CustomColor.h"
#import "QuoteDataStore.h"
#import "APIDoc.h"
#import "DecimalUtil.h"
#import "ClientAPI.h"
#import "LangCaptain.h"
#import "MarginCallDataInitUtil.h"
#import "LayoutCenter.h"

@interface TopStatusBarView()<API_Event_QuoteDataStore> {
    NSString *tradeableMarginString;
    NSString *floatPLString;
    NSString *percentString;
}

@end

@implementation TopStatusBarView

@synthesize leftButton;
@synthesize iconButton;
@synthesize rightButton;
@synthesize marginCallLabel;
@synthesize floatPLLabel;
@synthesize percentLabel;

- (void)initContent {
    [self.leftButton    setImage:[UIImage imageNamed:@"images/normal/more_update"] forState:UIControlStateNormal];
    [self.rightButton   setImage:[UIImage imageNamed:@"images/normal/personal"] forState:UIControlStateNormal];
    [self.iconButton    setImage:[UIImage imageNamed:@"images/logo/topLogo.png"] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor leftTableViewBackgroundColor]];
    [self.marginCallLabel   setTextColor:[UIColor whiteColor]];
    [self.floatPLLabel      setTextColor:[UIColor whiteColor]];
    [self.percentLabel      setTextColor:[UIColor whiteColor]];
    
    tradeableMarginString    = [[LangCaptain getInstance] getLangByCode:@"TradeableMargin"];
    floatPLString       = [[LangCaptain getInstance] getLangByCode:@"FloatPL"];
    percentString       = [[LangCaptain getInstance] getLangByCode:@"CurrentPercent"];
    
    [self addTouchEvent];
    [self addListener];
    [self recQuoteData:nil];
}

#pragma listener

- (void)addTouchEvent {
    [self.leftButton addTarget:self
                        action:@selector(showLeftBarView)
              forControlEvents:UIControlEventTouchUpInside];
    [self.iconButton addTarget:self
                        action:@selector(showLeftBarView)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton addTarget:self
                         action:@selector(showAccountMarginCallStatus)
               forControlEvents:UIControlEventTouchUpInside];
}

- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    CDS_AccountStore *accountStore = [[APIDoc getUserDocCaptain] getCDS_AccountStore:[[ClientAPI getInstance] accountID]];
    NSString *floatPLValue = [NSString stringWithFormat:@"%@    %@", floatPLString, [DecimalUtil formatMoney:[accountStore C_floatPL] digist:2]];
    NSString *currentPercentValue = [NSString stringWithFormat:@"%@    %@", percentString, [[[MarginCallDataInitUtil alloc] init] getEquity2MaginOpen]];
    UIColor *color = nil;
    if ([accountStore C_floatPL] > 0.00001) {
        color = [UIColor blueUpColor];
    } else if([accountStore C_floatPL] < -0.00001){
        color = [UIColor redDownColor];
    } else {
        color = [UIColor whiteColor];
    }
    
    
    NSString *marginValue = nil;
    double margin = [accountStore C_activeCapital4Margin] - [accountStore C_margin_open_4Positions];
    if (margin <= 0.00001) {
        marginValue = [NSString stringWithFormat:@"%@    %@", tradeableMarginString, [DecimalUtil formatMoney:0 digist:2]];
    } else {
        marginValue = [NSString stringWithFormat:@"%@    %@", tradeableMarginString, [DecimalUtil formatMoney:margin digist:2]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.floatPLLabel setTextColor:color];
        [self.floatPLLabel setText:floatPLValue];
        [self.marginCallLabel setText:marginValue];
        [self.percentLabel setText:currentPercentValue];
    });
}

- (void)showLeftBarView {
    [[LayoutCenter getInstance].backgroundLayoutCenter showLeftScrollView];
}

- (void)showAccountMarginCallStatus {
    [[LayoutCenter getInstance].backgroundLayoutCenter showAccountMarginCallStatus];
}

@end
