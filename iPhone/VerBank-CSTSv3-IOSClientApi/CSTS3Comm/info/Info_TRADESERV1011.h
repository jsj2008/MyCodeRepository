//
//  Info_TRADESERV1011.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"

#import "MoneyAccount.h"

@interface Info_TRADESERV1011 : InfoFather

jsonValueInterface(AccountID,       long long)
jsonValueInterface(MoneyAccount,    MoneyAccount *)
jsonValueInterface(TradeVec,        NSArray *)
jsonValueInterface(OrderVec,        NSArray *)
jsonValueInterface(TsettledVec,     NSArray *)

@end
