//
//  AbstractTradeViewBuilder.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderPositionView;
@class OpenOrderPositionView;
@class PriceWarningView;

@protocol AbstractTradeViewBuilderProtocol <NSObject>

// 掛單 和 價格提示 有連個界面， 而且可以修改商品， 所以 build 抽出來
- (void)buildAddOrderPositionView:(OrderPositionView *)addOrderPositionView;
- (void)buildModifyOrderPositionView:(OrderPositionView *)modifyOrderPositionView;
- (void)updateAddOrderPositionView:(OrderPositionView *)addOrderPositionView;
- (void)updateModifyOrderPositionView:(OrderPositionView *)modifyOrderPositionView;

- (void)updateAddOpenOrderPositionView:(OpenOrderPositionView *)addOpenOrderPositionView;
- (void)updateModifyOpenOrderPositionView:(OpenOrderPositionView *)modifyOpenOrderPositionView;

- (void)buildAddPriceWarningView:(PriceWarningView *)addPriceWarningView;
- (void)buildModifyPriceWarningView:(PriceWarningView *)modifyPriceWarningView;
- (void)updateAddPriceWarningView:(PriceWarningView *)addPriceWarningView;
- (void)updateModifyPriceWarningView:(PriceWarningView *)modifyPriceWarningView;

@end
