//
//  TSettled.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface TSettled : AbstractJsonData
jsonValueInterface(Ticket,long long)
jsonValueInterface(Splitno,int)
jsonValueInterface(OpenExecId,long)
jsonValueInterface(CloseExecId ,long)
jsonValueInterface(Instrument,NSString*)
jsonValueInterface(Account,long long)
jsonValueInterface(OOrderID,long long)
jsonValueInterface(OOsplitNo,int)
jsonValueInterface(COrderId ,long long)
jsonValueInterface(COsplitNo,int)
jsonValueInterface(Buysell,int)
jsonValueInterface(Amount,double)
jsonValueInterface(OpenPrice,double)
jsonValueInterface(OpenTradeDay,NSString*)
jsonValueInterface(OpenTime,NSDate*)
jsonValueInterface(ClosePrice,double)
jsonValueInterface(ProfitLoss ,double)
jsonValueInterface(CloseTradeDay,NSString*)
jsonValueInterface(CloseTime,NSDate*)
jsonValueInterface(Reason,int)
jsonValueInterface(BalanceCur,NSString*)
jsonValueInterface(BalanceRate ,double)
jsonValueInterface(MarginRate,double)
jsonValueInterface(OpenGroup,NSString*)
jsonValueInterface(CloseGroup,NSString*)
jsonValueInterface(ValueDay,NSString*)
jsonValueInterface(OpenValueDay,NSString*)
jsonValueInterface(PlRate,double)
jsonValueInterface(OriAmt,double)
jsonValueInterface(LeaveAmt ,double)
@end
