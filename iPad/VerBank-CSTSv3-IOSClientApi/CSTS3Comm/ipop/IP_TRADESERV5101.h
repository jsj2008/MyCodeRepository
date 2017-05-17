//
//  IP_TRADESERV5101.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5101 : IPFather

jsonValueInterface(Aeid, NSString *)
jsonValueInterface(AccountID, long long)
jsonValueInterface(InstrumentName, NSString *)
jsonValueInterface(BuySell, int)
jsonValueInterface(Amount, double)
jsonValueInterface(Price, double)
jsonValueInterface(MktPriceGap, int)

jsonValueInterface(IsToOpenNew, Boolean)
jsonValueInterface(OrderType, int)
jsonValueInterface(AccountDigist, NSString *)
jsonValueInterface(CloseTradeVec, NSArray *)
jsonValueInterface(OpenTrade, NSObject *)
jsonValueInterface(OrderID, long long)

- (NSString *)toString;

@end
