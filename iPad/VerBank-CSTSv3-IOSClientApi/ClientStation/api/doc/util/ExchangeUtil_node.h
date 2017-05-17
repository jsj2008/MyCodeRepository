//
//  ExchangeUtil_node.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/2.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instrument.h"

@interface ExchangeUtil_node : NSObject

- (id)initWithCcy1:(NSString *)ccy1  Ccy2:(NSString *)ccy2  Amount:(double)amount  Instrument:(Instrument *)instrument  Bid:(double)bid  Ask:(double)ask;
- (id)initWithCcy1:(NSString *)ccy1  Ccy2:(NSString *)ccy2  Amount:(double)amount  Instrument:(Instrument *)instrument  Bid:(double)bid  Ask:(double)ask  UseMidPrice:(Boolean)useMidPrice;

@property NSString *ccy1;
@property NSString *ccy2;
@property double amount;
@property Instrument *instrument;
@property double bid;
@property double ask;

- (double)getExchangeMoney;
- (double)exchangeForBalanceCurr:(double)price;
- (double)__exchangeForBalanceCurr:(double)price;
- (double)fixOriAmount:(double)amount :(NSString *)ccy;
- (double)getExchangePrice;
- (NSString *)getInstrument;

@end
