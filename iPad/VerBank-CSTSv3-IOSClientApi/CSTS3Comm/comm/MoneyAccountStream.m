//
//  MoneyAccountStream.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/12.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MoneyAccountStream.h"

static NSString * jsonId = @"AccountStreamDetails";

static NSString * streamID      = @"1";
static NSString * guid          = @"2";
static NSString * account       = @"3";
static NSString * instrument    = @"4";
static NSString * ticket        = @"5";
static NSString * splitno       = @"6";
static NSString * currencyName  = @"7";
static NSString * type          = @"8";
static NSString * amount        = @"9";
static NSString * ttype         = @"10";
static NSString * tradeDay      = @"11";
static NSString * streamTime    = @"12";
static NSString * comments      = @"13";
static NSString * username      = @"14";
static NSString * userType      = @"15";
static NSString * iPAdress      = @"16";
static NSString * valueDay      = @"17";
static NSString * valueTime     = @"18";
static NSString * adjustType    = @"19";
static NSString * custCmmt      = @"20";
static NSString * internCmmt    = @"21";

@implementation MoneyAccountStream

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(StreamID,    streamID)
jsonImplementionLongLong(Guid,        guid)
jsonImplementionLongLong(Account,     account)
jsonImplementionString  (Instrument,  instrument)
jsonImplementionLongLong(Ticket,      ticket)
jsonImplementionInt     (Splitno,     splitno)
jsonImplementionString  (CurrencyName,currencyName)
jsonImplementionInt     (Type,        type)
jsonImplementionDouble  (Amount,      amount)
jsonImplementionInt     (Ttype,       ttype)
jsonImplementionString  (TradeDay,    tradeDay)
jsonImplementionDate    (StreamTime,  streamTime)
jsonImplementionString  (Comments,    comments)
jsonImplementionString  (Username,    username)
jsonImplementionInt     (UserType,    userType)
jsonImplementionString  (IPAdress,    iPAdress)
jsonImplementionString  (ValueDay,    valueDay)
jsonImplementionDate    (ValueTime,   valueTime)
jsonImplementionInt     (AdjustType,  adjustType)
jsonImplementionString  (CustCmmt,    custCmmt)
jsonImplementionString  (InternCmmt,  instrument)

@end
