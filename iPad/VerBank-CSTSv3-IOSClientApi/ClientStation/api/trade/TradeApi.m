//
//  TradeApi.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created by Allone on 15/7/7.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "TradeApi.h"
#import "TradeServiceErrCodeTable.h"
#import "ClientAPI.h"
#import "MTP4CommDataInterface.h"
#import "APIDoc.h"
#import "OP_TRADESERV5101.h"
#import "OP_TRADESERV5102.h"
#import "OP_TRADESERV5103.h"
#import "OP_TRADESERV5104.h"
#import "OP_TRADESERV5105.h"
#import "OP_TRADESERV5115.h"
#import "IP_TRADESERV5115.h"
#import "OP_TRADESERV5046.h"
#import "IP_TRADESERV5046.h"
#import "OP_TRADESERV5023.h"
#import "IP_TRADESERV5023.h"
#import "IP_TRADESERV5117.h"
#import "DocOperator.h"
#import "API_IDEventCaptain.h"
#import "IP_Ctrl4001.h"
#import "OP_Ctrl4001.h"
#import "IP_Ctrl4002.h"
#import "OP_Ctrl4002.h"
#import "IP_Ctrl4003.h"
#import "OP_Ctrl4003.h"
#import "IP_Ctrl4004.h"
#import "OP_Ctrl4004.h"
#import "IP_QDB1002.h"
#import "IP_QDB1003.h"
#import "IP_QDB1004.h"
#import "OP_QDB1002.h"
#import "OP_QDB1003.h"
#import "OP_QDB1004.h"
#import "ClosePositionDetails.h"

#import "IP_TRADESERV1901.h"
#import "OP_TRADESERV1901.h"
#import "IP_TRADESERV1904.h"
#import "OP_TRADESERV1904.h"
#import "IP_TRADESERV5061.h"
#import "OP_TRADESERV5061.h"
#import "IP_TRADESERV5062.h"
#import "OP_TRADESERV5062.h"

#import "IP_TRADESERV5116.h"
#import "OP_TRADESERV5116.h"
#import "IP_TRADESERV5065.h"
#import "OP_TRADESERV5065.h"
#import "IP_TRADESERV6101.h"
#import "OP_TRADESERV6101.h"
#import "IP_REPORT6102.h"
#import "OP_REPORT6102.h"
#import "IP_TRADESERV6103.h"
#import "OP_TRADESERV6103.h"

#import "IP_TDB1016.h"
#import "OP_TDB1016.h"

#import "IP_REPORT2001.h"
#import "OP_REPORT2001.h"
#import "IP_REPORT2007.h"
#import "OP_REPORT2007.h"
#import "IP_REPORT2023.h"
#import "OP_REPORT2023.h"
#import "IP_REPORT2011.h"
#import "OP_REPORT2011.h"

#import "IP_TRADESERV5026.h"
#import "OP_TRADESERV5026.h"
#import "IP_TRADESERV5109.h"
#import "OP_TRADESERV5109.h"

#import "IP_Ctrl5101.h"
#import "OP_Ctrl5101.h"
#import "IP_Ctrl5102.h"
#import "OP_Ctrl5102.h"
#import "IP_Ctrl5103.h"
#import "OP_Ctrl5103.h"
#import "IP_Ctrl5104.h"
#import "OP_Ctrl5104.h"
#import "IP_Ctrl5105.h"
#import "OP_Ctrl5105.h"
#import "IP_Ctrl5106.h"
#import "OP_Ctrl5106.h"
#import "IP_Ctrl5107.h"
#import "OP_Ctrl5107.h"

#import "IP_Ctrl5201.h"
#import "OP_Ctrl5201.h"

#import "TOrderHisDetails.h"
#import "CommDataInterface.h"
#import "AccountStreamDetails.h"
#import "UserDocOperator.h"

#import "CertificateUtil.h"

static TradeApi *tradeApi  = nil;

@interface TradeApi(){
    NSMutableArray *quoteNameArray;
}

@end

@implementation TradeApi

#pragma init
+ (TradeApi *)getInstance{
    if (tradeApi == nil) {
        tradeApi = [[TradeApi alloc] init];
    }
    return tradeApi;
}

- (id)init{
    if (self = [super init]) {
        quoteNameArray = [[NSMutableArray alloc] init];
    }
    return self;
}

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
                                   IFDLimitPrice:(double)iFDLimitPrice{
    if (toOpenTicket == nil && (toCloseTradeNodes == nil || [toCloseTradeNodes count] <= 0)) {
        @throw [[NSException alloc] initWithName:@"TradeAPI" reason:@"toOpenTicket and toCloseTickets all null!" userInfo:nil];
    }
    IP_TRADESERV5101 *ip = [[IP_TRADESERV5101 alloc] init];
    [ip setAccountID:accountID];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setInstrumentName:instrumentName];
    [ip setBuySell:isBuyNotSell ? BUY : SELL];
    [ip setAmount:amount];
    [ip setPrice:price];
    [ip setMktPriceGap:mktPriceGap];
    [ip setIsToOpenNew:toOpenTicket != nil];
    [ip setOrderType:ORDERTYPE_MKT];
    [ip setAccountDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:accountID]];
    if (toCloseTradeNodes != nil) {
        [ip setCloseTradeVec:toCloseTradeNodes];
    }
    [ip setOpenTrade:toOpenTicket];
    return ip;
}

#pragma 开市价CFD单
- (TradeResult_MktCFD *)doMKTCFDTrade:(IP_TRADESERV5101 *)ip {
    
    [ip setSignature:[CertificateUtil getPkcs7sin:ip]];
    [ip setOriSignature:[ip toString]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult_MktCFD *result = [[TradeResult_MktCFD alloc] init];
    if ([opfather isSuccessed]) {
        OP_TRADESERV5101 *op = (OP_TRADESERV5101 *)opfather;
        if ([op getMktPriceChanged]) {
            [result setResult:RESULT_PRICECHANGED];
            [result setNewMktPrice:[op getNewMKTPrice]];
        } else{
            [result setOrderHis:[op getOrderHis]];
            [result setResult:RESULT_SUCCEED];
        }
    } else {
        if ([opfather getErrCode] == nil) {
            [result setErrCodeAndCreateResult:ERR_Unknown];
        } else {
            [result setErrCodeAndCreateResult:[opfather getErrCode]];
        }
        [result set_errMessage:[opfather getErrMessage]];
    }
    
    //    if ([result result] == RESULT_MD5DigestDontMatch) {
    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    //    }
    
//    [API_IDEventCaptain fireEventChanged:NAME_TRADERETURN eventData:opfather];
    return result;
}


#pragma 创建对冲的IP
- (IP_TRADESERV5102 *)createHedgeCFDTradeAccount:(long long)accountID
                                      instrument:(NSString *)instrument
                            toCloseBuyTradeNodes:(NSArray *)toCloseBuyTickets
                           toCloseSellTradeNodes:(NSArray *)toCloseSellTickets{
    IP_TRADESERV5102 *ip = [[IP_TRADESERV5102 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setAccountID:accountID];
    [ip setInstrument:instrument];
    
    if (toCloseBuyTickets != nil) {
        [ip setCloseBuyTradeVec:toCloseBuyTickets];
    }
    
    if (toCloseSellTickets != nil) {
        [ip setCloseSellTradeVec:toCloseSellTickets];
    }
    [ip setAccountDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:accountID]];
    
    return ip;
}


#pragma 对冲交易
- (TradeResult_HedgeCFD *)doHedgeCFDTrade:(IP_TRADESERV5102 *)ip {
    [ip setSignature:[CertificateUtil getPkcs7sin:ip]];
    [ip setOriSignature:[ip toString]];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult_HedgeCFD *result = [[TradeResult_HedgeCFD alloc] init];
    if ([opFather isSuccessed]) {
        [result setResult:RESULT_SUCCEED];
        [result setOrderHis:[(OP_TRADESERV5102 *)opFather getOrderHis]];
    } else {
        if ([opFather getErrCode] == nil) {
            [result setErrCodeAndCreateResult:ERR_Unknown];
        } else {
            [result setErrCodeAndCreateResult:[opFather getErrCode]];
        }
        [result set_errMessage:[opFather getErrMessage]];
    }
    
    //    if ([result result] == RESULT_MD5DigestDontMatch) {
    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    //    }
//    [API_IDEventCaptain fireEventChanged:NAME_TRADERETURN eventData:opFather];
    return result;
}

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
                                              IFDStopPrice:(double)iFDStopPrice{
    IP_TRADESERV5103 *ip = [[IP_TRADESERV5103 alloc] init];
    [ip setAccountID:account];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setInstrument:instrument];
    [ip setBuySell:isBuyNotSell ? BUY : SELL];
    [ip setAmount:amount];
    [ip setType:ORDERTYPE_NORMAL];
    [ip setLimitPrice:limitPrice];
    [ip setOriStopprice:oriStopPrice];
    [ip setStopMoveGap:0];
    [ip setToOpenNew:toOpenNew];
    NSMutableString *toCloseticketsVec1 = [[NSMutableString alloc] init];
    for (int i = 0; i < [toCloseTickets count]; i++) {
        if (i != 0) {
            [toCloseticketsVec1 appendString:@";"];
        }
        [toCloseticketsVec1 appendString:[toCloseTickets objectAtIndex:i]];
    }
    [ip setToCloseTickets:toCloseticketsVec1];
    [ip setExpireType:expiryType];
    [ip setExpireTime:expireTime];
    [ip setIFDLimitPrice:iFDLimitPrice];
    [ip setIFDStopPrice:iFDStopPrice];
    [ip setAccountDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:account]];
    return ip;
}

#pragma 委托下单
- (TradeResult_OrderCFD *)doOpenNormalOrderCFDTrade:(IP_TRADESERV5103 *)ip {
    [ip setSignature:[CertificateUtil getPkcs7sin:ip]];
    [ip setOriSignature:[ip toString]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult_OrderCFD *result = [[TradeResult_OrderCFD alloc] init];
    if ([opfather isSuccessed]){
        [result setResult:RESULT_SUCCEED];
        [result setOrder:[(OP_TRADESERV5103 *)opfather getOrder]];
    } else {
        if ([opfather getErrCode] == nil) {
            [result setErrCodeAndCreateResult:ERR_Unknown];
        } else {
            [result setErrCodeAndCreateResult:[opfather getErrCode]];
        }
        [result set_errMessage:[opfather getErrMessage]];
    }
    //    if ([result result] == RESULT_MD5DigestDontMatch) {
    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    //    }
//    [API_IDEventCaptain fireEventChanged:NAME_TRADERETURN eventData:opfather];
    return result;
}

- (IP_TRADESERV5103 *)createOpen_Close_1_FIXED_TRADE_ORDER_CFDTradeAccount:(long long)account
                                                                instrument:(NSString *)instrument
                                                              isBuyNotSell:(Boolean)isBuyNotSell
                                                                limitPrice:(double)limitPrice
                                                              oriStopPrice:(double)oriStopPrice
                                                               stopMoveGap:(int)stopMoveGap
                                                             toCloseTicket:(long long)toCloseTicket
                                                                expiryType:(int)expiryType
                                                                expireTime:(NSString *)expireTime{
    IP_TRADESERV5103 *ip = [[IP_TRADESERV5103 alloc] init];
    [ip setAccountID:account];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setInstrument:instrument];
    [ip setBuySell:isBuyNotSell ? BUY : SELL];
    [ip setType:ORDERTYPE_CLOSE_1_FIXED_TRADE_ORDER];
    [ip setLimitPrice:limitPrice];
    [ip setOriStopprice:oriStopPrice];
    [ip setStopMoveGap:stopMoveGap];
    [ip setToOpenNew:false];
    [ip setToCloseTickets:[@(toCloseTicket) stringValue]];
    [ip setExpireType:expiryType];
    [ip setExpireTime:expireTime];
    [ip setAccountDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:account]];
    TTrade *trade = [[APIDoc getUserDocCaptain] getTrade:toCloseTicket];
    [ip setAmount:[trade getAmount]];
    return ip;
}

- (TradeResult_OrderCFD *)doOpen_CLOSE_1_FIXED_TRADE_ORDER_CFDTrade:(IP_TRADESERV5103 *)ip {
    [ip setSignature:[CertificateUtil getPkcs7sin:ip]];
    [ip setOriSignature:[ip toString]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult_OrderCFD *result = [[TradeResult_OrderCFD alloc] init];
    
    if ([opfather isSuccessed]) {
        [result setResult:RESULT_SUCCEED];
        [result setOrder:[(OP_TRADESERV5103 *)opfather getOrder]];
    } else {
        if ([opfather getErrCode] == nil) {
            [result setErrCodeAndCreateResult:ERR_Unknown];
        } else {
            [result setErrCodeAndCreateResult:[opfather getErrCode]];
        }
        [result set_errMessage:[opfather getErrMessage]];
    }
    
    //    if ([result result] == RESULT_MD5DigestDontMatch) {
    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    //    }
    
//    [API_IDEventCaptain fireEventChanged:NAME_TRADERETURN eventData:opfather];
    return result;
}


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
                                  IFDStopPrice:(double)iFDStopPrice{
    IP_TRADESERV5104 *ip = [[IP_TRADESERV5104 alloc] init];
    [ip setAccountID:account];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setOrderID:orderID];
    [ip setAmount:amount];
    [ip setStopMoveGap:stopMoveGap];
    [ip setLimitPrice:limitPrice];
    [ip setOriStopprice:oriStopPrice];
    [ip setExpireType:expiryType];
    [ip setExpireTime:expiryTime];
    [ip setIFDLimitPrice:iFDLimitPrice];
    [ip setIFDStopPrice:iFDStopPrice];
    [ip setAccountDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:account]];
    return ip;
}


#pragma 修改委托单
- (TradeResult_OrderCFD *)doModifyOrder:(IP_TRADESERV5104 *)ip{
    [ip setSignature:[CertificateUtil getPkcs7sin:ip]];
    [ip setOriSignature:[ip toString]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult_OrderCFD *result = [[TradeResult_OrderCFD alloc] init];
    
    if ([opfather isSuccessed]) {
        [result setResult:RESULT_SUCCEED];
        [result setOrder:[(OP_TRADESERV5104 *)opfather getOrder]];
    } else {
        if ([opfather getErrCode] == nil) {
            [result setErrCodeAndCreateResult:ERR_Unknown];
        } else {
            [result setErrCodeAndCreateResult:[opfather getErrCode]];
        }
        [result set_errMessage:[opfather getErrMessage]];
    }
    
    //    if ([result result] == RESULT_MD5DigestDontMatch) {
    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    //    }
    
//    [API_IDEventCaptain fireEventChanged:NAME_TRADERETURN eventData:opfather];
    return result;
}


#pragma 删除委托单
- (IP_TRADESERV5105 *)createDeleteOrderTradeAccount:(long long)account
                                            orderID:(long long)orderID{
    IP_TRADESERV5105 *ip = [[IP_TRADESERV5105 alloc] init];
    [ip setAccountID:account];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setOrderID:orderID];
    [ip setAccountDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:account]];
    return ip;
}


#pragma 删除委托单
- (TradeResult *)doDeleteOrderTrade:(IP_TRADESERV5105 *)ip {
    [ip setSignature:[CertificateUtil getPkcs7sin:ip]];
    [ip setOriSignature:[ip toString]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
//    [API_IDEventCaptain fireEventChanged:NAME_TRADERETURN eventData:opfather];
    
    TradeResult *result = [[TradeResult alloc] init];
    [result setSucceed:[opfather isSuccessed]];
    [result setErrCode:[opfather getErrCode]];
    [result setErrMessage:[opfather getErrMessage]];
    //    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    return result;
}

#pragma 修改用户密码
- (int)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword{
    IP_Ctrl4001 *ip = [[IP_Ctrl4001 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setOldPswd:[ClientAPI encryptAllone:oldPassword key:[[ClientAPI getInstance] aeid]]];
    [ip setNewPswd:[ClientAPI encryptAllone:newPassword key:[[ClientAPI getInstance] aeid]]];
    
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return USERIDENTIFY_RESULT_ERR_UNKNOW;
    }
    OP_Ctrl4001 *op = (OP_Ctrl4001 *) opfather;
    int result = [op getResult];
    if (result == USERIDENTIFY_RESULT_SUCCEED) {
        [[ClientAPI getInstance] resetPassword:[ip getNewPswd]];
    }
    return result;
}

#pragma 修改phonepin
- (int)changePhonePinAccount:(long long)account
                 oldPhonePin:(NSString *)oldPhonePin
                 newPhonePin:(NSString *)newPhonePin{
    IP_Ctrl4002 *ip = [[IP_Ctrl4002 alloc] init];
    [ip setAccount:account];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setOldPhonePin:[ClientAPI encryptAllone:oldPhonePin key:[@(account) stringValue]]];
    [ip setNewPhonePin:[ClientAPI encryptAllone:newPhonePin key:[@(account) stringValue]]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return USERIDENTIFY_RESULT_ERR_UNKNOW;
    }
    OP_Ctrl4002 *op = (OP_Ctrl4002*) opfather;
    int result = [op getCheckType];
    if (result == USERIDENTIFY_RESULT_SUCCEED) {
        // ClientAPI.getInstance().resetPassword(ip.getNewPswd());
    }
    return result;
}

#pragma 修改使用者代号
- (TradeResult *)changeUserName:(NSString *)userName{
    IP_Ctrl4003 *ip = [[IP_Ctrl4003 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setUserId:userName];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult *result = [[TradeResult alloc] init];
    [result setSucceed:[opfather isSuccessed]];
    [result setErrCode:[opfather getErrCode]];
    [result setErrMessage:[opfather getErrMessage]];
    return result;
}

#pragma 修改移动止损
- (TradeResult *)changeStopMoveAccount:(long long)account
                               orderID:(long long)orderID
                               moveGap:(int)moveGap{
    IP_TRADESERV5108 *ip = [[IP_TRADESERV5108 alloc] init];
    [ip setAccountID:account];
    [ip setOrderID:orderID];
    [ip setStopMove:moveGap];
    
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    TradeResult *result = [[TradeResult alloc] init];
    [result setSucceed:[opfather isSuccessed]];
    [result setErrCode:[opfather getErrCode]];
    [result setErrMessage:[opfather getErrMessage]];
    return result;
}

#pragma 发送消息
- (Boolean)sendMessage:(NSString *)title
               context:(NSString *)context{
    IP_TRADESERV5115 *ip = [[IP_TRADESERV5115 alloc] init];
    [ip setTitle:title];
    [ip setContext:context];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    return [opfather isSuccessed];
}

#pragma 验证帐号
- (Boolean)checkAccount:(long long)accountID{
    IP_TRADESERV5046 *ip = [[IP_TRADESERV5046 alloc] init];
    [ip setAccountID:accountID];
    [ip setDigist:[[APIDoc getAccountDigestUtil] getAccountDigest:accountID]];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if ([opfather isSuccessed]) {
        OP_TRADESERV5046 *op = (OP_TRADESERV5046 *) opfather;
        return [op getResult];
    } else {
        @throw [[NSException alloc] initWithName:@"TradeAPI" reason:[opfather getErrCode] userInfo:nil];
    }
}

#pragma 保證金通知
- (NSArray *)getMarginCallAccount:(long long)accountID{
    IP_TRADESERV5023 *ip = [[IP_TRADESERV5023 alloc] init];
    [ip setAccountID:accountID];
    [ip setQueryType:QUERYTYPE_BY_ACCOUNT];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if ([opfather isSuccessed]) {
        OP_TRADESERV5023 *op = (OP_TRADESERV5023*) opfather;
        return [op getMarginCallVec];
    } else {
        return nil;
    }
}

#pragma 確認保證金通告
- (Boolean)confirmMarginCallAccount:(long long)accountID
                           tradeDay:(NSString *)tradeDay
                              level:(int)level
                           subLevel:(int)subLevel{
    IP_TRADESERV5117 *ip = [[IP_TRADESERV5117 alloc] init];
    [ip setAccount:accountID];
    [ip setTradeDay:tradeDay];
    [ip setLevel:level];
    [ip setSubLevel:subLevel];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    return [opfather isSuccessed];
}

#pragma 获取历史数据
- (NSArray *)queryHisData:(NSString *)instrument
                    cycle:(int)cycle{
    IP_QDB1002 *ip = [[IP_QDB1002 alloc] init];
    [ip setCycle:cycle];
    [ip setInstrument:instrument];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_QDB1002 *op = (OP_QDB1002*) opfather;
    return [op getHisDatas];
}

#pragma  获取更多的历史数据
- (NSArray *)queryHisData:(NSString *)instrument
                    cycle:(int)cycle
                  endTime:(long long)endTime{
    IP_QDB1003 *ip = [[IP_QDB1003 alloc] init];
    [ip setCycle:cycle];
    [ip setInstrument:instrument];
    [ip setEndTime:endTime];
    [ip setLimit:600];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_QDB1003 *op = (OP_QDB1003*) opfather;
    return [op getHisDatas];
}

- (NSArray *)queryShortTikHisData:(NSString *)instrument{
    return [self queryTikHisData:instrument number:100];
}

- (NSArray *)queryTikHisData:(NSString *)instrument{
    return [self queryTikHisData:instrument number:600];
}

- (NSArray *)queryTikHisData:(NSString *)instrument
                      number:(int)number{
    IP_QDB1004 *ip = [[IP_QDB1004 alloc] init];
    [ip setLimit:number];
    [ip setInstrument:instrument];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_QDB1004 *op = (OP_QDB1004 *) opfather;
    return [op getList];
}

#pragma 查询消息
- (NSArray *)queryMessages{
    IP_TRADESERV5061 *ip = [[IP_TRADESERV5061 alloc] init];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_TRADESERV5061 *op = (OP_TRADESERV5061 *) opfather;
    return [op getMessages];
}

#pragma 通过消息的guid获取消息详情
- (MessageToAccount *)queryMessage:(NSString *)messageGuid{
    IP_TRADESERV5062 *ip = [[IP_TRADESERV5062 alloc] init];
    [ip setMessageGuid:messageGuid];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_TRADESERV5062 *op = (OP_TRADESERV5062 *) opfather;
    return [op getMessage];
}

#pragma 发起取款
- (Boolean)sendWithdrawApplicationPassword:(NSString *)password
                               application:(WithDrawApplication *)application{
    IP_TRADESERV5116 *ip = [[IP_TRADESERV5116 alloc] init];
    [ip setPassword:password];
    [ip setWithDrawApplication:application];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return false;
    } else {
        return true;
    }
}

- (Boolean)hasQuoteBeenRequired:(NSString *)instrument{
    return [quoteNameArray containsObject:instrument];
}

#pragma 获取凭证URL
- (TradeResult_CAURL *)getCAURLAccount:(long long)account
                                  aeid:(NSString *)aeid{
    TradeResult_CAURL *result = [[TradeResult_CAURL alloc] init];
    IP_TRADESERV5065 *ip = [[IP_TRADESERV5065 alloc] init];
    
    [ip setAccount:account];
    [ip setAeid:aeid];
    OPFather *oop = [[CSTSCaptain getInstance ]trade:ip];
    [result setSucceed:[oop isSuccessed]];
    [result set_errCode:[oop getErrCode]];
    [result set_errMessage:[oop getErrMessage]];
    
    if ([oop isSuccessed]) {
        OP_TRADESERV5065 *op = (OP_TRADESERV5065*) oop;
        [result setCaURL:[op getCaURL]];
    }
    return result;
}

// ------------------------------------------------------------------------------
// ---------------------------报表-------------------------------------------------
// -------------------------------------------------------------------------------
#pragma 报表
- (NSArray *)queryTSettledAccount:(long long)account
                          fromDay:(NSString *)fromDay
                           endDay:(NSString *)endDay{
    IP_TDB1016 *ip = [[IP_TDB1016 alloc] init];
    [ip setConditionType:TDB1016_TYPE_ACCOUNT];
    [ip setAccount:account];
    [ip setTimeRagType:RAG_TYPE_CLOSETRADEDAY];
    [ip setFromDay:fromDay];
    [ip setEndDay:endDay];
    OPFather *opfather = [[CSTSCaptain getInstance ] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_TDB1016 *op = (OP_TDB1016 *) opfather;
    return [op getTSettled];
}

#pragma 挂单历史
- (TradeResult_SimpleReport *)report_TOrderHisDetails_Account:(NSDate *)fromTime
                                                      endTime:(NSDate *)endTime
                                                      account:(long long)account{
    IP_REPORT2007 *rip = [[IP_REPORT2007 alloc] init];
    [rip setType:Report2007_TYPE_ACCOUNT];
    [rip setAccount:account];
    [rip setFromTime:fromTime];
    [rip setEndTime:endTime];
    OPFather *oop = [[CSTSCaptain getInstance ] trade:rip];
    TradeResult_SimpleReport *result = [[TradeResult_SimpleReport alloc] init];
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    if ([oop isSuccessed]) {
        OP_REPORT2007 *rop = (OP_REPORT2007 *) oop;
        [result setReportList:[[NSMutableArray alloc] initWithArray:[rop getOrderHisDetails]]];
    }
    return result;
}

#pragma 查询保证金历史
- (TradeResult_SimpleReport *)report_AccountStreamDetails:(NSDate *)fromTime
                                                  endDate:(NSDate *)endTime
                                                  typeVec:(NSArray *)typeVec {
    IP_REPORT2011 *rip = [[IP_REPORT2011 alloc] init];
    [rip setType:IP_REPORT2011_TYPE_ACCOUNT];
    [rip setAccount:[[ClientAPI getInstance] accountID]];
    [rip setFromTime:fromTime];
    [rip setEndTime:endTime];
    [rip setTypeVec:typeVec];
    OPFather *oop = [[CSTSCaptain getInstance ] trade:rip];
    TradeResult_SimpleReport *result = [[TradeResult_SimpleReport alloc] init];
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    if ([oop isSuccessed]) {
        OP_REPORT2011 *rop = (OP_REPORT2011 *) oop;
        NSMutableArray *messageArray = [[NSMutableArray alloc] init];
        for (AccountStreamDetails *account in [rop getDataList]) {
            [messageArray addObject:account];
        }
        [result setReportList:messageArray];
    }
    return result;
}


#pragma 平仓历史
- (TradeResult_SimpleReport *)report_ClosedPositionsDetails_Account:(NSDate *)fromTime
                                                            endTime:(NSDate *)endTime
                                                            account:(long long)account{
    IP_REPORT2001 *rip = [[IP_REPORT2001 alloc] init];
    [rip setType:Report2001_TYPE_ACCOUNT];
    [rip setAccount:account];
    [rip setFromTime:fromTime];
    [rip setEndTime:endTime];
    OPFather *oop = [[CSTSCaptain getInstance ] trade:rip];
    TradeResult_SimpleReport *result = [[TradeResult_SimpleReport alloc] init];
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    if ([oop isSuccessed]) {
        OP_REPORT2001 *rop = (OP_REPORT2001 *) oop;
        [result setReportList:[[NSMutableArray alloc] initWithArray:[rop getClosePosList]]];
    }
    return result;
}


- (TradeResult_SimpleReport *)report_MessageToAccount:(NSString *)aeid{
    IP_REPORT2023 *rip = [[IP_REPORT2023 alloc] init];
    [rip setType:R_TYPE_AEID];
    [rip setIsClient:true];
    [rip setAeid:aeid];
    OPFather *oop = [[CSTSCaptain getInstance] trade:rip];
    TradeResult_SimpleReport *result = [[TradeResult_SimpleReport alloc] init];
    
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    if ([oop isSuccessed]) {
        OP_REPORT2023 *rop = (OP_REPORT2023 *) oop;
        [result setReportList:[[NSMutableArray alloc] initWithArray:[rop getDataList]]];
    }
    return result;
}

- (TradeResult_SimpleReport *)report_PushFromSystemAll:(NSString *)aeid {
    IP_REPORT6102 *ip = [[IP_REPORT6102 alloc] init];
    [ip setAeid:aeid];
    OPFather *oop = [[CSTSCaptain getInstance] trade:ip];
    TradeResult_SimpleReport *result = [[TradeResult_SimpleReport alloc] init];
    
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    if ([oop isSuccessed]) {
        OP_REPORT6102 *op = (OP_REPORT6102 *) oop;
        [result setReportList:[[NSMutableArray alloc] initWithArray:[op getDataList]]];
    }
    return result;
}

- (void)readPushMessage:(NSString *)aeid guid:(NSString *)guid {
    IP_TRADESERV6103 *ip = [[IP_TRADESERV6103 alloc] init];
    [ip setAeid:aeid];
    [ip setGUID:guid];
    OPFather *oop = [[CSTSCaptain getInstance] trade:ip];
}

#pragma 查询价格预警
- (NSArray *)queryPriceWarning{
    IP_TRADESERV5026 *ip = [[IP_TRADESERV5026 alloc] init];
    [ip setIsClientNeed:true];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return [[NSArray alloc] init];
    }
    OP_TRADESERV5026 *op = (OP_TRADESERV5026 *) opfather;
    return [op getPriceWarningVec];
}

#pragma 查询价格预警(未读)
- (NSArray *)queryPriceWarning4NoRead{
    
    IP_TRADESERV5026 *ip = [[IP_TRADESERV5026 alloc] init];
    [ip setIsPriceReach:PRICE_REACH_STATE_REACHED];
    [ip setIsRead:FALSE];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return [[NSArray alloc] init];
    }
    OP_TRADESERV5026 *op = (OP_TRADESERV5026 *) opfather;
    return [op getPriceWarningVec];
    
}

#pragma 查询价格预警(时间段)
- (NSArray *)queryPriceWarningFromTime:(NSDate *)fromTime
                               endTime:(NSDate *)endTime{
    IP_TRADESERV5026 *ip = [[IP_TRADESERV5026 alloc] init];
    
    //    NSLog(@"%d", [ip getConditionType]);
    //    [ip setPriceType:2];
    //    [ip setFromTime:fromTime];
    //    [ip setEndTime:endTime];
    [ip setIsClientNeed:true];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return [[NSArray alloc] init];
    }
    OP_TRADESERV5026 *op = (OP_TRADESERV5026*) opfather;
    return [op getPriceWarningVec];
}

#pragma 增加价格预警
- (PriceWarning *)addPriceWarningAccount:(long long)account
                              instrument:(NSString *)instrument
                                   price:(double)price
                               priceType:(int)priceType
                              expiryType:(int)expiryType
                              expiryTime:(NSDate *)expiryTime{
    IP_TRADESERV5109 *ip = [[IP_TRADESERV5109 alloc] init];
    [ip setOperateType:OPERATETYPE_ADD];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    
    PriceWarning *pw = [[PriceWarning alloc] init];
    [pw setExpiryType:expiryType];
    [pw setExpiryTime:expiryTime];
    [pw setAccount:account];
    [pw setInstrument:instrument];
    [pw setPrice:price];
    [pw setPriceType:priceType];
    [ip setToAddPW:pw];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_TRADESERV5109 *op = (OP_TRADESERV5109 *) opfather;
    return [op getAddPriceWarning];
}

- (PriceWarning *)modPriceWarning:(NSString *)guid
                            price:(double)price
                       expiryType:(int)expiryType
                       expiryTime:(NSDate *)expiryTime{
    IP_TRADESERV5109 *ip = [[IP_TRADESERV5109 alloc] init];
    [ip setOperateType:OPERATETYPE_MODIFY];
    [ip setToDeletePWGUID:guid];
    [ip setExpiryType:expiryType];
    [ip setExpiryTime:expiryTime];
    [ip setPrice:price];
    OPFather *opfather = [[CSTSCaptain getInstance]trade:ip];
    if (![opfather isSuccessed]) {
        return nil;
    }
    OP_TRADESERV5109 *op = (OP_TRADESERV5109 *) opfather;
    return [op getAddPriceWarning];
}

- (TradeResult *)deletePriceWarning:(NSString *)guid{
    IP_TRADESERV5109 *ip = [[IP_TRADESERV5109 alloc] init];
    [ip setOperateType:OPERATETYPE_DELETE];
    [ip setToDeletePWGUID:guid];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    
    TradeResult *result = [[TradeResult alloc] init];
    [result setSucceed:[opfather isSuccessed]];
    [result setErrCode:[opfather getErrCode]];
    [result setErrMessage:[opfather getErrMessage]];
    //    [[DocOperator getInstance] loadAccountData:[ip getAccountID]];
    return result;
}

- (void)readPriceWarning:(NSString *)guid{
    IP_TRADESERV5109 *ip = [[IP_TRADESERV5109 alloc] init];
    [ip setOperateType:OPERATETYPE_READ];
    [ip setToDeletePWGUID:guid];
    [[CSTSCaptain getInstance] trade:ip];
}


#pragma CA 凭证管理

- (int)checkAccount:(long long)account
           phonePin:(NSString *)phonePin {
    IP_Ctrl4004 *ip = [[IP_Ctrl4004 alloc] init];
    [ip setPhonePin:[ClientAPI encryptAllone:phonePin key:[@(account) stringValue]]];
    [ip setAccount:account];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl4004 *op = (OP_Ctrl4004 *)opFather;
        return [op getCheckType];
    }
    return USERIDENTIFY_RESULT_ERR_NETERR;
}


/**
 *  取得目前可用的功能、状态以及CSRF 金鑰長度
 *
 *  @param deviceID
 *  @param venderID
 *
 *  @return TradeResult_CAFnStatus
 */
- (TradeResult_CAFnStatus *)getFnStatus2DeviceID:(NSString *)deviceID
                                        venderID:(NSString *)venderID {
    TradeResult_CAFnStatus *result = [[TradeResult_CAFnStatus alloc] init];
    IP_Ctrl5101 *ip = [[IP_Ctrl5101 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5101 *op = (OP_Ctrl5101 *)opFather;
        [result setSucceed:true];
        [result setFnStatus:[op getFnStatus]];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

/**
 *  憑證申請
 *
 *  @param deviceID 裝置ID
 *  @param venderID 軟件廠商APP代碼
 *  @param password 憑證申請密碼
 *  @param csr      憑證用戶ID
 *
 *  @return TradeResult_CACert
 */
- (TradeResult_CACert *)requestApplyCertDeviceID:(NSString *)deviceID
                                        venderID:(NSString *)venderID
                                        password:(NSString *)password
                                             csr:(NSString *)csr {
    TradeResult_CACert *result = [[TradeResult_CACert alloc] init];
    IP_Ctrl5102 *ip = [[IP_Ctrl5102 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    [ip setPassword:password];
    [ip setCsr:csr];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5102 *op = (OP_Ctrl5102 *)opFather;
        [result setSucceed:true];
        [result setResultCode:[op getReturnCode]];
        [result setContext:[op getPreviousCA]];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

/**
 *  更新憑證　(ReNewCert)：呼叫此API前需驗章成功 ID: 憑證用戶證件號碼(身分證字號、統一編號、統一證號)
 *                    DeviceType：裝置類別 DeviceID: 裝置 ID (行動裝置 IMEI Code+ App
 *                    安裝時之時間序) VenderId:軟體/廠商/APP 代碼 CSR:依憑證用戶 ID, 裝置類別及裝置
 *                    ID產生 CSR 值(請先 URL ENCODE)，如以GetFnStatus
 *                    取得目前可用功能及操作狀態之回傳值第 2 個字元為「2」時，此項參數值應為空字串。 SIGN:空值
 *                    CERTSN：空值
 *
 *  @param deviceID
 *  @param venderID
 *  @param password
 *  @param csr
 *
 *  @return TradeResult_CACert
 */
- (TradeResult_CACert *)updateReNewCertDeviceID:(NSString *)deviceID
                                       venderID:(NSString *)venderID
                                       password:(NSString *)password
                                            csr:(NSString *)csr {
    TradeResult_CACert *result = [[TradeResult_CACert alloc] init];
    IP_Ctrl5103 *ip = [[IP_Ctrl5103 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    [ip setPassword:password];
    [ip setCsr:csr];
    [ip setSign:nil];
    [ip setCertsn:nil];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5103 *op = (OP_Ctrl5103 *)opFather;
        [result setSucceed:true];
        [result setResultCode:[op getReturnCode]];
        [result setContext:[op getPreviousCA]];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

/**
 *  回報憑證安裝完成　(CertInstallComplete)
 *
 *  @param deviceID
 *  @param venderID
 *
 *  @return TradeResult_CACert
 */
- (TradeResult_CACert *)certInstallCompleteDevice:(NSString *)deviceID
                                         venderID:(NSString *)venderID {
    TradeResult_CACert *result = [[TradeResult_CACert alloc] init];
    IP_Ctrl5104 *ip = [[IP_Ctrl5104 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5104 *op = (OP_Ctrl5104 *)opFather;
        [result setSucceed:true];
        [result setResultCode:[op getReturnCode]];
        [result setContext:[op getReturnMessage]];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

/**
 *  取得憑證　(GetCert)
 *
 *  @param deviceID
 *  @param venderID
 *
 *  @return TradeResult_CACert
 */
- (TradeResult_CACert *)getCertDeviceID:(NSString *)deviceID
                               venderID:(NSString *)venderID{
    TradeResult_CACert *result = [[TradeResult_CACert alloc] init];
    IP_Ctrl5105 *ip = [[IP_Ctrl5105 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5105 *op = (OP_Ctrl5105 *)opFather;
        [result setSucceed:true];
        [result setResultCode:[op getReturnCode]];
        NSString *preCa = [op getPreviousCA];
        NSString *replaceString = [[preCa stringByReplacingOccurrencesOfString:@"-----BEGIN CERTIFICATE-----" withString:@""]
                                   stringByReplacingOccurrencesOfString:@"-----END CERTIFICATE-----" withString:@""];
        [result setContext:replaceString];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

/**
 *  取得憑證狀態　(GetCertState)
 *
 *  @param deviceID
 *  @param venderID
 *
 *  @return TradeResult_CACertState
 */
- (TradeResult_CACertState *)getCertStateDeviceID:(NSString *)deviceID
                                         venderID:(NSString *)venderID {
    TradeResult_CACertState *result = [[TradeResult_CACertState alloc] init];
    IP_Ctrl5106 *ip = [[IP_Ctrl5106 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    [ip setSerial:nil];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5106 *op = (OP_Ctrl5106 *)opFather;
        [result setSucceed:true];
        [result setResultCode:[op getReturnCode]];
        [result setState:[op getState]];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

/**
 *  取得憑證　(QueryCert) ID: 憑證用戶證件號碼(身分證字號、統一編號、統一證號)
 *                    DeviceType：裝置類別 DeviceID: 裝置 ID (行動裝置 IMEI Code+ App
 *                    安裝時之時間序) VenderId:軟體/廠商/APP 代碼 serial: 憑證序號(十六進位)
 *
 *  @param deviceID
 *  @param venderID
 *  @param certSerial
 *
 *  @return TradeResult_CAQueryCert
 */
- (TradeResult_CAQueryCert *)queryCertDeviceID:(NSString *)deviceID
                                      venderID:(NSString *)venderID
                                    certSerial:(NSString *)certSerial {
    TradeResult_CAQueryCert *result = [[TradeResult_CAQueryCert alloc] init];
    IP_Ctrl5107 *ip = [[IP_Ctrl5107 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    [ip setDeviceType:IP];
    [ip setDeviceID:deviceID];
    [ip setVenderID:venderID];
    [ip setSerial:certSerial];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        OP_Ctrl5107 *op = (OP_Ctrl5107 *)opFather;
        [result setSucceed:true];
        [result setFnCertState:[op getFnCertStatus]];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

- (TradeResult *)setDeviceTokenAeid:(NSString *)aeid
                          accountID:(NSString *)accountID
                          groupName:(NSString *)groupName
                        deviceToken:(NSString *)deviceToken
                         deviceType:(int)deviceType {
    TradeResult *result = [[TradeResult alloc] init];
    IP_Ctrl5201 *ip = [[IP_Ctrl5201 alloc] init];
    [ip setAeid:aeid];
    [ip setAccountID:accountID];
    [ip setGroupName:groupName];
    [ip setDeviceToken:deviceToken];
    [ip setDeviceType:deviceType];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        [result setSucceed:true];
    } else {
        [result setSucceed:false];
        [result setErrCode:[opFather getErrCode]];
        [result setErrMessage:[opFather getErrMessage]];
    }
    return result;
}

- (Boolean)updateCADownloadTimer {
    IP_TRADESERV6101 *ip = [[IP_TRADESERV6101 alloc] init];
    [ip setAeid:[[ClientAPI getInstance] aeid]];
    OPFather *opFather = [[CSTSCaptain getInstance] trade:ip];
    if ([opFather isSuccessed]) {
        [[UserDocOperator getInstance] loadUserLogin:[[ClientAPI getInstance] aeid]];
    }
    return [opFather isSuccessed];
}

#pragma queryEconomicData
- (TradeResult_SimpleList *)queryEconomicDatas {
    TradeResult_SimpleList *result = [[TradeResult_SimpleList alloc] init];
    IP_TRADESERV1901 *ip = [[IP_TRADESERV1901 alloc] init];
    OPFather *oop = [[CSTSCaptain getInstance] trade:ip];
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    if ([oop isSuccessed]) {
        OP_TRADESERV1901 *op = (OP_TRADESERV1901 *)oop;
        [result setDataList:[op getEconomicDatas]];
    }
    return result;
}

#pragma saveOptRecords
- (TradeResult *)saveOptRecords:(NSArray *)optRecord {
    TradeResult *result = [[TradeResult alloc] init];
    IP_TRADESERV1904 *ip = [[IP_TRADESERV1904 alloc] init];
    [ip setOperationRecords:optRecord];
    OPFather *oop = [[CSTSCaptain getInstance] trade:ip];
    [result setSucceed:[oop isSuccessed]];
    [result setErrCode:[oop getErrCode]];
    [result setErrMessage:[oop getErrMessage]];
    return result;
}

@end
