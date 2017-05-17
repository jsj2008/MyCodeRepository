//
//  OP_TRADESERV5101.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"
#import "TOrderHis.h"

@interface OP_TRADESERV5101 : OPFather

jsonValueInterface(MktPriceChanged, Boolean)
jsonValueInterface(NewMKTPrice, double)
jsonValueInterface(OrderHis, TOrderHis *)

@end
