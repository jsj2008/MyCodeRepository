//
//  SystemConfig.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface SystemConfig : AbstractJsonData
jsonValueInterface(CloseStatus, int)
jsonValueInterface(CloseTimeInMil, int)
jsonValueInterface(OpenTimeInMil, int)
jsonValueInterface(AutoClose, int)
jsonValueInterface(BatchCurrency,NSString*)
jsonValueInterface(TradeDay, NSString*)
jsonValueInterface(IsTradeable, int)
jsonValueInterface(HedgedMarginScale,double)
jsonValueInterface(MarginType, int)
jsonValueInterface(NycCloseTimeInMil, int)
jsonValueInterface(WebTradeMinAmount,double)
jsonValueInterface(WebTradeMaxAmount,double)
jsonValueInterface(PhoneOrderMinAmount ,double)
jsonValueInterface(PhoneOrderMaxAmount ,double)
jsonValueInterface(DealerMarginPerc ,double)
@end
