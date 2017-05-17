//
//  QuoteItem.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuoteItem.h"

@implementation QuoteItem

//- (id)copy{
//    QuoteItem *quote = [[QuoteItem alloc] init];
//    [quote setInstrument:self.instrument];
//    [quote setHighPrice:self.highPrice];
//    [quote setLowPricel:self.lowPricel];
//    [quote setQuoteTime:self.quoteTime];
//    [quote setAsk:self.ask];
//    [quote setBid:self.bid];
//    [quote setUpDownPrice:self.upDownPrice];
//    [quote setUpDown:self.upDown];
//    [quote setExtradigit:self.extradigit];
//    return quote;
//}

@synthesize instrument = _instrument;
@synthesize highPrice = _highPrice;
@synthesize lowPricel = _lowPricel;
@synthesize quoteTime = _quoteTime;
@synthesize ask = _ask;
@synthesize bid = _bid;
@synthesize upDownPrice = _upDownPirce;
@synthesize upDownPricePercent = _upDownPricePercent;
@synthesize upDown = _upDown;
@synthesize extradigit = _extradigit;

@end
