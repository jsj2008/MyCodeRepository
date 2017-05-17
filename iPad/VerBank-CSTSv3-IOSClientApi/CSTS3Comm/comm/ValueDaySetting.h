//
//  ValueDaySetting.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface ValueDaySetting : AbstractJsonData
jsonValueInterface(TradeDay,NSString*)
jsonValueInterface(Instrument,NSString*)
jsonValueInterface(ValueDay,NSString*)
jsonValueInterface(Description,NSString*)
@end
