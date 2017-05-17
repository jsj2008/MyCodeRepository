//
//  TOrder.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "TOrder.h"
static NSString * jsonId = @"TOrder";

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
static NSString * isManual = @"28";
static NSString * isPriceReached = @"29";
static NSString * priceReachTime = @"30";
static NSString * reachedPrice = @"31";
static NSString * priceReachedWay = @"32";
static NSString * comment = @"33";

@implementation TOrder

@synthesize hasBeenFixed;
@synthesize marginOccupied4OpenTrade;

@synthesize sortTag;

- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
        hasBeenFixed = false;
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
jsonImplementionLong(CorrespondingTicket,   correspondingTicket)
jsonImplementionInt(ExpireType,             expireType)
jsonImplementionDate(ExpiryTime,            expiryTime)
jsonImplementionDouble(IFDLimitPrice,       iFDLimitPrice)
jsonImplementionDouble(IFDStopPrice,        iFDStopPrice)
jsonImplementionString(OpenUserName,        openUserName)
jsonImplementionString(OpenUserIPAddress,   openUserIPAddress)
jsonImplementionInt(OpenUserType,           openUserType)
jsonImplementionString(OpenGroup,           openGroup)
jsonImplementionInt(IsManual,               isManual)
jsonImplementionInt(IsPriceReached,         isPriceReached)
jsonImplementionDate(PriceReachTime,        priceReachTime)
jsonImplementionDouble(ReachedPrice,        reachedPrice)
jsonImplementionInt(PriceReachedWay,        priceReachedWay)
jsonImplementionString(Comment,             comment)
@end
