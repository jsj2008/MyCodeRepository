//
//  IP_TRADESERV5103.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5103 : IPFather

jsonValueInterface(Aeid, NSString *)
jsonValueInterface(AccountID, long long)
jsonValueInterface(Instrument, NSString *)

jsonValueInterface(BuySell, int)
jsonValueInterface(Amount, double)
jsonValueInterface(Type, int)
jsonValueInterface(LimitPrice, double)
jsonValueInterface(OriStopprice, double)
jsonValueInterface(StopMoveGap, int)
jsonValueInterface(ToOpenNew, Boolean)
jsonValueInterface(ToCloseTickets, NSString *)
jsonValueInterface(ExpireType, int)
jsonValueInterface(ExpireTime, NSString *)

jsonValueInterface(IFDLimitPrice, double)
jsonValueInterface(IFDStopPrice, double)
jsonValueInterface(AccountDigist, NSString *)

jsonValueInterface(IsManual, Boolean)
jsonValueInterface(Comment, NSString *)

- (NSString *)toString;

@end
