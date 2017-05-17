//
//  Info_TRADESERV1012.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"

#import "TOrder.h"

@interface Info_TRADESERV1012 : InfoFather

jsonValueInterface(AccountID,       long long)
jsonValueInterface(TradeOperateID,  NSString *)
jsonValueInterface(ToRemoveOrderID, long long)
jsonValueInterface(Order,           TOrder *)

@end
