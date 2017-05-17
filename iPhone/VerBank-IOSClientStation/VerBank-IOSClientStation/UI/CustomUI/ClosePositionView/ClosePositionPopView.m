//
//  ClosePositionView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ClosePositionPopView.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "QuoteDataStore.h"
#import "DecimalUtil.h"

@interface ClosePositionPopView()<API_Event_QuoteDataStore> {
    NSString *_instrument;
    int _digist;
    Boolean _buySell;
}
@end

@implementation ClosePositionPopView

@synthesize titleLabel = _titleLabel;
@synthesize instrumentLabel = _instrumentLabel;
@synthesize amountLabel = _amountLabel;
@synthesize buySellLabel = _buySellLabel;
@synthesize priceLabel = _priceLabel;

@synthesize commitButton = _commitButton;
@synthesize cancelButton = _cancelButton;

+ (ClosePositionPopView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ClosePositionPopView" owner:self options:nil];
    ClosePositionPopView *popView = [nib objectAtIndex:0];
    [popView initContent];
    [popView addListener];
    return popView;
}

- (void)setInstrument:(NSString *)instrument {
    _instrument = instrument;
}
- (void)setDigist:(int)digist {
    _digist = digist;
}
- (void)setBuySell:(Boolean)buySell {
    _buySell = buySell;
}

- (void)initContent {
    [_commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ConfirmClosePosition"] forState:UIControlStateNormal];
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"ClosePositionTrade"]];
    [_titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
}

- (void)addListener {
    [QuoteDataStore addQuoteReceiver:self];
}

- (void)removeListener {
    [QuoteDataStore removeQuoteReceiver:self];
}

- (void)layoutSubviews {
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_commitButton];
    [UIFormat setComplexBlueButtonColor:_commitButton];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_cancelButton];
    [UIFormat setComplexGrayButtonColor:_cancelButton];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self withCorner:10.0f];
    
    [_commitButton layoutIfNeeded];
    [_cancelButton layoutIfNeeded];
    
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_instrument isEqualToString:[snapshot instrumentName]]) {
            NSString *mktPrice = _buySell ? [DecimalUtil formatMoney:[snapshot getBid] digist:_digist] : [DecimalUtil formatMoney:[snapshot getAsk] digist:_digist];
            _priceLabel.text = mktPrice;
        }
    });
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self removeListener];
}

@end
