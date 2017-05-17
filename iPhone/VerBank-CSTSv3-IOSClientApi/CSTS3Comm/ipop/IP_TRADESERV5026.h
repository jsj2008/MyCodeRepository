//
//  IP_TRADESERV5026.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static const int ALL = 0;
static const int AEID = 1;
static const int DEALER = 2;

@interface IP_TRADESERV5026 : IPFather

jsonValueInterface(Aeid,            NSString *)
jsonValueInterface(ConditionType,   int)
jsonValueInterface(DealerName,      NSString *)
jsonValueInterface(CompareWay,      int)
jsonValueInterface(PriceType,       int)
jsonValueInterface(IsPriceReach,    int)
jsonValueInterface(FromTime,        NSDate *)
jsonValueInterface(EndTime,         NSDate *)
jsonValueInterface(IsRead,          int)
jsonValueInterface(IsClientNeed,    Boolean)
jsonValueInterface(Origin,          int)
jsonValueInterface(IsReport,        Boolean)
@end
