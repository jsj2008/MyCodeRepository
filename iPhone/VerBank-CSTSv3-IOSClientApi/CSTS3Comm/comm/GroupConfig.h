//
//  GroupConfig.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface GroupConfig : AbstractJsonData
jsonValueInterface(GroupName,       NSString*)
jsonValueInterface(IsTradeable,     int)
jsonValueInterface(Description,     NSString*)
jsonValueInterface(InterestAddType, NSString*)
jsonValueInterface(ForceToUptrade,  int)
jsonValueInterface(OrderTradeFee,   int)
@end
