//
//  EconomicData.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "EconomicData.h"

static NSString * jsonId = @"EconomicData";

static NSString * guid = @"1";
static NSString * date = @"2";
static NSString * etime = @"3";
static NSString * publishedTime = @"4";
static NSString * economicData = @"5";
static NSString * forecastsValue = @"6";
static NSString * beforeTheValue = @"7";
static NSString * inputTime = @"8";
static NSString * dealer = @"9";
static NSString * country = @"10";
static NSString * level = @"11";

@implementation EconomicData

@synthesize sortTag;

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Guid, guid)
jsonImplementionString(Date, date)
jsonImplementionString(Time, etime)

jsonImplementionString(PublishedTime, publishedTime)
jsonImplementionString(EconomicData, economicData)
jsonImplementionString(ForecastsValue, forecastsValue)

jsonImplementionString(BeforeTheValue, beforeTheValue)
jsonImplementionString(InputTime, inputTime)
jsonImplementionString(Dealer, dealer)

jsonImplementionString(Country, country)
jsonImplementionString(Level, level)

@end
