//
//  TradeActionUtil.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TradeActionUtil.h"
#import "APIDoc.h"
#import "ToOpenTradeNode.h"
#import "MTP4CommDataInterface.h"

#import "TradeApi.h"
#import "ClientAPI.h"

#import "ShowAlertManager.h"

#import "LangCaptain.h"
#import "LayoutCenter.h"

#import "JumpDataCenter.h"
#import "AccountUtil.h"
#import "QuoteDataStore.h"
#import "DecimalUtil.h"
#import "IosLogic.h"

#import "CertificateManager.h"
#import "CertificateUtil.h"

#import "PhonePinChecker.h"

#import "MarketTradeView.h"
#import "OrderPositionView.h"
#import "OpenOrderPositionView.h"
#import "HedgingView.h"
#import "ClosePositionView.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

static TradeActionUtil *instance = nil;

static Boolean isNeedCheckCertificateState  = true;
static Boolean isNeedCheckPhonePin          = true;

typedef NS_ENUM(NSUInteger, TradeType) {
    TradeTypeAddOrderPosition       = 0,
    TradeTypeModifyOrderPosition    = 1,
    TradeTypeDeleteOrderPosition    = 2,
    TradeTypeAddOpenOrderPosition   = 3,
    TradeTypeModifyOpenOrderPosition= 4,
    TradeTypeDeleteOpenOrderPosition= 5,
    TradeTypeClosePosition          = 6,
    TradeTypePriceWarning           = 7,
};

@interface TradeActionUtil ()<CustomAlertDelegate> {
    //    UIView *mainView;
    TradeFunction _currenTradeFunction;
}

@end

@implementation TradeActionUtil

+ (TradeActionUtil *)getInstance {
    if (instance == nil) {
        instance = [[TradeActionUtil alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        _currenTradeFunction = Function_Trade_Unknow;
    }
    return self;
}

- (UIView *)getMainView {
    return [[[[IosLogic getInstance] uiWindow] rootViewController] view];
}

- (void)destroy {
    //    mainView = nil;
    instance = nil;
}

- (void)setCurrentFunctionTrade:(TradeFunction)function {
    _currenTradeFunction = function;
}

- (void)doTradeByFunction {
    switch (_currenTradeFunction) {
        case Function_Trade_Unknow:
            // do nothing
            break;
        case Function_Trade_MKT:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getMarketTradeView] doMKTTrade];
            break;
        case Function_Trade_Add_Order:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getAddOrderPositionView] doAddOrderTrade];
            break;
        case Function_Trade_Modify_Order:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getModifyOrderPositionView] doModifyOrderTrade];
            break;
        case Function_Trade_Delete_Order:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getModifyOrderPositionView] doDelete];
            break;
        case Function_Trade_Add_OpenOrder:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getOpenOrderPositionView] doAddOpenOrderTrade];
            break;
        case Function_Trade_Modify_OpenOrder:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getOpenOrderPositionView] doModifyOpenOrderTrade];
            break;
        case Function_Trade_Delete_OpenOrder:
            [[[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] getOpenOrderPositionView] doDelete];
            break;
        case Function_Trade_Hedging:
            [[[[LayoutCenter getInstance] backgroundLayoutCenter] getHedgingView] doTrade];
            break;
        case Function_Trade_ClosePosition:
            [[[[LayoutCenter getInstance] backgroundLayoutCenter] getClosePositionView] doTrade];
            break;
        default:
            break;
    }
}

- (Boolean)checkCertificate {
    if (isNeedCheckCertificateState) {
        return [[CertificateManager getInstance] checkCertificateState];
    }
    return true;
}

- (Boolean)checkPhonePinState {
    if (isNeedCheckPhonePin) {
        return [[PhonePinChecker getInstance] checkPhonePinByValidate];
    }
    return true;
}

#pragma 市價開倉
- (void)doMKTTradeInstrumentName:(NSString *)instrument
                       isBuySell:(Boolean)isBuySell
                          amount:(double)amount
                   priceSnapshot:(CDS_PriceSnapShot *)pss {
    
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_MKT;
        return;
    }
    
    Instrument *inst  = [[APIDoc getSystemDocCaptain] getInstrument:[pss instrumentName]];
    int digist = [inst getDigits];
    
    double price = isBuySell ? [pss getAsk] : [pss getBid];
    
    ToOpenTradeNode *node = [[ToOpenTradeNode alloc] init];
    [node setInstrumentName:instrument];
    [node setAmount:amount];
    [node setBuySell:isBuySell ? BUY : SELL];
    
    IP_TRADESERV5101 * ip = [[TradeApi getInstance] createMktCFDTradeIPAccount:[[ClientAPI getInstance] accountID]
                                                                instrumentName:instrument
                                                                  isBuyNotSell:isBuySell
                                                                        amount:amount
                                                                         price:price
                                                                   mktPirceGap:0
                                                             toCloseTradeNodes:[[NSArray alloc] init]
                                                               toOpenTradeNode:node
                                                                  IFDStopPrice:0.0f
                                                                 IFDLimitPrice:0.0f];
    
    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TradeResult_MktCFD *result = [[TradeApi getInstance] doMKTCFDTrade:ip];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            if ([result result] == RESULT_SUCCEED) {
                OpenSuccessStruct *openSuccessStruct = [[OpenSuccessStruct alloc] init];
                [openSuccessStruct setAccount:[NSString stringWithFormat:@"%@: %@", [[LangCaptain getInstance] getLangByCode:@"Account"], [AccountUtil getAccountID]]];
                
                [openSuccessStruct setInstrumentName:instrument];
                [openSuccessStruct setAmount:[DecimalUtil formatNumber:amount]];
                [openSuccessStruct setBuySell:isBuySell == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"]];
                
                if ([result orderHis] != nil) {
                    [openSuccessStruct setPrice:[DecimalUtil formatMoney:[[result orderHis] getLimitPrice] digist:digist]];
                    //                    NSDate *openTime = [[result orderHis] getOpenTime];
                    NSDate *openTime = [self getOpenTime:[result orderHis]];
                    [openSuccessStruct setTime:[JEDIDateTime stringUIFromDate:openTime]];
                } else {
                    [openSuccessStruct setPrice:[DecimalUtil formatMoney:price digist:digist]];
                    NSDate *openTime = [NSDate dateWithTimeIntervalSince1970:[pss snapshotTime] / 1000.0];
                    [openSuccessStruct setTime:[JEDIDateTime stringUIFromDate:openTime]];
                }
                
                [[JumpDataCenter getInstance] setOpenSuccessStruct:openSuccessStruct];
                
                [[JumpDataCenter getInstance] setOpenPositionTicket:[self getTicket:[result orderHis]]];
                [[JumpDataCenter getInstance] setOpenPositionInstrumentName:[ip getInstrumentName]];
                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OpenPosition];
                
                [[[LayoutCenter getInstance] backgroundLayoutCenter] showOpenSuccessView];
                
                
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_6];
                
            } else {
                NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]];
                [[JumpDataCenter getInstance] setOpenFailedMessage:errMsg];
                [[[LayoutCenter getInstance] backgroundLayoutCenter] showOpenFailedView];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_7];
            }
        });
    });
}

- (NSDate *)getOpenTime:(TOrderHis *)orderHis {
    if (orderHis == nil) {
        return nil;
    }
    long long ticketId = [self getTicket:orderHis];
    TTrade *trade = [[APIDoc getUserDocCaptain] getTrade:ticketId];
    return trade != nil ? [trade getOpenTime] : nil;
}

- (long long)getTicket:(TOrderHis *)orderHis {
    if (orderHis == nil) {
        return 0;
    }
    NSArray *ticketVec = [[orderHis getopenedTicket] componentsSeparatedByString:@"_"];
    if ([ticketVec count] > 0) {
        return [[ticketVec objectAtIndex:0] longLongValue];
    }
    return 0;
}


#pragma 新增掛單
- (void)doAddOrderTradeInstrument:(NSString *)instrument
                        isBuySell:(Boolean)isBuySell
                           amount:(double)amount
                       limitPrice:(double)limitPrice
                        stopPrice:(double)stopPrice
                       expiryType:(int)expiryType
                       expiryTime:(NSString *)expiryTime
                    IDTLimitPrice:(double)idtLimitPrice
                     IDTStopPrice:(double)idtStopPrice {
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Add_Order;
        return;
    }
    
    // 新建下单
    IP_TRADESERV5103 *ip = [[TradeApi getInstance] createOpenNormalOrderCFDTradeAccount:[[ClientAPI getInstance] accountID]
                                                                             instrument:instrument
                                                                           isBuyNotSell:isBuySell
                                                                                 amount:amount
                                                                             limitPrice:limitPrice
                                                                           oriStopPrice:stopPrice
                                                                              toOpenNew:true
                                                                         toCloseTickets:[[NSMutableArray alloc] init]
                                                                             expiryType:expiryType
                                                                            nexpireTime:expiryTime
                                                                          IFDLimitPrice:idtLimitPrice
                                                                           IFDStopPrice:idtStopPrice];
//        NSString *signature = [CertificateUtil getPkcs7sin:ip];
//    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_OrderCFD *orderResult = [[TradeApi getInstance] doOpenNormalOrderCFDTrade:ip];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            if ([orderResult result] == RESULT_SUCCEED) {
                [[JumpDataCenter getInstance] setAddNewOrderID:[[orderResult order] getOrderID]];
                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OrderPosition];
            }
            if ([orderResult result] == RESULT_SUCCEED) {
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_3];
            } else {
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_4];
            }
            [self dealWithOrderResult:orderResult withType:TradeTypeAddOrderPosition];
        });
    });
}

#pragma 修改掛單
- (void)doModifyOrderTradeInstrument:(NSString *)instrument
                           isBuySell:(Boolean)isBuySell
                             orderID:(long long)orderID
                              amount:(double)amount
                          limitPrice:(double)limitPrice
                           stopPrice:(double)stopPrice
                          expiryType:(int)expiryType
                          expiryTime:(NSString *)expiryTime
                       IDTLimitPrice:(double)idtLimitPrice
                        IDTStopPrice:(double)idtStopPrice {
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Modify_Order;
        return;
    }
    
    // 修改下单
    IP_TRADESERV5104 *ip = [[TradeApi getInstance] createModifyOrderAccount:[[ClientAPI getInstance] accountID]
                                                                    orderID:orderID
                                                                     amount:amount
                                                                stopMoveGap:INT32_MAX
                                                                 linutPirce:limitPrice
                                                               oriStopPrice:stopPrice
                                                                 expiryType:expiryType
                                                                 expiryTime:expiryTime
                                                              IFDLimitPrice:idtLimitPrice
                                                               IFDStopPrice:idtStopPrice];
    //    NSString *signature = [CertificateUtil getPkcs7sin:ip];
    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_OrderCFD *orderResult = [[TradeApi getInstance] doModifyOrder:ip];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            if ([orderResult result] == RESULT_SUCCEED) {
                [[JumpDataCenter getInstance] setAddNewOrderID:[[orderResult order] getOrderID]];
                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OrderPosition];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_3];
            } else {
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDER subType:APP_OPT_TYPE_ORDER_ITEM_4];
            }
            [self dealWithOrderResult:orderResult withType:TradeTypeModifyOrderPosition];
        });
    });
}

#pragma 刪除掛單
- (void)doDeleteOrder:(long long)orderID {
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Delete_Order;
        return;
    }
    
    IP_TRADESERV5105 *ip = [[TradeApi getInstance] createDeleteOrderTradeAccount:[[ClientAPI getInstance] accountID] orderID:orderID];
    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TradeResult *result = [[TradeApi getInstance] doDeleteOrderTrade:ip];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            if ([result succeed]) {
                [[JumpDataCenter getInstance] setAddNewOrderID:-1];
                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OrderPosition];
            }
            [self dealWithDeleteResult:result withType:TradeTypeDeleteOrderPosition];
        });
    });
}

#pragma 新增 開倉附掛單
- (void)doAddOpenOrderTradeInstrument:(NSString *)instrument
                            isBuySell:(Boolean)isBuySell
                           limitPrice:(double)limitPrice
                         oriStopPrice:(double)stopPrice
                          stopMoveGap:(int)stopMoveGap
                        toCloseTicket:(long long)closeTicket
                           expireType:(int)expireType
                           expireTime:(NSString *)expireTime {
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Add_OpenOrder;
        return;
    }
    
    IP_TRADESERV5103 *_ip5103 = [[TradeApi getInstance] createOpen_Close_1_FIXED_TRADE_ORDER_CFDTradeAccount:[[ClientAPI getInstance] accountID]
                                                                                                  instrument:instrument
                                                                                                isBuyNotSell:isBuySell
                                                                                                  limitPrice:limitPrice
                                                                                                oriStopPrice:stopPrice
                                                                                                 stopMoveGap:stopMoveGap
                                                                                               toCloseTicket:closeTicket
                                                                                                  expiryType:expireType
                                                                                                  expireTime:expireTime];
    
    NSString *signature = @"";
    // 获取CA签名
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_OrderCFD *result = [[TradeApi getInstance] doOpen_CLOSE_1_FIXED_TRADE_ORDER_CFDTrade:_ip5103];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            //            [[JumpDataCenter getInstance] setAddNewOrder:[result order]];
            //            if ([result result] == RESULT_SUCCEED) {
            //                [[JumpDataCenter getInstance] setAddOpenNewOrderID:[[result order] getOrderID]];
            //                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OpenPosition];
            //            }
            
            [self dealWithOrderResult:result withType:TradeTypeAddOpenOrderPosition];
        });
    });
}

#pragma 修改 開倉 附掛單
- (void)doModifyOpenOrderTradeOrderID:(long long)orderID
                               amount:(double)amount
                          stopMoveGap:(int)stopMoveGap
                           limitPrice:(double)limitPrice
                         oriStopPrice:(double)stopPrice
                           expireType:(int)expireType
                           expireTime:(NSString *)expireTime {
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Modify_OpenOrder;
        return;
    }
    
    IP_TRADESERV5104 *_ip5104 = [[TradeApi getInstance] createModifyOrderAccount:[[ClientAPI getInstance] accountID]
                                                                         orderID:orderID
                                                                          amount:amount
                                                                     stopMoveGap:stopMoveGap
                                                                      linutPirce:limitPrice
                                                                    oriStopPrice:stopPrice
                                                                      expiryType:expireType
                                                                      expiryTime:expireTime
                                                                   IFDLimitPrice:0
                                                                    IFDStopPrice:0];
    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_OrderCFD *result = [[TradeApi getInstance] doModifyOrder:_ip5104];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [self dealWithOrderResult:result withType:TradeTypeModifyOpenOrderPosition];
        });
    });
}

#pragma 刪除 開倉 附掛單
- (void)doDeleteOpenOrder:(long long)orderID {
    
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Delete_OpenOrder;
        return;
    }
    
    IP_TRADESERV5105 *_ip5105 = [[TradeApi getInstance] createDeleteOrderTradeAccount:[[ClientAPI getInstance] accountID]
                                                                              orderID:orderID];
    
    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult *result = [[TradeApi getInstance] doDeleteOrderTrade:_ip5105];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            //            if ([result succeed]) {
            //                [[JumpDataCenter getInstance] setAddOpenNewOrderID:-1];
            //                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OpenPosition];
            //            }
            
            [self dealWithDeleteResult:result withType:TradeTypeDeleteOpenOrderPosition];
        });
    });
}

#pragma 對衝
- (void)doHedgingTradeInstrument:(NSString *)instrument
              closeBuyTradeNodes:(NSArray *)buyTradeArray
             closeSellTradeNodes:(NSArray *)sellTradeArray {
    
    if (![self checkCertificate]) {
        return;
    }
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_Hedging;
        return;
    }
    
    IP_TRADESERV5102 *ip = [[TradeApi getInstance] createHedgeCFDTradeAccount:[[ClientAPI getInstance] accountID]
                                                                   instrument:instrument
                                                         toCloseBuyTradeNodes:buyTradeArray
                                                        toCloseSellTradeNodes:sellTradeArray];
        NSString *signature = [CertificateUtil getPkcs7sin:ip];
//    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_HedgeCFD *result = [[TradeApi getInstance] doHedgeCFDTrade:ip];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            if ([result result] == RESULT_SUCCEED) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                [array addObjectsFromArray:buyTradeArray];
                [array addObjectsFromArray:sellTradeArray];
                [[JumpDataCenter getInstance] setClosePositionHisTicketArray:array];
                //                [[JumpDataCenter getInstance] setClosePositionHisTicket:[[buyTradeArray objectAtIndex:0] getTicket]];
                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_ClosePositionHis];
                //                [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                //                                                                  andMessage:[[LangCaptain getInstance] getLangByCode:@"HedgingSuccess"]
                //                                                                    delegate:nil];
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SuccessNotice"]
                                                                   andMessage:[[LangCaptain getInstance] getLangByCode:@"HedgingSuccess"]
                                                                     delegate:self];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_6];
            } else {
                [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                  andMessage:[[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]]
                                                                    delegate:nil];
                [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_7];
            }
        });
        
    });
}

#pragma 平倉
- (void)doClosePositionInstrument:(NSString *)instrument
                     isBuyNotSell:(Boolean)isBuySell
                           amount:(double)amount
                            price:(double)price
                  closeTradeNodes:(NSArray *)closeTradeNodes {
    
    if (![self checkCertificate]) {
        return;
    }
    
    if (![self checkPhonePinState]) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showPhonePinView];
        _currenTradeFunction = Function_Trade_ClosePosition;
        return;
    }
    
    IP_TRADESERV5101 * ip = [[TradeApi getInstance] createMktCFDTradeIPAccount:[[ClientAPI getInstance] accountID]
                                                                instrumentName:instrument
                                                                  isBuyNotSell:!isBuySell
                                                                        amount:amount
                                                                         price:price
                                                                   mktPirceGap:0
                                                             toCloseTradeNodes:closeTradeNodes
                                                               toOpenTradeNode:nil
                                                                  IFDStopPrice:0.0f
                                                                 IFDLimitPrice:0.0f];
    //    NSString *signature = [CertificateUtil getPkcs7sin:ip];
    NSString *signature = @"";
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"]
                                                          onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TradeResult_MktCFD *result = [[TradeApi getInstance] doMKTCFDTrade:ip];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            
            if ([result result] == RESULT_SUCCEED) {
                [[JumpDataCenter getInstance] setOpenPositionInstrumentName:@"-1"];
                //                [[JumpDataCenter getInstance] setAddOpenNewOrderID:-1];
                //                [[JumpDataCenter getInstance] setClosePositionHisTicket:[[closeTradeNodes objectAtIndex:0] getTicket]];
                [[JumpDataCenter getInstance] setClosePositionHisTicketArray:closeTradeNodes];
                [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_ClosePositionHis];
            }
            
            [self dealWithMktResult:result withType:TradeTypeClosePosition];
        });
    });
}

#pragma 新增价格提示
- (void)doAddPriceWarningInstrument:(NSString *)instrument
                              price:(double)price
                          priceType:(int)priceType
                         expireType:(int)expireType
                         expireTime:(NSDate *)expireTime {
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        PriceWarning *priceWarning = [[TradeApi getInstance] addPriceWarningAccount:[[ClientAPI getInstance] accountID]
                                                                         instrument:instrument
                                                                              price:price
                                                                          priceType:priceType
                                                                         expiryType:expireType
                                                                         expiryTime:expireTime];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_PriceWarning];
            [self dealWithAddPriceWarning:priceWarning];
        });
    });
}

#pragma 修改价格提示
- (void)doModifyPriceWarningGuid:(NSString *)guid
                           price:(double)price
                      expireType:(int)expireType
                      expireTime:(NSDate *)expireTime {
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        PriceWarning *priceWarning = [[TradeApi getInstance] modPriceWarning:guid
                                                                       price:price
                                                                  expiryType:expireType
                                                                  expiryTime:expireTime];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_PriceWarning];
            [self dealWithModifyPriceWarning:priceWarning];
        });
    });
    
}

#pragma 删除价格提示
- (void)doDeletePriceWarningGuid:(NSString *)guid {
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsTrading"] onView:[self getMainView]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TradeResult *result = [[TradeApi getInstance] deletePriceWarning:guid];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_PriceWarning];
            [self dealWithDeleteResult:result withType:TradeTypePriceWarning];
        });
    });
}

// 目前只有 市價平倉在使用
- (void)dealWithMktResult:(TradeResult_MktCFD *)result withType:(TradeType)type{
    
    if ([result result] == RESULT_SUCCEED) {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getSuccessNoticeTitleWithType:type]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[self getSuccessMessageWithType:type]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultSuccessView];
        
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_3];
    } else {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getFailedNoticeTitleWithType:type]];
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]];
        [[JumpDataCenter getInstance] setTradeResultMessage:errMsg];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultFailedView];
        
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_4];
    }
}

- (void)dealWithOrderResult:(TradeResult_OrderCFD *)result withType:(TradeType)type{
    
    if ([result result] == RESULT_SUCCEED) {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getSuccessNoticeTitleWithType:type]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[self getSuccessMessageWithType:type]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultSuccessView];
       
    } else  {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getFailedNoticeTitleWithType:type]];
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result getErrCode]];
        [[JumpDataCenter getInstance] setTradeResultMessage:errMsg];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultFailedView];
    }
}

- (void)dealWithDeleteResult:(TradeResult *)result withType:(TradeType)type {
    
    if ([result succeed]) {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getSuccessNoticeTitleWithType:type]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[[LangCaptain getInstance] getLangByCode:@"DeleteSuccess"]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultSuccessView];
    } else  {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getFailedNoticeTitleWithType:type]];
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:[result errCode]];
        [[JumpDataCenter getInstance] setTradeResultMessage:errMsg];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultFailedView];
    }
}

- (void)dealWithAddPriceWarning:(PriceWarning *)priceWarning {
    
    if (priceWarning != nil) {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getSuccessNoticeTitleWithType:TradeTypePriceWarning]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[[LangCaptain getInstance] getLangByCode:@"AddPriceWarningSuccess"]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultSuccessView];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICEWARNING subType:APP_OPT_TYPE_PRICEWARNING_ITEM_1];
    } else  {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getFailedNoticeTitleWithType:TradeTypePriceWarning]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[[LangCaptain getInstance] getLangByCode:@"AddPriceWarningFailed"]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultFailedView];
    }
}

- (void)dealWithModifyPriceWarning:(PriceWarning *)priceWarning {
    if (priceWarning != nil) {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getSuccessNoticeTitleWithType:TradeTypePriceWarning]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[[LangCaptain getInstance] getLangByCode:@"ModifyPriceWarningSuccess"]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultSuccessView];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICEWARNING subType:APP_OPT_TYPE_PRICEWARNING_ITEM_1];
    } else  {
        [[JumpDataCenter getInstance] setTradeResultTitle:[self getFailedNoticeTitleWithType:TradeTypePriceWarning]];
        [[JumpDataCenter getInstance] setTradeResultMessage:[[LangCaptain getInstance] getLangByCode:@"ModifyPriceWarningFailed"]];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] showTradeResultFailedView];
    }
}

- (NSString *)getSuccessNoticeTitleWithType:(TradeType)type {
    NSString *titleString = @"";
    switch (type) {
        case TradeTypeAddOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
        case TradeTypeModifyOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
        case TradeTypeDeleteOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
            
        case TradeTypeAddOpenOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
        case TradeTypeModifyOpenOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
        case TradeTypeDeleteOpenOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
            
        case TradeTypeClosePosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
        case TradeTypePriceWarning:
            titleString = [[LangCaptain getInstance] getLangByCode:@"SuccessNotice"];
            break;
            
        default:
            break;
    }
    return titleString;
}

- (NSString *)getFailedNoticeTitleWithType:(TradeType)type {
    NSString *titleString = @"";
    switch (type) {
        case TradeTypeAddOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
        case TradeTypeModifyOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
        case TradeTypeDeleteOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
            
        case TradeTypeAddOpenOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
        case TradeTypeModifyOpenOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
        case TradeTypeDeleteOpenOrderPosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
            
        case TradeTypeClosePosition:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
        case TradeTypePriceWarning:
            titleString = [[LangCaptain getInstance] getLangByCode:@"ErrNotice"];
            break;
            
        default:
            break;
    }
    return titleString;
}

- (NSString *)getSuccessMessageWithType:(TradeType)type {
    NSString *messageString = @"";
    switch (type) {
            
        case TradeTypeAddOrderPosition:
            messageString = [[LangCaptain getInstance] getLangByCode:@"OrderSuccess"];
            break;
        case TradeTypeModifyOrderPosition:
            //            messageString = [[LangCaptain getInstance] getLangByCode:@"ModifyOrderSuccess"];
            messageString = [[LangCaptain getInstance] getLangByCode:@"OrderSuccess"];
            break;
        case TradeTypeDeleteOrderPosition:
            messageString = [[LangCaptain getInstance] getLangByCode:@"DeleteOrderSuccess"];
            break;
            
        case TradeTypeAddOpenOrderPosition:
            messageString = [[LangCaptain getInstance] getLangByCode:@"OrderSuccess"];
            break;
        case TradeTypeModifyOpenOrderPosition:
            //            messageString = [[LangCaptain getInstance] getLangByCode:@"ModifyOrderSuccess"];
            messageString = [[LangCaptain getInstance] getLangByCode:@"OrderSuccess"];
            break;
        case TradeTypeDeleteOpenOrderPosition:
            messageString = [[LangCaptain getInstance] getLangByCode:@"DeleteOrderSuccess"];
            break;
            
        case TradeTypeClosePosition:
            messageString = [[LangCaptain getInstance] getLangByCode:@"ClosePositionSuccess"];
            break;
        case TradeTypePriceWarning:
            messageString = [[LangCaptain getInstance] getLangByCode:@"DeletePriceWarningSuccess"];
            break;
        default:
            break;
    }
    return messageString;
}

- (void)customAlert:(CustomAlertView *)alertView didClickButtonAtIndex:(NSUInteger)index {
    [alertView setDelegate:nil];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] closeAllView];
}

@end
