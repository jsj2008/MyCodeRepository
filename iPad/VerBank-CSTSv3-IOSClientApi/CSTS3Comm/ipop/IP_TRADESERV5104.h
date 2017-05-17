//
//  IP_TRADESERV5104.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5104 : IPFather

jsonValueInterface(OrderID, long long)
jsonValueInterface(AccountID, long long)
jsonValueInterface(Amount, double)
jsonValueInterface(StopMoveGap, int)
jsonValueInterface(LimitPrice, double)
jsonValueInterface(OriStopprice, double)
jsonValueInterface(ExpireType, int)
jsonValueInterface(ExpireTime, NSString *)
jsonValueInterface(IFDLimitPrice, double)
jsonValueInterface(IFDStopPrice, double)
jsonValueInterface(AccountDigist, NSString *)
jsonValueInterface(Aeid, NSString *)
jsonValueInterface(IsManual, Boolean)
jsonValueInterface(Comment, NSString *)
- (NSString *)toString;

@end
