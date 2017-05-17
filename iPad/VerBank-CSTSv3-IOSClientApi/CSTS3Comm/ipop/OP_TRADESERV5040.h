//
//  OP_TRADESERV5040.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"
#import "UserLogin.h"

@interface OP_TRADESERV5040 : OPFather

jsonValueInterface(GroupConfigArray, NSMutableArray *)
jsonValueInterface(UserLogin, UserLogin *)
jsonValueInterface(AccountStrategyArray, NSMutableArray *)
jsonValueInterface(InstrumentGroupCfgArray, NSMutableArray *)
jsonValueInterface(InstrumentAccountCfgArray, NSMutableArray *)

@end
