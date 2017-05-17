//
//  OP_TRADESERV5020.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"
#import "InstrumentsGroupCfg.h"

@interface OP_TRADESERV5020 : OPFather

jsonValueInterface(InstrumentGroupCfgArray, NSMutableArray *)
jsonValueInterface(InstrumentGroupCfg, InstrumentsGroupCfg *)

@end
