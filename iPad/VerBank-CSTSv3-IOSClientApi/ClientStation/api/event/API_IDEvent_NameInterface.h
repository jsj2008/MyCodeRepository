//
//  API_IDEvent_NameInterface.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/14.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern  NSString *const NAME_TRADERETURN;

extern  NSString *const NAME_NAME_ON_TSETTLED4CFD_CHANGED;
extern  NSString *const NAME_NAME_ON_NET_LOST;

extern  NSString *const NAME_ON_DOC_INITED;

extern  NSString *const OTHER_ON_SYSTEMOPEN;
extern  NSString *const OTHER_ON_SYSTEMCLOSE;
extern  NSString *const OTHER_ON_MARGINCALL;
extern  NSString *const OTHER_ON_LIQUIDATION;
extern  NSString *const OTHER_ON_KICKOUT;
extern  NSString *const OTHER_ON_KICK_BY_SYS;

extern  NSString *const OTHER_ON_DOC_INITED;
extern  NSString *const OTHER_ON_PING;

extern  NSString *const DATA_ON_AccountStategy_Changed;
extern  NSString *const DATA_ON_MoneyAccount_Changed;
extern  NSString *const DATA_ON_InstrumentType_Changed;
extern  NSString *const DATA_ON_Instrument_Changed;
extern  NSString *const DATA_ON_Rollover_Changed;
extern  NSString *const DATA_ON_TradeType_Changed;
extern  NSString *const DATA_ON_InstrumentGroupCfg_Changed;
extern  NSString *const DATA_ON_InstrumentAccountCfg_Changed;
extern  NSString *const DATA_ON_Order_Changed;
extern  NSString *const DATA_ON_Trade_Changed;
extern  NSString *const DATA_ON_NewQuote;
extern  NSString *const DATA_ON_SimpleNews;
extern  NSString *const DATA_ON_AllData_Changed;
extern  NSString *const DATA_ON_TradeLogs;
extern  NSString *const DATA_ON_Group_Changed;
extern  NSString *const DATA_ON_SpiketQuote;
extern  NSString *const DATA_ON_MessageFromUser;
extern  NSString *const DATA_ON_InstTypeTree_Changed;
extern  NSString *const DATA_ON_InstTypeTreeLanguage_Changed;
extern  NSString *const DATA_ON_InstrumentLanguage_Changed;
extern  NSString *const DATA_ON_User_Changed;
extern  NSString *const DATA_ON_MktOrderHasSendToMarket;
extern  NSString *const DATA_ON_Order_Trade;
extern  NSString *const DATA_ON_Liquidation;
extern  NSString *const DATA_ON_MessageReceive;
extern  NSString *const DATA_ON_PriceWarning_Reached;

extern  NSString *const OTHER_ON_NET_LOST;
extern  NSString *const NAME_ON_DO_RECONNECT;
extern  NSString *const NAME_ON_LOGIN_RESULT;
extern  NSString *const NAME_ON_CONNECTED;
extern  NSString *const DEBUG_NET_TIMEOUT;
extern  NSString *const DEBUG_NEW_QUOTE;
extern  NSString *const DEBUG_INFO;

extern  NSString *const NAME_ON_QUOTELIST_INITED;

extern  NSString *const TRADE_RESULT_EVENT;



@interface API_IDEvent_NameInterface:NSObject
@end
 