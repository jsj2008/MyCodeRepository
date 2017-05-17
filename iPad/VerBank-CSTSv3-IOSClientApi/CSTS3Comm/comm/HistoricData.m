//
//  HistoricData.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/5.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "HistoricData.h"

static NSString * jsonId = @"HistoricData";

static NSString * dataTime              = @"1";
static NSString * quoteDay              = @"2";
static NSString * openPrice             = @"3";
static NSString * highPrice             = @"4";
static NSString * lowPrice              = @"5";
static NSString * closePrice            = @"6";
static NSString * volume                = @"7";
static NSString * amount                = @"8";

@implementation HistoricData

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(DataTime,  dataTime)
jsonImplementionString(QuoteDay,    quoteDay)
jsonImplementionDouble(OpenPrice,   openPrice)
jsonImplementionDouble(HighPrice,   highPrice)
jsonImplementionDouble(LowPrice,    lowPrice)
jsonImplementionDouble(ClosePrice,  closePrice)
jsonImplementionDouble(Volume,      volume)
jsonImplementionDouble(Amount,      amount)

@end
