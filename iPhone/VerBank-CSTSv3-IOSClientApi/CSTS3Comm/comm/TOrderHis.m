//
//  TOrderHis.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TOrderHis.h"

static NSString * jsonId = @"TOrderHis";

static NSString * orderID = @"1";
static NSString * osplitNo = @"2";
static NSString * account = @"3";
static NSString * instrument = @"4";
static NSString * buysell = @"5";
static NSString * amount = @"6";
static NSString * type = @"7";
static NSString * limitPrice = @"8";
static NSString * oriStopPrice = @"9";
static NSString * currentStopPrice = @"10";
static NSString * stopMoveGap = @"11";
static NSString * marketPrice4Open = @"12";
static NSString * openTradeDay = @"13";
static NSString * openTime = @"14";
static NSString * isToOpenNew = @"15";
static NSString * toCloseTickets = @"16";
static NSString * marginPerc4Open = @"17";
static NSString * antiTickets = @"18";
static NSString * correspondingTicket = @"19";
static NSString * expireType = @"20";
static NSString * expiryTime = @"21";
static NSString * iFDLimitPrice = @"22";
static NSString * iFDStopPrice = @"23";
static NSString * openUserName = @"24";
static NSString * openUserIPAddress = @"25";
static NSString * openUserType = @"26";
static NSString * openGroup = @"27";
static NSString * closeGroup = @"28";
static NSString * closeType = @"29";
static NSString * closeTrade = @"30";
static NSString * closeTime = @"31";
static NSString * openedTicket = @"32";
static NSString * closedTicket = @"33";
static NSString * splitLeftTicket = @"34";
static NSString * closeReason = @"35";
static NSString * marginPerc4Close = @"36";
static NSString * marketprice4Close = @"37";
static NSString * closePrice = @"38";
static NSString * closeUserName = @"39";
static NSString * closeUserIPAddress = @"40";
static NSString * closeUserType = @"41";
static NSString * comment = @"42";
static NSString * isManual = @"43";

@implementation TOrderHis
- (id)init{
    if(self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(OrderID,               orderID)
jsonImplementionInt(OsplitNo,               osplitNo)
jsonImplementionLongLong(Account,               account)
jsonImplementionString(Instrument,          instrument)
jsonImplementionInt(Buysell,                buysell)
jsonImplementionDouble(Amount,              amount)
jsonImplementionInt(Type,                   type)
jsonImplementionDouble(LimitPrice,          limitPrice)
jsonImplementionDouble(OriStopPrice,        oriStopPrice)
jsonImplementionDouble(CurrentStopPrice ,   currentStopPrice)
jsonImplementionInt(StopMoveGap ,           stopMoveGap)
jsonImplementionDouble(MarketPrice4Open,    marginPerc4Open)
jsonImplementionString(OpenTradeDay,        openTradeDay)
jsonImplementionDate(OpenTime,              openTime)
jsonImplementionInt(IsToOpenNew,            isToOpenNew)
jsonImplementionString(ToCloseTickets,      toCloseTickets)
jsonImplementionDouble(MarginPerc4Open,     marginPerc4Open)
jsonImplementionString(AntiTickets,         antiTickets)
jsonImplementionLongLong(CorrespondingTicket,correspondingTicket)
jsonImplementionInt(ExpireType,             expireType)
jsonImplementionDate(ExpiryTime,            expiryTime)
jsonImplementionDouble(IFDLimitPrice,       iFDLimitPrice)
jsonImplementionDouble(IFDStopPrice,        iFDStopPrice)
jsonImplementionString(OpenUserName,        openUserName)
jsonImplementionString(OpenUserIPAddress,   openUserIPAddress)
jsonImplementionInt(OpenUserType,           openUserType)
jsonImplementionString(OpenGroup,           openGroup)

jsonImplementionString(closeGroup, closeGroup)
jsonImplementionInt(closeType, closeType)
jsonImplementionString(closeTrade, closeTrade)
jsonImplementionDate(closeTime, closeTime)
jsonImplementionString(openedTicket, openedTicket)
jsonImplementionString(closedTicket, closedTicket)
jsonImplementionString(splitLeftTicket, splitLeftTicket)
jsonImplementionInt(closeReason, closeReason)
jsonImplementionDouble(marginPerc4Close, marginPerc4Close)
jsonImplementionDouble(marketprice4Close, marketprice4Close)
jsonImplementionDouble(closePrice, closePrice)
jsonImplementionString(closeUserName, closeUserName)
jsonImplementionString(closeUserIPAddress, closeUserIPAddress)
jsonImplementionInt(closeUserType, closeUserType)

jsonImplementionInt(IsManual,               isManual)
jsonImplementionString(Comment,             comment)

@end
