//
//  QuoteData.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "QuoteData.h"
static NSString * jsonId = @"QuoteData";

static NSString * instrument = @"1";
static NSString * bid = @"2";
static NSString * ask = @"3";
static NSString * quoteDay = @"4";
static NSString * quoteTime = @"5";
static NSString * openPrice = @"6";
static NSString * highPrice = @"7";
static NSString * lowPrice = @"8";
static NSString * yclosePrice = @"9";
static NSString * lastBid = @"10";
static NSString * tradeable = @"11";
static NSString * Close = @"12";

static NSString * bidBank = @"13";
static NSString * bidId = @"14";
static NSString * askBank = @"15";
static NSString * askId = @"16";

static NSString * lastAsk = @"17";
static NSString * bidAmount = @"18";
static NSString * askAmount = @"19";
@implementation QuoteData
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(Instrument,  instrument)
jsonImplementionDouble(Bid,         bid)
jsonImplementionDouble(Ask,         ask)
jsonImplementionString(QuoteDay,    quoteDay)
jsonImplementionLongLong(QuoteTime,     quoteTime)

jsonImplementionDouble(OpenPrice,   openPrice)
jsonImplementionDouble(HighPrice,   highPrice)
jsonImplementionDouble(LowPrice ,   lowPrice)
jsonImplementionDouble(YclosePrice ,yclosePrice)
jsonImplementionDouble(LastBid ,    lastBid)
jsonImplementionBoolean(Tradeable,  tradeable)
jsonImplementionBoolean(Close,      Close)

jsonImplementionString(BidBank,     bidBank)
jsonImplementionString(BidId ,      bidId)
jsonImplementionString(AskBank,     askBank)
jsonImplementionString(AskId,       askId)

jsonImplementionDouble(LastAsk ,    lastAsk)
jsonImplementionDouble(BidAmount,   bidAmount)
jsonImplementionDouble(AskAmount ,  askAmount)
@end
