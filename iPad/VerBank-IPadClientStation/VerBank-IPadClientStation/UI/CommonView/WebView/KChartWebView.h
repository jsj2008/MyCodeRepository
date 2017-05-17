//
//  KChartWebView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/7.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteChartManager.h"

@interface KChartWebView : UIView

- (id)initWithName:(ViewName)kChartName;

@property UIWebView *webView;

- (void)setInstrumentName:(NSString *)instrumentName;
- (NSString *)getInstrumentName;

- (void)loadQuoteHisData;

- (void)doTradeViewStatus:(Boolean)isShow;
- (void)saveToJsonString;

- (void)drawOrderLine;

- (void)maxMinClick:(id)sender;

@end
