//
//  TOrderHis.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface TOrderHis : AbstractJsonData

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
jsonValueInterface(CorrespondingTicket,long long)
jsonValueInterface(ExpireType, int)
jsonValueInterface(ExpiryTime,NSDate*)
jsonValueInterface(IFDLimitPrice, double)
jsonValueInterface(IFDStopPrice,double)
jsonValueInterface(OpenUserName,NSString*)
jsonValueInterface(OpenUserIPAddress,NSString*)
jsonValueInterface(OpenUserType,int)
jsonValueInterface(OpenGroup,NSString*)


jsonValueInterface(closeGroup, NSString *)
jsonValueInterface(closeType, int)
jsonValueInterface(closeTrade, NSString *)
jsonValueInterface(closeTime, NSDate *)
jsonValueInterface(openedTicket, NSString *)
jsonValueInterface(closedTicket, NSString *)
jsonValueInterface(splitLeftTicket, NSString *)
jsonValueInterface(closeReason, int)
jsonValueInterface(marginPerc4Close, double)
jsonValueInterface(marketprice4Close, double)
jsonValueInterface(closePrice, double)
jsonValueInterface(closeUserName, NSString *)
jsonValueInterface(closeUserIPAddress, NSString *)
jsonValueInterface(closeUserType, int)


jsonValueInterface(Comment, NSString*)
jsonValueInterface(IsManual,int)


@end
