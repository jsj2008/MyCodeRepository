//
//  ExchangeUtil.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeUtil_node.h"

@interface ExchangeUtil : NSObject

+ (NSString *)getExchangeUtilName:(NSString *)insCurr :(NSString *)balCurr;

- (double)exchangeToSysBasicCcy:(NSString *)ccy :(double)amount;
- (ExchangeUtil_node *)createExchangeNodeToAccountBasicCcy:(long long)account  Ccy1:(NSString *)ccy1  Amount:(double)amount;
- (double)exchangeToAccountBasicCcy:(long long)account  Ccy1:(NSString *)ccy1  Amount:(double)amount;
- (double)exchange:(NSString *)ccy1  Amount:(double)amount  Ccy2:(NSString *)ccy2;
- (ExchangeUtil_node *)createExchangeNode:(NSString *)ccy1  Amount:(double)amount  Ccy2:(NSString *)ccy2;
- (ExchangeUtil_node *)createExchangeNode:(NSString *)ccy1  Amount:(double)amount  Ccy2:(NSString *)ccy2  UseMidPrice:(Boolean)userMidPrice;
- (ExchangeUtil_node *)createExchangeNode:(NSString *)ccy1  Amount:(double)amount  Ccy2:(NSString *)ccy2  PairInstrument:(NSString *)pairInstrument  SuggestedPrice:(double)suggestedPrice;

@end
