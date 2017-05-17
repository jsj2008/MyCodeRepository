//
//  JsonFactory.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JsonFactory.h"
#import "JEDISystem.h"
#import "JEDIJson.h"

#import "AbstractJsonData.h"
#import "CSTSPing.h"

#import "EconomicData.h"
#import "OperationRecords.h"
#import "IP_TRADESERV1901.h"
#import "OP_TRADESERV1901.h"
#import "IP_TRADESERV1904.h"
#import "OP_TRADESERV1904.h"

#import "IP_Ctrl1001.h"
#import "OP_Ctrl1001.h"

#import "IP_Ctrl2002.h"
#import "OP_Ctrl2002.h"

#import "IP_QG1001.h"
#import "OP_QG1001.h"

#import "IP_TRADESERV5010.h"
#import "OP_TRADESERV5010.h"
#import "IP_TRADESERV5011.h"
#import "OP_TRADESERV5011.h"
#import "IP_TRADESERV5013.h"
#import "OP_TRADESERV5013.h"
#import "IP_TRADESERV5017.h"
#import "OP_TRADESERV5017.h"
#import "IP_TRADESERV5018.h"
#import "OP_TRADESERV5018.h"
#import "IP_TRADESERV5019.h"
#import "OP_TRADESERV5019.h"
#import "IP_TRADESERV5020.h"
#import "OP_TRADESERV5020.h"
#import "IP_TRADESERV5021.h"
#import "OP_TRADESERV5021.h"
#import "IP_TRADESERV5022.h"
#import "OP_TRADESERV5022.h"
#import "IP_TRADESERV5024.h"
#import "OP_TRADESERV5024.h"
#import "IP_TRADESERV5025.h"
#import "OP_TRADESERV5025.h"
#import "IP_TRADESERV5030.h"
#import "OP_TRADESERV5030.h"
#import "IP_TRADESERV5040.h"
#import "OP_TRADESERV5040.h"
#import "IP_TRADESERV5041.h"
#import "OP_TRADESERV5041.h"
#import "IP_TRADESERV6101.h"
#import "OP_TRADESERV6101.h"
#import "IP_REPORT6102.h"
#import "OP_REPORT6102.h"
#import "IP_TRADESERV6103.h"
#import "OP_TRADESERV6103.h"

#import "IP_Ctrl4001.h"
#import "OP_Ctrl4001.h"
#import "IP_Ctrl4002.h"
#import "OP_Ctrl4002.h"
#import "IP_Ctrl4003.h"
#import "OP_Ctrl4003.h"
#import "IP_Ctrl4004.h"
#import "OP_Ctrl4004.h"

#import "IP_Ctrl5001.h"
#import "OP_Ctrl5001.h"

#import "IP_QDB1002.h"
#import "OP_QDB1002.h"
#import "IP_QDB1003.h"
#import "OP_QDB1003.h"
#import "IP_QDB1004.h"
#import "OP_QDB1004.h"
#import "IP_REPORT2001.h"
#import "OP_REPORT2001.h"
#import "IP_REPORT2007.h"
#import "OP_REPORT2007.h"
#import "IP_REPORT2023.h"
#import "OP_REPORT2023.h"
#import "IP_REPORT2011.h"
#import "OP_REPORT2011.h"
#import "IP_TDB1016.h"
#import "OP_TDB1016.h"
#import "IP_TRADESERV5023.h"
#import "OP_TRADESERV5023.h"
#import "IP_TRADESERV5026.h"
#import "OP_TRADESERV5026.h"
#import "IP_TRADESERV5046.h"
#import "OP_TRADESERV5046.h"
#import "IP_TRADESERV5061.h"
#import "OP_TRADESERV5061.h"
#import "IP_TRADESERV5062.h"
#import "OP_TRADESERV5062.h"
#import "IP_TRADESERV5065.h"
#import "OP_TRADESERV5065.h"
#import "IP_TRADESERV5101.h"
#import "OP_TRADESERV5101.h"
#import "IP_TRADESERV5102.h"
#import "OP_TRADESERV5102.h"
#import "IP_TRADESERV5103.h"
#import "OP_TRADESERV5103.h"
#import "IP_TRADESERV5104.h"
#import "OP_TRADESERV5104.h"
#import "IP_TRADESERV5105.h"
#import "OP_TRADESERV5105.h"
#import "IP_TRADESERV5108.h"
#import "OP_TRADESERV5108.h"
#import "IP_TRADESERV5109.h"
#import "OP_TRADESERV5109.h"
#import "IP_TRADESERV5115.h"
#import "OP_TRADESERV5115.h"
#import "IP_TRADESERV5116.h"
#import "OP_TRADESERV5116.h"
#import "IP_TRADESERV5117.h"
#import "OP_TRADESERV5117.h"

#import "AccountBasic.h"
#import "AccountStrategy.h"
#import "BalanceRate.h"
#import "BasicCurrency.h"
#import "BatchRateGap.h"
#import "GroupConfig.h"
#import "Holidays4ccy.h"
#import "Instrument.h"
#import "InstrumentsGroupCfg.h"
#import "InstrumentsAccountCfg.h"
#import "InstTypeTree.h"
#import "InterestAddType.h"
#import "InterestRate.h"
#import "LangPack.h"
#import "Margin2.h"
#import "MarginCall.h"
#import "MessageToAccount.h"
#import "MoneyAccount.h"
#import "MoneyAccountFrozen.h"
#import "NotValueDay4Inst.h"
#import "OtherClientConfig.h"
#import "PriceWarning.h"
#import "QuoteData.h"
#import "QuoteSizeData.h"
#import "SystemConfig.h"
#import "TOrder.h"
#import "TOrders4CFD.h"
#import "TSettled.h"
#import "TTrade.h"
#import "TTrade4CFD.h"
#import "UserLogin.h"
#import "ValueDaySetting.h"
#import "TOrderHis.h"
#import "TOrderHisDetails.h"
#import "ClosePositionDetails.h"
#import "ToCloseTradeNode.h"
#import "HistoricData.h"
#import "MoneyAccountStream.h"

#import "FnCertState.h"
#import "FnStatus.h"
#import "AccountStreamDetails.h"
#import "PushFromSystem.h"

#import "QuoteList.h"

#import "KickBySysNode.h"
#import "KickOutNode.h"
#import "WithDrawApplication.h"

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

#import "Info_TRADESERV1003.h"
#import "Info_TRADESERV1004.h"
#import "Info_TRADESERV1005.h"
#import "Info_TRADESERV1006.h"
#import "Info_TRADESERV1007.h"
#import "Info_TRADESERV1008.h"

#import "Info_TRADESERV1010.h"
#import "Info_TRADESERV1011.h"
#import "Info_TRADESERV1012.h"
#import "Info_TRADESERV1013.h"
#import "Info_TRADESERV1014.h"
#import "Info_TRADESERV1015.h"
#import "Info_TRADESERV1016.h"

static NSMutableDictionary * gs_JsonFactory_JsonClassMap = nil;


//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
@interface JsonFactory ()

#pragma mark Private

+ (void)    addClassWithId:(NSString *) jsonId  Class:(Class) jsonClass;
+ (id)      newInstanceWithJsonId:(NSString *)jsonId;

+ (id)      parseWithObject:(NSObject *) object;
+ (id)      parseWithDictionary:(NSDictionary *) dictionary;
+ (id)      parseWithArray:(NSArray *) array;

@end


//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
@implementation JsonFactory

//--------------------------------------------------------------------
+ (void)    initAllJsonClass
{
    if(gs_JsonFactory_JsonClassMap != nil){
        [JEDISystem log:@"JsonFactory.initAllJsonClass, the json class already initialized."];
        return;
    }
    
    gs_JsonFactory_JsonClassMap = [[NSMutableDictionary alloc] init];
    
    //
    // Ping
    //
    [JsonFactory addClassWithId:@"CSTSPing"             Class:[CSTSPing                     class]];
    
    //
    // Login
    //
    
    [JsonFactory addClassWithId:@"IP_Ctrl1001"          Class:[IP_Ctrl1001                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl1001"          Class:[OP_Ctrl1001                  class]];
    
    //
    // comm
    //
    [JsonFactory addClassWithId:@"IP_Ctrl2002"              Class:[IP_Ctrl2002                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl2002"              Class:[OP_Ctrl2002                  class]];
    [JsonFactory addClassWithId:@"IP_QG1001"                Class:[IP_QG1001                  class]];
    [JsonFactory addClassWithId:@"OP_QG1001"                Class:[OP_QG1001                  class]];
    
    [JsonFactory addClassWithId:@"IP_TRADESERV1901"         Class:[IP_TRADESERV1901                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV1901"         Class:[OP_TRADESERV1901                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV1904"         Class:[IP_TRADESERV1904                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV1904"         Class:[OP_TRADESERV1904                  class]];
    [JsonFactory addClassWithId:@"EconomicData"             Class:[EconomicData                  class]];
    [JsonFactory addClassWithId:@"OperationRecords"             Class:[OperationRecords                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5010"         Class:[IP_TRADESERV5010                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5010"         Class:[OP_TRADESERV5010                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5011"         Class:[IP_TRADESERV5011                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5011"         Class:[OP_TRADESERV5011                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5013"         Class:[IP_TRADESERV5013                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5013"         Class:[OP_TRADESERV5013                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5017"         Class:[IP_TRADESERV5017                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5017"         Class:[OP_TRADESERV5017                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5018"         Class:[IP_TRADESERV5018                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5018"         Class:[OP_TRADESERV5018                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5019"         Class:[IP_TRADESERV5019                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5019"         Class:[OP_TRADESERV5019                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5020"         Class:[IP_TRADESERV5020                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5020"         Class:[OP_TRADESERV5020                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5021"         Class:[IP_TRADESERV5021                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5021"         Class:[OP_TRADESERV5021                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5022"         Class:[IP_TRADESERV5022                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5022"         Class:[OP_TRADESERV5022                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5024"         Class:[IP_TRADESERV5024                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5024"         Class:[OP_TRADESERV5024                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5025"         Class:[IP_TRADESERV5025                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5025"         Class:[OP_TRADESERV5025                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5030"         Class:[IP_TRADESERV5030                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5030"         Class:[OP_TRADESERV5030                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5040"         Class:[IP_TRADESERV5040                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5040"         Class:[OP_TRADESERV5040                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5041"         Class:[IP_TRADESERV5041                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5041"         Class:[OP_TRADESERV5041                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV6101"         Class:[IP_TRADESERV6101                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV6101"         Class:[OP_TRADESERV6101                  class]];
    [JsonFactory addClassWithId:@"IP_REPORT6102"            Class:[IP_REPORT6102                  class]];
    [JsonFactory addClassWithId:@"OP_REPORT6102"            Class:[OP_REPORT6102                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV6103"         Class:[IP_TRADESERV6103                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV6103"         Class:[OP_TRADESERV6103                  class]];
    
    [JsonFactory addClassWithId:@"IP_Ctrl4001"  Class:[IP_Ctrl4001                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl4001" Class:[OP_Ctrl4001                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl4002" Class:[IP_Ctrl4002                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl4002" Class:[OP_Ctrl4002                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl4003" Class:[IP_Ctrl4003                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl4003" Class:[OP_Ctrl4003                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl4004" Class:[IP_Ctrl4004                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl4004" Class:[OP_Ctrl4004                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5001" Class:[IP_Ctrl5001                   class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5001" Class:[OP_Ctrl5001                  class]];
    [JsonFactory addClassWithId:@"IP_QDB1002" Class:[IP_QDB1002                  class]];
    [JsonFactory addClassWithId:@"OP_QDB1002" Class:[OP_QDB1002                  class]];
    [JsonFactory addClassWithId:@"IP_QDB1003" Class:[IP_QDB1003                  class]];
    [JsonFactory addClassWithId:@"OP_QDB1003" Class:[OP_QDB1003                  class]];
    [JsonFactory addClassWithId:@"IP_QDB1004" Class:[IP_QDB1004                  class]];
    [JsonFactory addClassWithId:@"OP_QDB1004" Class:[OP_QDB1004                  class]];
    [JsonFactory addClassWithId:@"IP_REPORT2001" Class:[IP_REPORT2001                  class]];
    [JsonFactory addClassWithId:@"OP_REPORT2001" Class:[OP_REPORT2001                  class]];
    [JsonFactory addClassWithId:@"IP_REPORT2007" Class:[IP_REPORT2007                  class]];
    [JsonFactory addClassWithId:@"OP_REPORT2007" Class:[OP_REPORT2007                  class]];
    [JsonFactory addClassWithId:@"IP_REPORT2023" Class:[IP_REPORT2023                  class]];
    [JsonFactory addClassWithId:@"OP_REPORT2023" Class:[OP_REPORT2023                  class]];
    [JsonFactory addClassWithId:@"IP_REPORT2011" Class:[IP_REPORT2011                  class]];
    [JsonFactory addClassWithId:@"OP_REPORT2011" Class:[OP_REPORT2011                  class]];
    [JsonFactory addClassWithId:@"IP_TDB1016"  Class:[IP_TDB1016                  class]];
    [JsonFactory addClassWithId:@"OP_TDB1016" Class:[OP_TDB1016                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5023" Class:[IP_TRADESERV5023                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5023" Class:[OP_TRADESERV5023                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5026" Class:[IP_TRADESERV5026                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5026" Class:[OP_TRADESERV5026                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5046" Class:[IP_TRADESERV5046                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5046" Class:[OP_TRADESERV5046                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5061" Class:[IP_TRADESERV5061                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5061" Class:[OP_TRADESERV5061                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5062" Class:[IP_TRADESERV5062                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5062" Class:[OP_TRADESERV5062                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5065" Class:[IP_TRADESERV5065                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5065" Class:[OP_TRADESERV5065                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5101" Class:[IP_TRADESERV5101                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5101" Class:[OP_TRADESERV5101                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5102" Class:[IP_TRADESERV5102                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5102" Class:[OP_TRADESERV5102                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5103" Class:[IP_TRADESERV5103                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5103" Class:[OP_TRADESERV5103                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5104" Class:[IP_TRADESERV5104                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5104" Class:[OP_TRADESERV5104                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5105" Class:[IP_TRADESERV5105                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5105" Class:[OP_TRADESERV5105                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5108" Class:[IP_TRADESERV5108                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5108" Class:[OP_TRADESERV5108                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5109" Class:[IP_TRADESERV5109                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5109" Class:[OP_TRADESERV5109                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5115" Class:[IP_TRADESERV5115                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5115" Class:[OP_TRADESERV5115                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5116" Class:[IP_TRADESERV5116                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5116" Class:[OP_TRADESERV5116                  class]];
    [JsonFactory addClassWithId:@"IP_TRADESERV5117" Class:[IP_TRADESERV5117                  class]];
    [JsonFactory addClassWithId:@"OP_TRADESERV5117" Class:[OP_TRADESERV5117                  class]];
    //struct
    
    [JsonFactory addClassWithId:@"AccountBasic"                 Class:[AccountBasic                  class]];
    [JsonFactory addClassWithId:@"AccountStrategy"          Class:[AccountStrategy                  class]];
    [JsonFactory addClassWithId:@"BalanceRate"              Class:[BalanceRate                  class]];
    [JsonFactory addClassWithId:@"BasicCurrency"            Class:[BasicCurrency                  class]];
    //    [JsonFactory addClassWithId:@"BatchRateGap"         Class:[BatchRateGap                  class]];
    [JsonFactory addClassWithId:@"GroupConfig"              Class:[GroupConfig                  class]];
    [JsonFactory addClassWithId:@"Holidays4ccy"             Class:[Holidays4ccy                  class]];
    [JsonFactory addClassWithId:@"Instrument"               Class:[Instrument                  class]];
    [JsonFactory addClassWithId:@"InstrumentsGroupCfg"         Class:[InstrumentsGroupCfg                  class]];
    [JsonFactory addClassWithId:@"InstrumentsAccountCfg"         Class:[InstrumentsAccountCfg                  class]];
    [JsonFactory addClassWithId:@"InstTypeTree"                 Class:[InstTypeTree                  class]];
    [JsonFactory addClassWithId:@"InterestAddType"          Class:[InterestAddType                  class]];
    [JsonFactory addClassWithId:@"InterestRate"             Class:[InterestRate                  class]];
    [JsonFactory addClassWithId:@"LangPack"                 Class:[LangPack                  class]];
    [JsonFactory addClassWithId:@"Margin2"                  Class:[Margin2                  class]];
    [JsonFactory addClassWithId:@"MarginCall"               Class:[MarginCall                  class]];
    [JsonFactory addClassWithId:@"MessageToAccount"         Class:[MessageToAccount                  class]];
    [JsonFactory addClassWithId:@"MoneyAccount"             Class:[MoneyAccount                  class]];
    [JsonFactory addClassWithId:@"MoneyAccountFrozen"         Class:[MoneyAccountFrozen                  class]];
    [JsonFactory addClassWithId:@"NotValueDay4Inst"         Class:[NotValueDay4Inst                  class]];
    [JsonFactory addClassWithId:@"OtherClientConfig"         Class:[OtherClientConfig                  class]];
    [JsonFactory addClassWithId:@"PriceWarning"             Class:[PriceWarning                  class]];
    [JsonFactory addClassWithId:@"QuoteData"            Class:[QuoteData                  class]];
    [JsonFactory addClassWithId:@"QuoteSizeData"         Class:[QuoteSizeData                  class]];
    [JsonFactory addClassWithId:@"SystemConfig"         Class:[SystemConfig                  class]];
    [JsonFactory addClassWithId:@"TOrder"               Class:[TOrder                  class]];
    //    [JsonFactory addClassWithId:@"TOrders4CFD"         Class:[TOrders4CFD                  class]];
    [JsonFactory addClassWithId:@"TSettled"             Class:[TSettled                  class]];
    [JsonFactory addClassWithId:@"TTrade"               Class:[TTrade                  class]];
    //    [JsonFactory addClassWithId:@"TTrade4CFD"         Class:[TTrade4CFD                  class]];
    [JsonFactory addClassWithId:@"UserLogin"            Class:[UserLogin                  class]];
    [JsonFactory addClassWithId:@"ValueDaySetting"         Class:[ValueDaySetting                  class]];
    
    [JsonFactory addClassWithId:@"TOrderHis"            Class:[TOrderHis                  class]];
    [JsonFactory addClassWithId:@"TOrderHisDetails"         Class:[TOrderHisDetails                  class]];
    [JsonFactory addClassWithId:@"ClosedPositionsDetails"         Class:[ClosePositionDetails                  class]];
    [JsonFactory addClassWithId:@"ToCloseTradeNode"             Class:[ToCloseTradeNode         class]];
    
    // QuoteList
    [JsonFactory addClassWithId:@"QuoteList"            Class:[QuoteList                  class]];
    
    [JsonFactory addClassWithId:@"KickBySysNode"            Class:[KickBySysNode                  class]];
    [JsonFactory addClassWithId:@"KickOutNode"            Class:[KickOutNode                  class]];
    [JsonFactory addClassWithId:@"WithDrawApplication"            Class:[WithDrawApplication                  class]];
    [JsonFactory addClassWithId:@"FnStatus"                 Class:[FnStatus                  class]];
    
    
    [JsonFactory addClassWithId:@"FnCertState"            Class:[FnCertState                  class]];
    [JsonFactory addClassWithId:@"HistoricData"            Class:[HistoricData                  class]];
    [JsonFactory addClassWithId:@"AccountStreamDetails"            Class:[AccountStreamDetails                  class]];
    [JsonFactory addClassWithId:@"PushFromSystem"            Class:[PushFromSystem                  class]];
    [JsonFactory addClassWithId:@"MoneyAccountStream"            Class:[MoneyAccountStream                  class]];
    
    [JsonFactory addClassWithId:@"Info_TRADESERV1003"            Class:[Info_TRADESERV1003                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1004"            Class:[Info_TRADESERV1004                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1005"            Class:[Info_TRADESERV1005                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1006"            Class:[Info_TRADESERV1006                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1007"            Class:[Info_TRADESERV1007                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1008"            Class:[Info_TRADESERV1008                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1010"            Class:[Info_TRADESERV1010                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1011"            Class:[Info_TRADESERV1011                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1012"            Class:[Info_TRADESERV1012                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1013"            Class:[Info_TRADESERV1013                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1014"            Class:[Info_TRADESERV1014                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1015"            Class:[Info_TRADESERV1015                  class]];
    [JsonFactory addClassWithId:@"Info_TRADESERV1016"            Class:[Info_TRADESERV1016                  class]];
    
    [JsonFactory addClassWithId:@"IP_Ctrl5101"            Class:[IP_Ctrl5101                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5101"            Class:[OP_Ctrl5101                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5102"            Class:[IP_Ctrl5102                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5102"            Class:[OP_Ctrl5102                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5103"            Class:[IP_Ctrl5103                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5103"            Class:[OP_Ctrl5103                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5104"            Class:[IP_Ctrl5104                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5104"            Class:[OP_Ctrl5104                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5105"            Class:[IP_Ctrl5105                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5105"            Class:[OP_Ctrl5105                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5106"            Class:[IP_Ctrl5106                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5106"            Class:[OP_Ctrl5106                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5107"            Class:[IP_Ctrl5107                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5107"            Class:[OP_Ctrl5107                  class]];
    [JsonFactory addClassWithId:@"IP_Ctrl5201"            Class:[IP_Ctrl5201                  class]];
    [JsonFactory addClassWithId:@"OP_Ctrl5201"            Class:[OP_Ctrl5201                  class]];
    
}

//--------------------------------------------------------------------
+ (void)    clearAllJonsClass
{
    if(gs_JsonFactory_JsonClassMap != nil)
    {
        [gs_JsonFactory_JsonClassMap removeAllObjects];
        gs_JsonFactory_JsonClassMap = nil;
    }
}

//--------------------------------------------------------------------
+ (id)      parseWithJsonString:(NSString *) strJson
{
    if(strJson == nil) return nil;
    
    JEDI_SYS_Try
    {
        NSData * nsData = [strJson dataUsingEncoding:NSUTF8StringEncoding];
        return [JsonFactory parseWithJsonData:nsData];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//--------------------------------------------------------------------
+ (id)      parseWithJsonData:(NSData *) dataJson
{
    if(dataJson == nil) return nil;
    
    JEDI_SYS_Try
    {
        NSDictionary * jsonDict = [JEDIJson dictionaryFromData:dataJson];
        if(nil == jsonDict){
            [JEDISystem log:@"JsonFactory.parseWithJsonString, get entry dictionary failed."];
            return nil;
        }
        
        return [JsonFactory parseWithDictionary:jsonDict];
    }
    JEDI_SYS_EndTry
    
    return nil;
}


//--------------------------------------------------------------------
+ (id)      newInstanceWithJsonId:(NSString *)jsonId
{
    if(gs_JsonFactory_JsonClassMap == nil){
        return nil;
    }
    
    JEDI_SYS_Try
    {
        Class jsonClass = [gs_JsonFactory_JsonClassMap valueForKey:jsonId];
        id jsonData = [[jsonClass alloc] initEmpty];
        return jsonData;
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//
// private static function
//
#pragma mark Private
//--------------------------------------------------------------------
+ (void)    addClassWithId:(NSString *) jsonId  Class:(Class) jsonClass
{
    if(gs_JsonFactory_JsonClassMap == nil){
        return;
    }
    
    [gs_JsonFactory_JsonClassMap setValue:jsonClass forKey:jsonId];
}

//--------------------------------------------------------------------
+ (id)      parseWithObject:(NSObject *) object
{
    if([object isKindOfClass:[NSDictionary class]])
    {
        return [JsonFactory parseWithDictionary:(NSDictionary *) object];
    }
    
    if([object isKindOfClass:[NSArray class]])
    {
        return [JsonFactory parseWithArray:(NSArray *) object];
    }
    
    return object;
}

//--------------------------------------------------------------------
+ (id)      parseWithDictionary:(NSDictionary *) dictionary
{
    if(dictionary == nil){
        return nil;
    }
    
    JEDI_SYS_Try
    {
        NSMutableDictionary * mutDictionary = [[NSMutableDictionary alloc] init];
        NSEnumerator *enumerator = [dictionary keyEnumerator];
        id key;
        
        while ((key = [enumerator nextObject]))
        {
            id obj = [JsonFactory parseWithObject:[dictionary objectForKey:key]];
            [mutDictionary setObject:obj forKey:key];
        }
        
        NSString * strJsonId = [dictionary valueForKey:@"jsonId"];
        id newObj = [JsonFactory newInstanceWithJsonId:strJsonId];
        
        if(newObj != nil && [newObj isKindOfClass:[AbstractJsonData class]])
        {
            AbstractJsonData * jsonData = newObj;
            [jsonData setEntryDictionary:mutDictionary];
            
            return jsonData;
        }
        else
        {
            if(strJsonId != nil){
                [JEDISystem log:@"JsonFactory.parseWithDictionary, *-*-*-* Invalide Json: " withObject:strJsonId];
            }
            
            return mutDictionary;
        }
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//--------------------------------------------------------------------
+ (id)      parseWithArray:(NSArray *) array
{
    if(array == nil){
        return nil;
    }
    
    JEDI_SYS_Try
    {
        NSMutableArray * mutArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i<array.count; i++)
        {
            id obj = [JsonFactory parseWithObject:[array objectAtIndex:i]];
            [mutArray addObject:obj];
        }
        
        return mutArray;
    }
    JEDI_SYS_EndTry
    
    return nil;
}

@end
