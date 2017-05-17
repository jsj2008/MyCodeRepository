//
//  RightChartView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "KChartWebView.h"

@interface RightContentView : ContentView

@property NSMutableArray *subViewArray;

- (void)addKChartViews;

// 防止交易界面的 时候， 直接登出。 需要保存。
- (void)saveCurrentData;

- (void)showTradeChratWebViewStatus:(Boolean)isShow;
- (void)reloadQuoteDataWithInstrument:(NSString *)instrumentName;

@end
