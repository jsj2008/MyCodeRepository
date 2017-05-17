//
//  TradeActionUtil.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDS_PriceSnapShot;

typedef NS_ENUM(NSInteger, TradeFunction) {
    Function_Trade_Unknow           = 0,
    
    Function_Trade_MKT              = 1,
    Function_Trade_Add_Order        = 2,
    Function_Trade_Modify_Order     = 3,
    Function_Trade_Delete_Order     = 4,
    Function_Trade_Add_OpenOrder    = 5,
    Function_Trade_Modify_OpenOrder = 6,
    Function_Trade_Delete_OpenOrder = 7,
    Function_Trade_Hedging          = 8,
    Function_Trade_ClosePosition    = 9,
};

@interface TradeActionUtil : NSObject

+ (TradeActionUtil *)getInstance;

- (void)destroy;

- (void)setCurrentFunctionTrade:(TradeFunction)function;
- (void)doTradeByFunction;

// 市价开仓
- (void)doMKTTradeInstrumentName:(NSString *)instrument
                       isBuySell:(Boolean)isBuySell
                          amount:(double)amount
                   priceSnapshot:(CDS_PriceSnapShot *)pss;


// 新增挂单
- (void)doAddOrderTradeInstrument:(NSString *)instrument
                        isBuySell:(Boolean)isBuySell
                           amount:(double)amount
                       limitPrice:(double)limitPrice
                        stopPrice:(double)stopPrice
                       expiryType:(int)expiryType
                       expiryTime:(NSString *)expiryTime
                    IDTLimitPrice:(double)idtLimitPrice
                     IDTStopPrice:(double)idtStopPrice;

// 修改挂单
- (void)doModifyOrderTradeInstrument:(NSString *)instrument
                           isBuySell:(Boolean)isBuySell
                             orderID:(long long)orderID
                              amount:(double)amount
                          limitPrice:(double)limitPrice
                           stopPrice:(double)stopPrice
                          expiryType:(int)expiryType
                          expiryTime:(NSString *)expiryTime
                       IDTLimitPrice:(double)idtLimitPrice
                        IDTStopPrice:(double)idtStopPrice;

// 删除挂单
- (void)doDeleteOrder:(long long)orderID;

// 新建开仓附挂单
- (void)doAddOpenOrderTradeInstrument:(NSString *)instrument
                            isBuySell:(Boolean)isBuySell
                           limitPrice:(double)limitPrice
                         oriStopPrice:(double)stopPrice
                          stopMoveGap:(int)stopMoveGap
                        toCloseTicket:(long long)closeTicket
                           expireType:(int)expireType
                           expireTime:(NSString *)expireTime;

// 修改开仓附挂单
- (void)doModifyOpenOrderTradeOrderID:(long long)orderID
                               amount:(double)amount
                          stopMoveGap:(int)stopMoveGap
                           limitPrice:(double)limitPrice
                         oriStopPrice:(double)stopPrice
                           expireType:(int)expireType
                           expireTime:(NSString *)expireTime;

// 删除附挂单
- (void)doDeleteOpenOrder:(long long)orderID;

// 对冲
- (void)doHedgingTradeInstrument:(NSString *)instrument
              closeBuyTradeNodes:(NSArray *)buyTradeArray
             closeSellTradeNodes:(NSArray *)sellTradeArray;

// 平倉交易
- (void)doClosePositionInstrument:(NSString *)instrument
                     isBuyNotSell:(Boolean)isBuySell
                           amount:(double)amount
                            price:(double)price
                  closeTradeNodes:(NSArray *)closeTradeNodes;

// 新增价格提示
- (void)doAddPriceWarningInstrument:(NSString *)instrument
                              price:(double)price
                          priceType:(int)priceType
                         expireType:(int)expireType
                         expireTime:(NSDate *)expireTime;

// 修改价格提示
- (void)doModifyPriceWarningGuid:(NSString *)guid
                           price:(double)price
                      expireType:(int)expireType
                      expireTime:(NSDate *)expireTime;

// 删除价格提示
- (void)doDeletePriceWarningGuid:(NSString *)guid;

@end
