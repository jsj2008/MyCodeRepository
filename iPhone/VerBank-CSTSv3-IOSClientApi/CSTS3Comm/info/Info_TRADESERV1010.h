//
//  Info_TRADESERV1010.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"
#import "MoneyAccount.h"
#import "TOrderHis.h"

@interface Info_TRADESERV1010 : InfoFather

jsonValueInterface(AccountID,       long long)
jsonValueInterface(TradeOperatorID, NSString *)
jsonValueInterface(MoneyAccount,    MoneyAccount *)
jsonValueInterface(TradeVec,        NSArray *)
jsonValueInterface(OrderVec,        NSArray *)
jsonValueInterface(OrderHis,        TOrderHis *)
jsonValueInterface(Description,     NSString *)
jsonValueInterface(LastTradeTime,   long long)
jsonValueInterface(TsettledVec,     NSArray *)

@end
