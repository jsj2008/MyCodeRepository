//
//  TTrade.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface TTrade : AbstractJsonData

@property Boolean       hasBeenFixed;
@property double        marketPrice;
@property double        floatPLInCCY2;
@property double        plRate;
@property double        floatPL;
@property double        marginOccupied4OpenTrade;
@property double        marginOccupied4MarginCall1;
@property double        marginOccupied4MarginCall2;
@property double        marginOccupied4Liquidation;
@property double        marginOccupied4UnLock;
@property NSString*     note;

// 客户端排序用
@property NSString *    sortTag;

jsonValueInterface(Ticket,long long)
jsonValueInterface(Splitno,int)
jsonValueInterface(ExecId,long)
jsonValueInterface(Instrument,NSString*)
jsonValueInterface(Account,long long)
jsonValueInterface(Orderid,long long)
jsonValueInterface(Osplitno,int)
jsonValueInterface(Buysell,int)
jsonValueInterface(Amount,double)
jsonValueInterface(Openprice ,double)
jsonValueInterface(OpenTradeDay ,NSString*)
jsonValueInterface(OpenTime,NSDate*)
jsonValueInterface(CorOrderID,long long)
jsonValueInterface(MarginRate ,double)
jsonValueInterface(OpenGroup,NSString*)
jsonValueInterface(OpenValueDay,NSString*)
jsonValueInterface(OriAmt ,double)

@end
