//
//  TTrade.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "TTrade.h"
static NSString * jsonId = @"TTrade";

static NSString * ticket = @"1";
static NSString * splitno = @"2";
static NSString * execId = @"3";
static NSString * instrument = @"4";
static NSString * account = @"5";
static NSString * orderid = @"6";
static NSString * osplitno = @"7";
static NSString * Buysell = @"8";
static NSString * amount = @"9";
static NSString * openprice = @"10";
static NSString * openTradeDay = @"11";
static NSString * openTime = @"12";
static NSString * CorOrderID = @"13";
static NSString * marginRate = @"14";
static NSString * openGroup = @"15";
static NSString * openValueDay = @"16";
static NSString * oriAmt = @"17";

@implementation TTrade

@synthesize         hasBeenFixed;
@synthesize         marketPrice;
@synthesize         floatPLInCCY2;
@synthesize         plRate;
@synthesize         floatPL;
@synthesize         marginOccupied4OpenTrade;
@synthesize         marginOccupied4MarginCall1;
@synthesize         marginOccupied4MarginCall2;
@synthesize         marginOccupied4Liquidation;
@synthesize         marginOccupied4UnLock;
@synthesize         note;
@synthesize         closeAmount;

@synthesize         sortTag;
@synthesize         isSelected;

- (id)init{
    self = [super init];
    if(self != nil){
        [super setEntry:@"jsonId" entry:jsonId];
        hasBeenFixed = false;
    }
    return self;
}

jsonImplementionLongLong(Ticket,        ticket)
jsonImplementionInt(Splitno,        splitno)
jsonImplementionLong(ExecId,        execId)
jsonImplementionString(Instrument,  instrument)
jsonImplementionLongLong(Account,       account)
jsonImplementionLongLong(Orderid,       orderid)
jsonImplementionInt(Osplitno,       osplitno)
jsonImplementionInt(Buysell,        Buysell)
jsonImplementionDouble(Amount,      amount)
jsonImplementionDouble(Openprice ,  openprice)
jsonImplementionString(OpenTradeDay,openTradeDay)
jsonImplementionDate(OpenTime,      openTime)
jsonImplementionLongLong(CorOrderID,    CorOrderID)
jsonImplementionDouble(MarginRate , marginRate)
jsonImplementionString(OpenGroup,   openGroup)
jsonImplementionString(OpenValueDay,openValueDay)
jsonImplementionDouble(OriAmt ,     oriAmt)
@end
