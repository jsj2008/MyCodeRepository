//
//  ClosePositionContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/2.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TradeContentView.h"
#import "IntervalDefine.h"

@interface ClosePositionTableView : TradeContentView

- (void)initDataWithSecInterval:(SecIntervalType)secIntervalType;
- (double)getFloatPositionSum;

@end
