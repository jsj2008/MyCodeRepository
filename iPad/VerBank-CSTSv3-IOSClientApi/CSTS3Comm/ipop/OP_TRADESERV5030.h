//
//  OP_TRADESERV5030.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"
#import "SystemConfig.h"

@interface OP_TRADESERV5030 : OPFather

jsonValueInterface(BasicCurrencyArray, NSMutableArray *)
jsonValueInterface(SystemConfig, SystemConfig *)
jsonValueInterface(InstrumentArray, NSMutableArray *)
jsonValueInterface(InterestAddType, NSMutableArray *)

@end
