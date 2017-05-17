//
//  OpenOrderOCOPageView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenOrderLimitView.h"
#import "OpenOrderOCOView.h"
#import "OpenOrderStopView.h"
#import "CustomSegmentControl.h"
#import "TOrder.h"
#import "TypeDefine.h"

@interface OpenOrderOCOPageView : UIScrollView

@property OpenOrderLimitView *limitView;
@property OpenOrderOCOView   *ocoView;
@property OpenOrderStopView  *stopView;

#pragma getValues
- (double)getAmountByType:(SegmentTradeType)type;
- (double)getLimitValueByTradeType:(SegmentTradeType)type;
- (double)getStopValueByTradeType:(SegmentTradeType)type;
- (NSUInteger)getStopMoveValueByType:(SegmentTradeType)type;

- (NSUInteger)getExpireType:(SegmentTradeType)type;
- (NSString *)getExpireTime:(SegmentTradeType)type;

- (void)resetInputValue;

- (void)setIndex:(NSUInteger)index;

#pragma initValue
- (void)initOrder:(TOrder *)order byType:(OCOPageIndex)type;
- (void)initStopMoveGap:(NSString *)instrumentName;
- (void)initAddOrModify:(AddOrModifyType)type orderPositionView:(id)orderPositionView;

@end
