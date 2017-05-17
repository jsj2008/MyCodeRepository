//
//  MoneyAccountStream.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/12.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface MoneyAccountStream : AbstractJsonData

jsonValueInterface(StreamID,    long long)
jsonValueInterface(Guid,        long long)
jsonValueInterface(Account,     long long)
jsonValueInterface(Instrument,  NSString *)
jsonValueInterface(Ticket,      long long)
jsonValueInterface(Splitno,     int)
jsonValueInterface(CurrencyName,NSString *)
jsonValueInterface(Type,        int)
jsonValueInterface(Amount,      double)
jsonValueInterface(Ttype,       int)
jsonValueInterface(TradeDay,    NSString *)
jsonValueInterface(StreamTime,  NSDate *)
jsonValueInterface(Comments,    NSString *)
jsonValueInterface(Username,    NSString *)
jsonValueInterface(UserType,    int)
jsonValueInterface(IPAdress,    NSString *)
jsonValueInterface(ValueDay,    NSString *)
jsonValueInterface(ValueTime,   NSDate *)
jsonValueInterface(AdjustType,  int)
jsonValueInterface(CustCmmt,    NSString *)
jsonValueInterface(InternCmmt,  NSString *)


@end
