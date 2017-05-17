//
//  OCOPageView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderLimitView.h"
#import "OrderOCOView.h"
#import "OrderStopView.h"
#import "CustomSegmentControl.h"
#import "TOrder.h"
#import "TypeDefine.h"

@interface OrderOCOPageView : UIScrollView

@property OrderLimitView *limitView;
@property OrderOCOView   *ocoView;
@property OrderStopView  *stopView;

#pragma getValues
- (double)getAmountByType:(SegmentTradeType)type;
- (double)getLimitValueByTradeType:(SegmentTradeType)type;
- (double)getStopValueByTradeType:(SegmentTradeType)type;
- (double)getIDTLimitValueByTradeType:(SegmentTradeType)type;
- (double)getIDTStopValueByTradeType:(SegmentTradeType)type;

- (NSUInteger)getExpireType:(SegmentTradeType)type;
- (NSString *)getExpireTime:(SegmentTradeType)type;

- (void)resetInputValue;

- (void)setIndex:(NSUInteger)index;

#pragma initValue
- (void)initOrder:(TOrder *)order byType:(OCOPageIndex)type;

- (void)initAddOrModify:(AddOrModifyType)type orderPositionView:(id)orderPositionView;

@end
