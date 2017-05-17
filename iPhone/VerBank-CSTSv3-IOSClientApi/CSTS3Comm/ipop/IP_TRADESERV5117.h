//
//  IP_TRADESERV5117.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5117 : IPFather

jsonValueInterface(Account, long long)
jsonValueInterface(Level, int)
jsonValueInterface(TradeDay, NSString *)
jsonValueInterface(SubLevel, int)

@end
