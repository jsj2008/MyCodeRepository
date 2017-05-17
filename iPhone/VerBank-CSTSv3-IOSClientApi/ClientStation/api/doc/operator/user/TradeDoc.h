//
//  TradeDoc.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTrade.h"

@interface TradeDoc : NSObject

- (NSMutableArray *)getTTradeByAccountList:(long long)account;
- (NSMutableArray *)getTTradeByInstrumentList:(NSString *)instrumen;

- (TTrade *)getTTrade:(long long)ticket;
- (NSArray *)getTTrades;

- (void)removeTrade:(long long)ticket;
- (void)addTrade:(TTrade *)trade;
- (void)addTrades:(NSArray *)trades;
- (void)clearTrade;


@end
