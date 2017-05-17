//
//  BalanceRate.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface BalanceRate : AbstractJsonData

jsonValueInterface(Instrument,   NSString*)
jsonValueInterface(TradeDay,    NSString*)
jsonValueInterface(Cur1,        NSString*)
jsonValueInterface(Cur2,        NSString*)
jsonValueInterface(Bid,         double)
jsonValueInterface(Ask,         double)

@end
