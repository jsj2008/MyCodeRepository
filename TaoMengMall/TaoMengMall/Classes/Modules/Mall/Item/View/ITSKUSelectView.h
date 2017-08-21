//
//  skuSelectView.h
//  HongBao
//
//  Created by Ivan on 16/2/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ITSkuInfoModel.h"

extern NSString * const kNOTIFY_SKU_PANEL_SELECT_CHANGED;

@protocol ITSKUSelectDelegate <NSObject>

@optional
- (void) addWithSkuId:(NSString *)skuId amount:(NSInteger)amount type:(NSString *)type;
- (void) addWithSkuInfo:(ITStockInfoModel *)skuInfo amount:(NSInteger)amount type:(NSString *)type;
- (void) willHideSKUSelectView;
@end

@interface ITSKUSelectView : UIView

@property (nonatomic, weak) id<ITSKUSelectDelegate> delegate;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, strong) NSArray *selectedProperties;

- (ITSKUSelectView *) initWithSkuInfo: (ITSkuInfoModel *)skuInfo itemTitle: (NSString *)itemTitle;

- (void) show;

- (void) dismiss;

@end
