//
//  OP_TRADESERV5021.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"
#import "InstrumentsAccountCfg.h"

@interface OP_TRADESERV5021 : OPFather

jsonValueInterface(InstrumentsAccountCfgArray, NSMutableArray *)
jsonValueInterface(InstrumentsAccountCfg, InstrumentsAccountCfg *)

@end
