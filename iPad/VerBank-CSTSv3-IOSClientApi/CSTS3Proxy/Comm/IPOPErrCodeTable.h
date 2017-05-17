//
//  IPOPErrCodeTable.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>


extern  NSString *const ERR_TradeIDNotFind;// TradeId不存在
extern  NSString *const ERR_Unknown ;
extern  NSString *const ERR_Timeout ;
extern  NSString *const ERR_NetErr ;
extern  NSString *const ERR_ServerNotFind;
extern  NSString *const ERR_HighFrequency ;

extern  NSString *const ERR_HaveNullValue ;// 空值错误
extern  NSString *const ERR_Parameter_Error;// 参数错误
extern  NSString *const ERR_DateError;// 日期错误
extern  NSString *const ERR_NumberError;// 错误的数字
extern  NSString *const ERR_TypeError ;// 类型错误

extern  NSString *const ERR_System_is_Open;// 系统已经开盘
extern  NSString *const ERR_System_is_Close ;// 系统已经收盘
extern  NSString *const ERR_CloseOpen_StateErr ;
extern  NSString *const ERR_CloseOpen_TradeDayErr ;

extern  NSString *const ERR_TradeDisabled ;
extern  NSString *const ERR_PriceErr ;
extern  NSString *const ERR_QueryNewIDFailed ;
extern  NSString *const ERR_TooManyOrders;
extern  NSString *const ERR_TooManyPositions ;
extern  NSString *const ERR_OutofNOPL ;
extern  NSString *const ERR_PreSellErr ;

extern  NSString *const ERR_PasswordStore_Error ;// 找不到对应的储备密码
extern  NSString *const ERR_Password_is_Used ;// 储备密码已经使用
extern  NSString *const ERR_Password_Locked;// 电话密码已锁
extern  NSString *const ERR_Password_Disabled ;// 电话密码已失效
extern  NSString *const ERR_PasswordErr ;
extern  NSString *const ERR_DealerPasswordErr ;
extern  NSString *const ERR_CA_Password_Err;

extern  NSString *const ERR_Groups_Error ;// group错误
extern  NSString *const ERR_FunctionId_or_Level_Error ;// functionId或者level错误
extern  NSString *const ERR_ReplaceGroupName_Error ;// 转移的group不存在
extern  NSString *const ERR_GroupName_equals_ReplaceGroupName ;// 删除的目标group和转移的group相同

extern  NSString *const ERR_UserDisabled  ;
extern  NSString *const ERR_UserNotFound  ;// 用户不存在
extern  NSString *const ERR_DealerNotFound ;
extern  NSString *const ERR_OrderNotFound  ;
extern  NSString *const ERR_AccountNotFound ;
extern  NSString *const ERR_UserNameNotMatch ;

extern  NSString *const ERR_InstrumentNotValid ;

extern  NSString *const ERR_FixOrderCheckErr ;

extern  NSString *const ERR_TradeFailed ;
extern  NSString *const ERR_SendInfoToClientFailed ;

extern  NSString *const  ERR_FixAccountFailed;
extern  NSString *const ERR_OrderTypeErr;
extern  NSString *const ERR_CaculateIfOrderTradeFailed ;
extern  NSString *const ERR_MarginIsNotEnoughToTrade;
extern  NSString *const ERR_PositionNotFound;
extern  NSString *const ERR_GroupNotFound ;

extern  NSString *const ERR_OrderPriceNotReachYet ;
extern  NSString *const ERR_OrderIsInMonitorMod;
extern  NSString *const ERR_OrderTradeTypeErr ;
extern  NSString *const ERR_MD5DigestDontMatch;

extern  NSString *const ERR_CADTS_OTHER ;
extern  NSString *const ERR_CADTS_TIMEOUT ;
extern  NSString *const ERR_CADTS_SERVNOTFIND ;
extern  NSString *const ERR_CADTS_NETERR ;
extern  NSString *const ERR_CADTS_FORMATERR ;
extern  NSString *const ERR_CADTS_REMOTEERR ;
extern  NSString *const ERR_CADTS_BACKDATA_REMOTEERR ;
extern  NSString *const ERR_CADTS_EXCEPTION ;

extern  NSString *const TRADESERV_ERR_SUMBMITTRADETYPEERR;
extern  NSString *const TRADESERV_ERR_MarginIsStillEnough ;
extern  NSString *const ERR_MarketPriceChanged;
extern  NSString *const ERR_LotsErr ;
extern  NSString *const ERR_UPTRADEFAILED ;
extern  NSString *const ERR_ACCOUNTISBUSY ;
extern  NSString *const ERR_OpenCloseTimeGapErr ;
extern  NSString *const ERR_WAITINGDEALERCONFIRMFAILED ;
extern  NSString *const ERR_DEALERSETTRADEFAILED ;
extern  NSString *const ERR_PRICECANNOTBEACCEPTED ;

extern  NSString *const ERR_SIGNATURE_CHECK_FAILURE;

@interface IPOPErrCodeTable : NSObject

@property(weak, readonly) NSString * ERR_TradeIDNotFind;

@end 