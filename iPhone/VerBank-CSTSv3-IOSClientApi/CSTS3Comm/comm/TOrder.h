//
//  TOrder.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface TOrder : AbstractJsonData

@property Boolean hasBeenFixed;
@property double marginOccupied4OpenTrade;

// 客户端排序
@property NSString *sortTag;

jsonValueInterface(OrderID, long long)
jsonValueInterface(OsplitNo, int)
jsonValueInterface(Account, long long)
jsonValueInterface(Instrument, NSString*)
jsonValueInterface(Buysell, int)
jsonValueInterface(Amount, double)
jsonValueInterface(Type, int)
jsonValueInterface(LimitPrice,double)
jsonValueInterface(OriStopPrice,double)
jsonValueInterface(CurrentStopPrice ,double)
jsonValueInterface(StopMoveGap ,int)
jsonValueInterface(MarketPrice4Open,double)
jsonValueInterface(OpenTradeDay,NSString*)
jsonValueInterface(OpenTime, NSDate*)
jsonValueInterface(IsToOpenNew, int)
jsonValueInterface(ToCloseTickets, NSString*)
jsonValueInterface(MarginPerc4Open, double)
jsonValueInterface(AntiTickets, NSString*)
jsonValueInterface(CorrespondingTicket,long)
jsonValueInterface(ExpireType, int)
jsonValueInterface(ExpiryTime,NSDate*)
jsonValueInterface(IFDLimitPrice, double)
jsonValueInterface(IFDStopPrice,double)
jsonValueInterface(OpenUserName,NSString*)
jsonValueInterface(OpenUserIPAddress,NSString*)
jsonValueInterface(OpenUserType,int)
jsonValueInterface(OpenGroup,NSString*)
jsonValueInterface(IsManual,int)
jsonValueInterface(IsPriceReached,int)
jsonValueInterface(PriceReachTime,NSDate*)
jsonValueInterface(ReachedPrice,double)
jsonValueInterface(PriceReachedWay,int)
jsonValueInterface(Comment, NSString*)

@end
