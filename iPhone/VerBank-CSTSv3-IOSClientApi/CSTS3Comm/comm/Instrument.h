//
//  Instrument.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface Instrument : AbstractJsonData
jsonValueInterface(Instrument,                  NSString*)
jsonValueInterface(Ccy1,                        NSString*)
jsonValueInterface(Ccy2,                        NSString*)
jsonValueInterface(Digits,                      int)
jsonValueInterface(MinAmount,                   double)
jsonValueInterface(MaxAmount,                   double)
jsonValueInterface(SpreadType,                  int)
jsonValueInterface(Spread,                      double)
jsonValueInterface(Spike,                       int)
jsonValueInterface(SafeGap4OpenOrder,           int)
jsonValueInterface(MoveStopMinGap,              int)
jsonValueInterface(OpenMarginPercentage,        double)
jsonValueInterface(MarginCall1Percentage,       double)
jsonValueInterface(MarginCall2Percentage,       double)
jsonValueInterface(UnLockMarginPercentage,      double)
jsonValueInterface(LiquidationMarginPercentage, double)
jsonValueInterface(Tradeable,                   int)
jsonValueInterface(PriceValidTimeGap,           int)
jsonValueInterface(IsVisable,                   int)
jsonValueInterface(ForeceToUptrade,             int)
jsonValueInterface(ExtraDigit,                  int)
jsonValueInterface(ValueDayDelay,               int)
jsonValueInterface(IsForward,                   int)
jsonValueInterface(ForwardDate,                 NSString*)
jsonValueInterface(DealerOpenMarginPercentage,  double)
jsonValueInterface(OrderTradeFeeRatio,          int)
jsonValueInterface(OrderTradeFeeAdjust,         int)
@end
