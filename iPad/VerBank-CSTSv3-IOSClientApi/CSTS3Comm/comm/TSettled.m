//
//  TSettled.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "TSettled.h"
static NSString * jsonId = @"TSettled";

static NSString * ticket = @"1";
static NSString * splitno = @"2";
static NSString * openExecId = @"3";
static NSString * closeExecId = @"4";
static NSString * instrument = @"5";
static NSString * account = @"6";
static NSString * oOrderID = @"7";
static NSString * oOsplitNo = @"8";
static NSString * cOrderId = @"9";
static NSString * cOsplitNo = @"10";
static NSString * buysell = @"11";
static NSString * amount = @"12";
static NSString * openPrice = @"13";
static NSString * openTradeDay = @"14";
static NSString * openTime = @"15";
static NSString * closePrice = @"16";
static NSString * profitLoss = @"17";
static NSString * closeTradeDay = @"18";
static NSString * closeTime = @"19";
static NSString * reason = @"20";
static NSString * balanceCur = @"21";
static NSString * balanceRate = @"22";
static NSString * marginRate = @"23";
static NSString * openGroup = @"24";
static NSString * closeGroup = @"25";
static NSString * valueDay = @"26";
static NSString * openValueDay = @"27";
static NSString * plRate = @"28";
static NSString * oriAmt = @"29";
static NSString * leaveAmt = @"30";
@implementation TSettled
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(Ticket,            ticket)
jsonImplementionInt(Splitno,            splitno)
jsonImplementionLong(OpenExecId,        openExecId)
jsonImplementionLong(CloseExecId ,      closeExecId)
jsonImplementionString(Instrument,      instrument)
jsonImplementionLongLong(Account,           account)
jsonImplementionLongLong(OOrderID,          oOrderID)
jsonImplementionInt(OOsplitNo,          oOsplitNo)
jsonImplementionLongLong(COrderId ,         cOrderId)
jsonImplementionInt(COsplitNo,          cOsplitNo)
jsonImplementionInt(Buysell,            buysell)
jsonImplementionDouble(Amount,          amount)
jsonImplementionDouble(OpenPrice,       openPrice)
jsonImplementionString(OpenTradeDay,    openTradeDay)
jsonImplementionDate(OpenTime,          openTime)
jsonImplementionDouble(ClosePrice,      closePrice)
jsonImplementionDouble(ProfitLoss ,     profitLoss)
jsonImplementionString(CloseTradeDay,   closeTradeDay)
jsonImplementionDate(CloseTime,         closeTime)
jsonImplementionInt(Reason,             reason)
jsonImplementionString(BalanceCur,      balanceCur)
jsonImplementionDouble(BalanceRate ,    balanceRate)
jsonImplementionDouble(MarginRate,      marginRate)
jsonImplementionString(OpenGroup,       openGroup)
jsonImplementionString(CloseGroup,      closeGroup)
jsonImplementionString(ValueDay,        valueDay)
jsonImplementionString(OpenValueDay,    openValueDay)
jsonImplementionDouble(PlRate,          plRate)
jsonImplementionDouble(OriAmt,          oriAmt)
jsonImplementionDouble(LeaveAmt ,       leaveAmt)
@end
