//
//  PriceWarning.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "PriceWarning.h"
static NSString * jsonId = @"PriceWarning";

// private String Guid;
// private long Account;
// private String dealerName;
// private int origin;
// private Date Time;
// private String instrument;
// private double Price;
// private int CompareWay;
// private int PriceType;
// private int IsPriceReach;
// private double ReachPrice;
// private Date reachTime;
// private int isRead;
// private Date readTime;
// private String readDescription;

static NSString * Guid = @"1";
static NSString * Account = @"2";
static NSString * DealerName = @"3";

static NSString * DealerDesc = @"4";

static NSString * Origin = @"5";
static NSString * Time = @"6";
static NSString * Instrument = @"7";
static NSString * Price = @"8";
//static NSString * CompareWay = @"8";
static NSString * PriceType = @"9";
static NSString * IsPriceReach = @"10";
static NSString * ReachPrice = @"11";
static NSString * ReachTime = @"12";
static NSString * IsRead = @"13";
static NSString * ReadTime = @"14";
static NSString * ReadDescription = @"15";
static NSString * ExpiryType = @"16";
static NSString * ExpiryTime = @"17";

@implementation PriceWarning

- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Guid,        Guid)
jsonImplementionLongLong(Account,   Account)
jsonImplementionString(DealerName,  DealerName)

jsonImplementionString(DealerDesc,  DealerDesc)

jsonImplementionInt(Origin,         Origin)
jsonImplementionDate(Time,          Time)
jsonImplementionString(Instrument,  Instrument)
jsonImplementionDouble(Price,       Price)
//jsonImplementionInt(CompareWay,     CompareWay)
jsonImplementionInt(PriceType,      PriceType)
jsonImplementionInt(IsPriceReach,   IsPriceReach)
jsonImplementionDouble(ReachPrice,  ReachPrice)
jsonImplementionDate(ReachTime,     ReachTime)
jsonImplementionInt(IsRead,         IsRead)
jsonImplementionDate(ReadTime,      ReadTime)
jsonImplementionString(ReadDescription, ReadDescription)

jsonImplementionInt(ExpiryType,     ExpiryType)
jsonImplementionDate(ExpiryTime,    ExpiryTime)

@end
