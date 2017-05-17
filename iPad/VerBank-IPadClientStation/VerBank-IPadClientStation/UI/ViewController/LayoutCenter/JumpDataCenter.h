//
//  JumpDataCenter.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/15.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenSuccessStruct.h"
#import "FnCertState.h"

@class KChartWebView;

@class TTrade;
@class TOrder;
@class PriceWarning;
@class ValueTimeButton;

typedef NS_ENUM(NSUInteger, AddNewOpenOrderType) {
    AddNewOpenOrderTypeLimit    = 0,
    AddNewOpenOrderTypeStop     = 1,
    AddNewOpenOrderTypeOCO      = 2,
};

@interface JumpDataCenter : NSObject

// 新增掛單 新增市價交易 新增價格提示  公用一個Instrument
@property NSString  *createTradeInstrument;
@property int       marketTradeType;

// 開倉失敗 的 消息
@property NSString *openFailedMessage;
@property OpenSuccessStruct *openSuccessStruct;

// 交易結果的 消息
@property NSString *tradeResultTitle;
@property NSString *tradeResultMessage;

// 掛單修改的 Order
@property TOrder *modifyOrder;
//  附挂单  trade
@property TTrade *openOrderTrade;

@property AddNewOpenOrderType openOrderType;

@property NSString *openPositionOrderInstrument;

@property NSString *hedgingInstrumentName;

@property TTrade *closePositionTrade;

@property PriceWarning *priceWarning;

@property NSUInteger customAmountIndex;

@property FnCertState *fnCertState;
@property NSString *fnCertResult;

@property NSInteger rssIndex;

@property NSString *phonePin;

@property long long addNewOrderID;// 新建挂单ID
@property long long openPositionTicket;
@property NSString *openPositionInstrumentName;// 开仓单
@property NSArray *closePositionHisTicketArray;

@property int       tradeShowIndex;

@property __weak KChartWebView *kChartWebView;

//时间 选择 按钮
@property ValueTimeButton *valueTimeButton;

@property NSString *enlargeInstrumentName;

+ (JumpDataCenter *)getInstance;

- (void)destroy;

- (void)resetPhonePinErr;
- (void)phonePinErr;

@end
