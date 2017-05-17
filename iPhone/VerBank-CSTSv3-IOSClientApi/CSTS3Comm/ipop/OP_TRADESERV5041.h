//
//  OP_TRADESERV5041.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"
#import "MoneyAccount.h"

@interface OP_TRADESERV5041 : OPFather

jsonValueInterface(MoneyAccount, MoneyAccount *)
jsonValueInterface(TradeArray, NSMutableArray *)
jsonValueInterface(OrderArray, NSMutableArray *)
jsonValueInterface(Margin2Array, NSMutableArray *)
jsonValueInterface(MoneyAccountFrozenArray, NSMutableArray *)

@end
