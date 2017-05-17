//
//  FloatPLStatus.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/22.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "FloatPLStatus.h"
#import "UIColor+CustomColor.h"
#import "API_IDEventCaptain.h"
#import "APIDoc.h"
#import "ClientAPI.h"
#import "DecimalUtil.h"
#import "LangCaptain.h"
#import "QuoteDataStore.h"
#import "CustomFont.h"

@interface FloatPLStatus()<API_Event_QuoteDataStore>{
    UILabel *_tradeableMarginNameLabel;
    UILabel *_tradeableMarginValueLabel;
    UILabel *_floatPLNameLabel;
    UILabel *_floatPLValueLabel;
}

@end

@implementation FloatPLStatus

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initComponent];
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    _tradeableMarginNameLabel = [[UILabel alloc] init];
    _tradeableMarginValueLabel = [[UILabel alloc] init];
    _floatPLNameLabel = [[UILabel alloc] init];
    _floatPLValueLabel = [[UILabel alloc] init];
    
    _tradeableMarginNameLabel.textAlignment = NSTextAlignmentRight;
    _tradeableMarginValueLabel.textAlignment = NSTextAlignmentLeft;
    _floatPLNameLabel.textAlignment = NSTextAlignmentRight;
    _floatPLValueLabel.textAlignment = NSTextAlignmentLeft;
    
    [_tradeableMarginNameLabel setTextColor:[UIColor whiteColor]];
    [_tradeableMarginValueLabel setTextColor:[UIColor whiteColor]];
    [_floatPLNameLabel setTextColor:[UIColor whiteColor]];
    [_floatPLValueLabel setTextColor:[UIColor whiteColor]];
    
    [self setBackgroundColor:[UIColor floatPLStatusBarColor]];
    [self addSubview:_tradeableMarginValueLabel];
    [self addSubview:_tradeableMarginNameLabel];
    [self addSubview:_floatPLValueLabel];
    [self addSubview:_floatPLNameLabel];
    
    [_floatPLNameLabel setText:[NSString stringWithFormat:[[LangCaptain getInstance] getLangByCode:@"FloatPL"], @"%@:"]];
    [_tradeableMarginNameLabel setText:[NSString stringWithFormat:[[LangCaptain getInstance] getLangByCode:@"TradeableMargin"], @"%@:"]];
    
//    [_floatPLNameLabel setFont:[UIFont systemFontOfSize:12.0f]];
//    [_floatPLValueLabel setFont:[UIFont systemFontOfSize:12.0f]];
//    [_tradeableMarginNameLabel setFont:[UIFont systemFontOfSize:12.0f]];
//    [_tradeableMarginValueLabel setFont:[UIFont systemFontOfSize:12.0f]];

    [_floatPLNameLabel setFont:[CustomFont getCNNormalWithSize:11.0f]];
    [_floatPLValueLabel setFont:[CustomFont getENNormalWithSize:11.0f]];
    [_tradeableMarginNameLabel setFont:[CustomFont getCNNormalWithSize:11.0f]];
    [_tradeableMarginValueLabel setFont:[CustomFont getENNormalWithSize:11.0f]];
    
    [self addListener];
    [self recQuoteData:nil];
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width * 0.9;
    CGRect tradeableMarginNameRect  = CGRectMake(width * 0.05,  0,  width / 4,      self.frame.size.height);
    CGRect tradeableMarginValueRect = CGRectMake(width * 0.30,  0,  width / 10 *3,  self.frame.size.height);
    CGRect floatPLNameRect          = CGRectMake(width * 0.55,  0,  width / 5,      self.frame.size.height);
    CGRect floatPLValueRect         = CGRectMake(width * 0.8,   0,  width / 4,      self.frame.size.height);
    [_tradeableMarginNameLabel setFrame:tradeableMarginNameRect];
    [_tradeableMarginValueLabel setFrame:tradeableMarginValueRect];
    [_floatPLNameLabel setFrame:floatPLNameRect];
    [_floatPLValueLabel setFrame:floatPLValueRect];
    
    [_tradeableMarginNameLabel setTextAlignment:NSTextAlignmentLeft];
    [_floatPLValueLabel setTextAlignment:NSTextAlignmentRight];
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot{
    CDS_AccountStore *accountStore = [[APIDoc getUserDocCaptain] getCDS_AccountStore:[[ClientAPI getInstance] getAccount]];
    NSString *floatPLValue = [DecimalUtil formatMoney:[accountStore C_floatPL] digist:2];
    
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
        marginValue = [DecimalUtil formatMoney:0 digist:2];
    } else {
        marginValue = [DecimalUtil formatMoney:margin digist:2];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_floatPLValueLabel setTextColor:color];
        [_tradeableMarginValueLabel setText:marginValue];
        [_floatPLValueLabel setText:floatPLValue];
    });
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self removeListener];
}

- (void)addListener{
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener{
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)dealloc{
    
}

@end
