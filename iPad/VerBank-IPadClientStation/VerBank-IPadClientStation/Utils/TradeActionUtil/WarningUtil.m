//
//  WarningUtil.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "WarningUtil.h"

#import "LangCaptain.h"
#import "CDS_PriceSnapShot.h"
#import "QuoteDataStore.h"
#import "DecimalUtil.h"

@implementation WarningUtil

+ (Boolean)isWarningCheck:(double)inputPrice
                    price:(double)price
                     perc:(double)perc
                     type:(int)type
                  buySell:(Boolean)buySell{
    double priceSafe = price * perc;
    double tempInputPrice = 0;
    switch (type) {
        case ORDERTYPE_LIMIT:
            tempInputPrice = buySell ? price - priceSafe : price + priceSafe;
            if (buySell) {
                if (inputPrice - tempInputPrice < 0.00001) {
                    return true;
                } else {
                    return false;
                }
            } else {
                if (inputPrice - tempInputPrice > 0.00001) {
                    return true;
                } else {
                    return false;
                }
            }
            break;
        case ORDERTYPE_STOP:
            tempInputPrice = buySell ? price + priceSafe : price - priceSafe;
            if (buySell) {
                if (inputPrice - tempInputPrice > 0.00001) {
                    return true;
                } else {
                    return false;
                }
            } else {
                if (inputPrice - tempInputPrice < 0.00001) {
                    return true;
                } else {
                    return false;
                }
            }
            break;
        case ORDERTYPE_IDTLIMIT:
            tempInputPrice = buySell ? price + priceSafe : price - priceSafe;
            if (buySell) {
                if (inputPrice - tempInputPrice > 0.00001) {
                    return true;
                } else {
                    return false;
                }
            } else {
                if (inputPrice - tempInputPrice < 0.00001) {
                    return true;
                } else {
                    return false;
                }
            }
            break;
        case ORDERTYPE_IDTSTOP:
            tempInputPrice = buySell ? price - priceSafe : price + priceSafe;
            if (buySell) {
                if (inputPrice - tempInputPrice < 0.00001) {
                    return true;
                } else {
                    return false;
                }
            } else {
                if (inputPrice - tempInputPrice > 0.00001) {
                    return true;
                } else {
                    return false;
                }
            }
            break;
        default:
            break;
    }
    return false;
}

+ (CheckWarningNode *)checkAndShowWarningBuySell:(Boolean)buySell
                                      limitPrice:(double)limitPrice
                                       stopPrice:(double)stopPrice
                                   ifdLimitPrice:(double)ifdLimitPrice
                                    ifdStopPrice:(double)ifdStopPrice
                                      instrument:(NSString *)instrument
                                         percent:(double)percent{
    return [self checkAndShowWarningBuySell:buySell
                                 limitPrice:limitPrice
                                  stopPrice:stopPrice
                              ifdLimitPrice:ifdLimitPrice
                               ifdStopPrice:ifdStopPrice
                                 instrument:instrument
                                  priceName:[[LangCaptain getInstance] getLangByCode:@"Price"]
                                    percent:percent
            ];
}

+ (CheckWarningNode *)checkAndShowWarningBuySell:(Boolean)buySell
                                      limitPrice:(double)limitPrice
                                       stopPrice:(double)stopPrice
                                   ifdLimitPrice:(double)ifdLimitPrice
                                    ifdStopPrice:(double)ifdStopPrice
                                      instrument:(NSString *)instrument
                                       priceName:(NSString *)priceName
                                         percent:(double)percent{
    CheckWarningNode *pstay = [[CheckWarningNode alloc] init];
    double doublePerc = 0.000001;
    CDS_PriceSnapShot *quoteData = [[QuoteDataStore getInstance] getQuoteData:instrument];
    if (quoteData == nil) {
        [pstay setIsSucceed:true];
        return pstay;
    }
    
    double mktPrice = buySell ? [quoteData getAsk] : [quoteData getBid];
    NSMutableString *sb = [[NSMutableString alloc] init];
    
    Boolean isWarningLimit = false;
    Boolean isWarningStop = false;
    Boolean isWarningIDTLimit = false;
    Boolean isWarningIDTStop = false;
    
    if (limitPrice > doublePerc) {
        isWarningLimit = [self isWarningCheck:limitPrice price:mktPrice perc:percent type:ORDERTYPE_LIMIT buySell:buySell];
        if (isWarningLimit) {
            [sb appendString:instrument];
            [sb appendString:@"的當前市價"];
            [sb appendString:[DecimalUtil formatPrice:mktPrice instrument:instrument]];
            [sb appendString:@"\n您提交的[限價Limit]為"];
            [sb appendString:[DecimalUtil formatPrice:limitPrice instrument:instrument]];
            [sb appendString:@"\n"];
        }
    }
    
    if (stopPrice > doublePerc) {
        isWarningStop = [self isWarningCheck:stopPrice price:mktPrice perc:percent type:ORDERTYPE_STOP buySell:buySell];
        
        if (isWarningStop) {
            [sb appendString:instrument];
            [sb appendString:@"的當前市價"];
            [sb appendString:[DecimalUtil formatPrice:mktPrice instrument:instrument]];
            [sb appendString:@"\n您提交的[停損價stop loss]為"];
            [sb appendString:[DecimalUtil formatPrice:stopPrice instrument:instrument]];
            [sb appendString:@"\n"];
        }
    }
    
    if (limitPrice > doublePerc && stopPrice > doublePerc) {
        isWarningIDTLimit = false;
        isWarningIDTStop = false;
    } else if(limitPrice > doublePerc){
        if (ifdLimitPrice > doublePerc) {
            isWarningIDTLimit = [self isWarningCheck:ifdLimitPrice price:limitPrice perc:percent type:ORDERTYPE_IDTLIMIT buySell:buySell];
        }
        
        if (isWarningIDTLimit) {
            [sb appendString:instrument];
            [sb appendString:@"的當前輸入的[限價Limit]為"];
            [sb appendString:[DecimalUtil formatPrice:limitPrice instrument:instrument]];
            [sb appendString:@"\n您提交的[IDT止盈]為"];
            [sb appendString:[DecimalUtil formatPrice:ifdLimitPrice instrument:instrument]];
            [sb appendString:@"\n"];
        }
        
        if (ifdStopPrice > doublePerc) {
            isWarningIDTStop = [self isWarningCheck:ifdStopPrice price:limitPrice perc:percent type:ORDERTYPE_IDTSTOP buySell:buySell];
        }
        
        if (isWarningIDTStop) {
            [sb appendString:instrument];
            [sb appendString:@"的當前輸入的[限價Limit]為"];
            [sb appendString:[DecimalUtil formatPrice:limitPrice instrument:instrument]];
            [sb appendString:@"\n您提交的[IDT止損]為"];
            [sb appendString:[DecimalUtil formatPrice:ifdStopPrice instrument:instrument]];
            [sb appendString:@"\n"];
        }
    } else if(stopPrice > doublePerc){
        if (ifdLimitPrice > doublePerc) {
            isWarningIDTLimit = [self isWarningCheck:ifdLimitPrice price:stopPrice perc:percent type:ORDERTYPE_IDTLIMIT buySell:buySell];
        }
        if (isWarningIDTLimit) {
            [sb appendString:instrument];
            [sb appendString:@"\n當前輸入的[停損價stop loss]為"];
            [sb appendString:[DecimalUtil formatPrice:stopPrice instrument:instrument]];
            [sb appendString:@"\n您提交的[IDT止盈]為"];
            [sb appendString:[DecimalUtil formatPrice:ifdLimitPrice instrument:instrument]];
            [sb appendString:@"\n"];
        }
        
        if (ifdStopPrice > doublePerc) {
            isWarningIDTStop = [self isWarningCheck:ifdStopPrice price:stopPrice perc:percent type:ORDERTYPE_IDTSTOP buySell:buySell];
        }
        
        if (isWarningIDTStop) {
            [sb appendString:instrument];
            [sb appendString:@"的當前輸入的[停損價stop loss]為"];
            [sb appendString:[DecimalUtil formatPrice:stopPrice instrument:instrument]];
            [sb appendString:@"\n您提交的[IDT止損]為"];
            [sb appendString:[DecimalUtil formatPrice:ifdStopPrice instrument:instrument]];
            [sb appendString:@"\n"];
        }
    }
    
    if (isWarningLimit || isWarningStop || isWarningIDTLimit || isWarningIDTStop) {
        [sb appendString:@"是否確定提交？"];
        [pstay setIsSucceed:false];
        [pstay setErrorMsg:sb];
        return pstay;
    }
    [pstay setIsSucceed:true];
    return pstay;
    
}

+ (CheckWarningNode *)checkAndShowPriceWarning:(double)price
                                    instrument:(NSString *)instrument
                                       percent:(double)percent {
    return [self checkAndShowPriceWarning:price
                               instrument:instrument
                                priceName:[[LangCaptain getInstance] getLangByCode:@"PriceNotice"]
                                  percent:percent];
}

+ (CheckWarningNode *)checkAndShowPriceWarning:(double)price
                                    instrument:(NSString *)instrument
                                     priceName:(NSString *)priceName
                                       percent:(double)percent {
    CheckWarningNode *warningNode = [[CheckWarningNode alloc] init];
    double doublePerc = 0.000001;
    CDS_PriceSnapShot *quoteData = [[QuoteDataStore getInstance] getQuoteData:instrument];
    if (quoteData == nil) {
        [warningNode setIsSucceed:true];
        return warningNode;
    }
    
    NSMutableString *sb = [[NSMutableString alloc] init];
    //    StringBuilder sb = new StringBuilder();
    //    sb.append("<html><body>");
    Boolean isWarningLimit = false;
    Boolean isWarningStop = false;
    if (price > doublePerc) {
        isWarningLimit = [self isPriceWarningCheck:true
                                        inputPrice:price
                                             price:[quoteData getAsk]
                                           percent:percent];
        
        if (isWarningLimit) {
            [sb appendString:instrument];
            [sb appendString:@"的當前市價為:"];
            [sb appendString:[DecimalUtil formatPrice:[quoteData getAsk] instrument:instrument]];
            [sb appendString:@"\n您提交的價格為"];
            [sb appendString:[DecimalUtil formatPrice:price instrument:instrument]];
        }
        
        isWarningStop = [self isPriceWarningCheck:false
                                       inputPrice:price
                                            price:[quoteData getBid]
                                          percent:percent];
        if (isWarningStop) {
            [sb appendString:instrument];
            [sb appendString:@"的當前市價為:"];
            [sb appendString:[DecimalUtil formatPrice:[quoteData getBid] instrument:instrument]];
            [sb appendString:@"\n您提交的價格為"];
            [sb appendString:[DecimalUtil formatPrice:price instrument:instrument]];
        }
    }
    if (isWarningLimit || isWarningStop) {
        [sb appendString:@"是否確定提交?"];
        [warningNode setErrorMsg:sb];
        [warningNode setIsSucceed:false];
        return warningNode;
    }
    [warningNode setIsSucceed:true];
    return warningNode;
}

+ (Boolean)isPriceWarningCheck:(Boolean)buySell
                    inputPrice:(double)inputPrice
                         price:(double)price
                       percent:(double)percent {
    double priceSafe = price * percent;
    double tempInputPrice = 0;
    if (buySell) {
        tempInputPrice = price + priceSafe;
        if (inputPrice - tempInputPrice > 0.00001) {
            return true;
        } else {
            return false;
        }
    } else {
        tempInputPrice = price - priceSafe;
        if (tempInputPrice - inputPrice > 0.00001) {
            return true;
        } else {
            return false;
        }
    }
}
@end
