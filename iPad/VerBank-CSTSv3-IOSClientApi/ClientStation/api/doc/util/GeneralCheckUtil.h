//
//  GeneralCheckUtil.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneralCheckUtil : NSObject

- (Boolean)isTradeAmountLegal4MKTTrade:(NSString *)instrument
                                  acid:(long long)accountID
                               buySell:(int)buySell
                                amount:(long)amount;

- (Boolean)isTradeAmountLegal:(NSString *)instrument
                        price:(double)price
                       amount:(long)amount;

- (NSString *)isTradeAmountLegal4MKTTrade2:(NSString *)instrument
                                      acid:(long long)accountID
                                   buySell:(int)buySell
                                    amount:(long)amount;

- (NSString *)isTradeAmountLegal2:(NSString *)instrument
                            price:(double)price
                           amount:(long)amount;

- (Boolean)isTradeAmountLegalForClosePosition:(long)positionAmount
                                toCloseAmount:(long)toCloseAmount;

- (Boolean)isTradeAmountLegalForOpenPosition:(long)amount;

@end
