//
//  RightChartView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "RightContentView.h"
#import "LayoutCenter.h"
#import "QuoteChartLayoutCenter.h"
#import "JumpDataCenter.h"

@interface RightContentView() {
    UIView *_contentView;
}

@end

@implementation RightContentView

- (id)init {
    if (self = [super init]) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView {
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_contentView setFrame:self.bounds];
    for (UIView *view in [_contentView subviews]) {
        [view setNeedsLayout];
        [view layoutIfNeeded];
    }
}

- (void)addKChartViews {
    for (UIView *view in [[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray]) {
        [_contentView addSubview:view];
    }
    QuoteChartLayoutCenter *quoteChartLayoutCenter = [[LayoutCenter getInstance] quoteChartLayoutCenter];
    [quoteChartLayoutCenter setKChartSuperView:_contentView];
    [quoteChartLayoutCenter updateContraints:-1];
}

- (void)showTradeChratWebViewStatus:(Boolean)isShow {
    NSArray *chartViewArray = [[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray];
    if (chartViewArray != nil && [chartViewArray count] != 0) {
        //        for (int i = 3; i>= 0; i--) {
        int index = [[JumpDataCenter getInstance] tradeShowIndex];
        [[[[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray] objectAtIndex:index] doTradeViewStatus:isShow];
//        [[JumpDataCenter getInstance] setTradeShowIndex:0];
        //        }
        if (!isShow) {
            [[JumpDataCenter getInstance] setTradeShowIndex:0];
        }
    }
}

- (void)reloadQuoteDataWithInstrument:(NSString *)instrumentName {
    NSArray *chartViewArray = [[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray];
    if (chartViewArray != nil && [chartViewArray count] != 0) {
        [[[[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray] objectAtIndex:0] setInstrumentName:instrumentName];
        [[[[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray] objectAtIndex:0] loadQuoteHisData];
    }
}

- (void)saveCurrentData {
    NSArray *chartViewArray = [[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray];
    if (chartViewArray != nil && [chartViewArray count] != 0) {
        [[[[[LayoutCenter getInstance] quoteChartLayoutCenter] kChartViewArray] objectAtIndex:0] saveToJsonString];
    }
}

- (void)dealloc {
    
}

@end
