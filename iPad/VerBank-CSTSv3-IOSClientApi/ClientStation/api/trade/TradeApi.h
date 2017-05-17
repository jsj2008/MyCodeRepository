//
//  TradeApi.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created by Allone on 15/7/7.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IP_TRADESERV5101.h"
#import "TradeResult_MktCFD.h"
#import "IP_TRADESERV5102.h"
#import "TradeResult_HedgeCFD.h"
#import "IP_TRADESERV5103.h"
#import "TradeResult_OrderCFD.h"
#import "IP_TRADESERV5104.h"
#import "IP_TRADESERV5105.h"
#import "IP_TRADESERV5108.h"
#import "TradeResult.h"
#import "PriceWarning.h"
#import "TradeResult_CAURL.h"
#import "ToOpenTradeNode.h"
#import "MessageToAccount.h"
#import "WithDrawApplication.h"
#import "TradeResult_SimpleReport.h"
#import "TradeResult_CAFnStatus.h"
#import "TradeResult_CACert.h"
#import "TradeResult_CACertState.h"
#import "TradeResult_CAQueryCert.h"
#import "TradeResult_SimpleList.h"

@interface TradeApi : NSObject

#pragma init
+ (TradeApi *)getInstance;

#pragma 创建开市价CFD单的IP
- (IP_TRADESERV5101 *)createMktCFDTradeIPAccount:(long long)accountID
                                  instrumentName:(NSString *)instrumentName
                                    isBuyNotSell:(Boolean)isBuyNotSell
                                          amount:(double)amount
                                           price:(double)price
                                     mktPirceGap:(int)mktPriceGap
                               toCloseTradeNodes:(NSArray *)toCloseTradeNodes
                                 toOpenTradeNode:(ToOpenTradeNode *)toOpenTicket
                                    IFDStopPrice:(double)iFDStopPrice
                                   IFDLimitPrice:(double)iFDLimitPrice;

#pragma 开市价CFD单
- (TradeResult_MktCFD *)doMKTCFDTrade:(IP_TRADESERV5101 *)ip;


#pragma 创建对冲的IP
- (IP_TRADESERV5102 *)createHedgeCFDTradeAccount:(long long)accountID
                                      instrument:(NSString *)instrument
                            toCloseBuyTradeNodes:(NSArray *)toCloseBuyTickets
                           toCloseSellTradeNodes:(NSArray *)toCloseSellTickets;


#pragma 对冲交易
- (TradeResult_HedgeCFD *)doHedgeCFDTrade:(IP_TRADESERV5102 *)ip;

#pragma 委托下单IP
- (IP_TRADESERV5103 *)createOpenNormalOrderCFDTradeAccount:(long long)account
                                                instrument:(NSString *)instrument
                                              isBuyNotSell:(Boolean)isBuyNotSell
                                                    amount:(double)amount
                                                limitPrice:(double)limitPrice
                                              oriStopPrice:(double)oriStopPrice
                                                 toOpenNew:(Boolean)toOpenNew
                                            toCloseTickets:(NSMutableArray *)toCloseTickets
                                                expiryType:(int)expiryType
                                               nexpireTime:(NSString *)expireTime
                                             IFDLimitPrice:(double)iFDLimitPrice
                                              IFDStopPrice:(double)iFDStopPrice;

#pragma 委托下单
- (TradeResult_OrderCFD *)doOpenNormalOrderCFDTrade:(IP_TRADESERV5103 *)ip;

- (IP_TRADESERV5103 *)createOpen_Close_1_FIXED_TRADE_ORDER_CFDTradeAccount:(long long)account
                                                                instrument:(NSString *)instrument
                                                              isBuyNotSell:(Boolean)isBuyNotSell
                                                                limitPrice:(double)limitPrice
                                                              oriStopPrice:(double)oriStopPrice
                                                               stopMoveGap:(int)stopMoveGap
                                                             toCloseTicket:(long long)toCloseTicket
                                                                expiryType:(int)expiryType
                                                                expireTime:(NSString *)expireTime;

- (TradeResult_OrderCFD *)doOpen_CLOSE_1_FIXED_TRADE_ORDER_CFDTrade:(IP_TRADESERV5103 *)ip;


#pragma 修改委托单
- (IP_TRADESERV5104 *)createModifyOrderAccount:(long long)account
                                       orderID:(long long)orderID
                                        amount:(double)amount
                                   stopMoveGap:(int)stopMoveGap
                                    linutPirce:(double)limitPrice
                                  oriStopPrice:(double)oriStopPrice
                                    expiryType:(int)expiryType
                                    expiryTime:(NSString *)expiryTime
                                 IFDLimitPrice:(double)iFDLimitPrice
                                  IFDStopPrice:(double)iFDStopPrice;


#pragma 修改委托单
- (TradeResult_OrderCFD *)doModifyOrder:(IP_TRADESERV5104 *)ip;


#pragma 删除委托单
- (IP_TRADESERV5105 *)createDeleteOrderTradeAccount:(long long)account
                                            orderID:(long long)orderID;


#pragma 删除委托单
- (TradeResult *)doDeleteOrderTrade:(IP_TRADESERV5105 *)ip;

#pragma 修改用户密码
- (int)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword;

#pragma 修改phonepin
- (int)changePhonePinAccount:(long long)account
                 oldPhonePin:(NSString *)oldPhonePin
                 newPhonePin:(NSString *)newPhonePin;

#pragma 修改使用者代号
- (TradeResult *)changeUserName:(NSString *)userName;

#pragma 修改移动止损
- (TradeResult *)changeStopMoveAccount:(long long)account
                               orderID:(long long)orderID
                               moveGap:(int)moveGap;

#pragma 发送消息
- (Boolean)sendMessage:(NSString *)title
               context:(NSString *)context;

#pragma 验证帐号
- (Boolean)checkAccount:(long long)accountID;

#pragma 保證金通知
- (NSArray *)getMarginCallAccount:(long long)accountID;

#pragma 確認保證金通告
- (Boolean)confirmMarginCallAccount:(long long)accountID
                           tradeDay:(NSString *)tradeDay
                              level:(int)level
                           subLevel:(int)subLevel;

#pragma 获取历史数据
- (NSArray *)queryHisData:(NSString *)instrument
                    cycle:(int)cycle;

#pragma  获取更多的历史数据
- (NSArray *)queryHisData:(NSString *)instrument
                    cycle:(int)cycle
                  endTime:(long long)endTime;

- (NSArray *)queryShortTikHisData:(NSString *)instrument;

- (NSArray *)queryTikHisData:(NSString *)instrument;

- (NSArray *)queryTikHisData:(NSString *)instrument
                      number:(int)number;

#pragma 查询消息
- (NSArray *)queryMessages;

#pragma 通过消息的guid获取消息详情
- (MessageToAccount *)queryMessage:(NSString *)messageGuid;

#pragma 发起取款
- (Boolean)sendWithdrawApplicationPassword:(NSString *)password
                               application:(WithDrawApplication *)application;

- (Boolean)hasQuoteBeenRequired:(NSString *)instrument;

#pragma 获取凭证URL
- (TradeResult_CAURL *)getCAURLAccount:(long long)account
                                  aeid:(NSString *)aeid;

// ------------------------------------------------------------------------------
// ---------------------------报表-------------------------------------------------
// -------------------------------------------------------------------------------
#pragma 报表
- (NSArray *)queryTSettledAccount:(long long)account
                          fromDay:(NSString *)fromDay
                           endDay:(NSString *)endDay;

#pragma 挂单历史
- (TradeResult_SimpleReport *)report_TOrderHisDetails_Account:(NSDate *)fromTime
                                                      endTime:(NSDate *)endTime
                                                      account:(long long)account;


#pragma 平仓历史
- (TradeResult_SimpleReport *)report_ClosedPositionsDetails_Account:(NSDate *)fromTime
                                                            endTime:(NSDate *)endTime
                                                            account:(long long)account;


- (TradeResult_SimpleReport *)report_MessageToAccount:(NSString *)aeid;

#pragma 推播历史
- (TradeResult_SimpleReport *)report_PushFromSystemAll:(NSString *)aeid;

#pragma 历史已读
- (void)readPushMessage:(NSString *)aeid guid:(NSString *)guid;

#pragma 查询保证金
- (TradeResult_SimpleReport *)report_AccountStreamDetails:(NSDate *)fromTime
                                                  endDate:(NSDate *)endTime
                                                  typeVec:(NSArray *)typeVec;

#pragma 查询价格预警
- (NSArray *)queryPriceWarning;

#pragma 查询价格预警(未读)
- (NSArray *)queryPriceWarning4NoRead;

#pragma 查询价格预警(时间段)
- (NSArray *)queryPriceWarningFromTime:(NSDate *)fromTime
                               endTime:(NSDate *)endTime;

#pragma 增加价格预警
- (PriceWarning *)addPriceWarningAccount:(long long)account
                              instrument:(NSString *)instrument
                                   price:(double)price
                               priceType:(int)priceType
                              expiryType:(int)expiryType
                              expiryTime:(NSDate *)expiryTime;

- (PriceWarning *)modPriceWarning:(NSString *)guid
                            price:(double)price
                       expiryType:(int)expiryType
                       expiryTime:(NSDate *)expiryTime;

- (TradeResult *)deletePriceWarning:(NSString *)guid;

- (void)readPriceWarning:(NSString *)guid;

#pragma CA 凭证管理

- (int)checkAccount:(long long)account
           phonePin:(NSString *)phonePin;

- (TradeResult_CAFnStatus *)getFnStatus2DeviceID:(NSString *)deviceID
                                        venderID:(NSString *)venderID;

- (TradeResult_CACert *)requestApplyCertDeviceID:(NSString *)deviceID
                                        venderID:(NSString *)venderID
                                        password:(NSString *)password
                                             csr:(NSString *)csr;

- (TradeResult_CACert *)updateReNewCertDeviceID:(NSString *)deviceID
                                       venderID:(NSString *)venderID
                                       password:(NSString *)password
                                            csr:(NSString *)csr;

- (TradeResult_CACert *)certInstallCompleteDevice:(NSString *)deviceID
                                         venderID:(NSString *)venderID;

- (TradeResult_CACert *)getCertDeviceID:(NSString *)deviceID
                               venderID:(NSString *)venderID;

- (TradeResult_CACertState *)getCertStateDeviceID:(NSString *)deviceID
                                         venderID:(NSString *)venderID;

- (TradeResult_CAQueryCert *)queryCertDeviceID:(NSString *)deviceID
                                      venderID:(NSString *)venderID
                                    certSerial:(NSString *)certSerial;

#pragma deviceTokenTest
- (TradeResult *)setDeviceTokenAeid:(NSString *)aeid
                          accountID:(NSString *)accountID
                          groupName:(NSString *)groupName
                        deviceToken:(NSString *)deviceToken
                         deviceType:(int)deviceType;

#pragma caDownloadTime
- (Boolean)updateCADownloadTimer;

#pragma queryEconomicData
- (TradeResult_SimpleList *)queryEconomicDatas;

#pragma saveOptRecords
- (TradeResult *)saveOptRecords:(NSArray *)optRecord;

@end
