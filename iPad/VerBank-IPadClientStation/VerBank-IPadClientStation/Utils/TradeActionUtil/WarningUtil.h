//
//  WarningUtil.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckWarningNode.h"

const static int ORDERTYPE_LIMIT = 0;
const static int ORDERTYPE_STOP = 1;
const static int ORDERTYPE_IDTLIMIT = 2;
const static int ORDERTYPE_IDTSTOP = 3;

@interface WarningUtil : NSObject

+ (Boolean)isWarningCheck:(double)inputPrice
                    price:(double)price
                     perc:(double)perc
                     type:(int)type
                  buySell:(Boolean)buySell;

+ (CheckWarningNode *)checkAndShowWarningBuySell:(Boolean)buySell
                                      limitPrice:(double)limitPrice
                                       stopPrice:(double)stopPrice
                                   ifdLimitPrice:(double)ifdLimitPrice
                                    ifdStopPrice:(double)ifdStopPrice
                                      instrument:(NSString *)instrument
                                       priceName:(NSString *)priceName
                                         percent:(double)percent;

+ (CheckWarningNode *)checkAndShowWarningBuySell:(Boolean)buySell
                                      limitPrice:(double)limitPrice
                                       stopPrice:(double)stopPrice
                                   ifdLimitPrice:(double)ifdLimitPrice
                                    ifdStopPrice:(double)ifdStopPrice
                                      instrument:(NSString *)instrument
                                         percent:(double)percent;

+ (CheckWarningNode *)checkAndShowPriceWarning:(double)price
                                    instrument:(NSString *)instrument
                                       percent:(double)percent;



@end
