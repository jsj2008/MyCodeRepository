//
//  LeftQuoteView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "LayoutDefine.h"

@class MarketTradeView;
@class OrderPositionView;
@class OpenOrderPositionView;

@interface LeftContentView : ContentView

@property ViewFunction currentViweFunction;

- (void)didClickAtFunction:(ViewFunction)function;
//- (void)doTradeByFubction:(TradeFunction)function;

- (void)didUpdateCurrentViewFunction;

// 为了 输入电话密码验证
- (MarketTradeView *)getMarketTradeView;
- (OrderPositionView *)getAddOrderPositionView;
- (OrderPositionView *)getModifyOrderPositionView;
- (OpenOrderPositionView *)getOpenOrderPositionView;

@end
