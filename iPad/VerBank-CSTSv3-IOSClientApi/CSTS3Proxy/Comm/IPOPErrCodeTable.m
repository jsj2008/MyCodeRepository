//
//  IPOPErrCodeTable.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "IPOPErrCodeTable.h"


NSString * const ERR_TradeIDNotFind =@"ERR_TradeIDNotFind";// TradeId不存在
NSString * const ERR_Unknown =@"ERR_Unknown";
NSString * const ERR_Timeout =@"ERR_Timeout";
NSString * const ERR_NetErr =@"ERR_NetErr";
NSString * const ERR_ServerNotFind =@"ERR_ServerNotFind";
NSString * const ERR_HighFrequency =@"ERR_HighFrequency";

NSString * const ERR_HaveNullValue =@"ERR_HaveNullValue";// 空值错误
NSString * const ERR_Parameter_Error =@"ERR_Parameter_Error";// 参数错误
NSString * const ERR_DateError =@"ERR_DateError";// 日期错误
NSString * const ERR_NumberError =@"ERR_NumberError";// 错误的数字
NSString * const ERR_TypeError =@"ERR_TypeError";// 类型错误

NSString * const ERR_System_is_Open =@"ERR_System_is_Open";// 系统已经开盘
NSString * const ERR_System_is_Close =@"ERR_System_is_Close";// 系统已经收盘
NSString * const ERR_CloseOpen_StateErr =@"ERR_CloseOpen_StateErr";
NSString * const ERR_CloseOpen_TradeDayErr =@"ERR_CloseOpen_TradeDayErr";

NSString * const ERR_TradeDisabled =@"ERR_TradeDisabled";
NSString * const ERR_PriceErr =@"ERR_PriceErr";
NSString * const ERR_QueryNewIDFailed =@"ERR_QueryNewIDFailed";
NSString * const ERR_TooManyOrders =@"ERR_TooManyOrders";
NSString * const ERR_TooManyPositions =@"ERR_TooManyPositions";
NSString * const ERR_OutofNOPL =@"ERR_OutofNOPL";
NSString * const ERR_PreSellErr =@"ERR_PreSellErr";

NSString * const ERR_PasswordStore_Error =@"ERR_PasswordStore_Error";// 找不到对应的储备密码
NSString * const ERR_Password_is_Used =@"ERR_Password_is_Used";// 储备密码已经使用
NSString * const ERR_Password_Locked =@"ERR_Password_Locked";// 电话密码已锁
NSString * const ERR_Password_Disabled =@"ERR_Password_Disabled";// 电话密码已失效
NSString * const ERR_PasswordErr =@"ERR_PasswordErr";
NSString * const ERR_DealerPasswordErr =@"ERR_DealerPasswordErr";
NSString * const ERR_CA_Password_Err =@"ERR_CA_Password_Err";

NSString * const ERR_Groups_Error =@"ERR_Groups_Error";// group错误
NSString * const ERR_FunctionId_or_Level_Error =@"ERR_FunctionId_or_Level_Error";// functionId或者level错误
NSString * const ERR_ReplaceGroupName_Error =@"ERR_ReplaceGroupName_Error";// 转移的group不存在
NSString * const ERR_GroupName_equals_ReplaceGroupName =@"ERR_GroupName_equals_ReplaceGroupName";// 删除的目标group和转移的group相同

NSString * const ERR_UserDisabled =@"ERR_UserDisabled";
NSString * const ERR_UserNotFound =@"ERR_UserNotFound";// 用户不存在
NSString * const ERR_DealerNotFound =@"ERR_DealerNotFound";
NSString * const ERR_OrderNotFound =@"ERR_OrderNotFound";
NSString * const ERR_AccountNotFound =@"ERR_AccountNotFound";
NSString * const ERR_UserNameNotMatch =@"ERR_UserNameNotMatch";

NSString * const ERR_InstrumentNotValid =@"ERR_InstrumentNotValid";

NSString * const ERR_FixOrderCheckErr =@"ERR_FixOrderCheckErr";

NSString * const ERR_TradeFailed =@"ERR_TradeFailed";
NSString * const ERR_SendInfoToClientFailed =@"ERR_SendInfoToClientFailed";

NSString * const ERR_FixAccountFailed =@"ERR_FixAccountFailed";
NSString * const ERR_OrderTypeErr =@"ERR_OrderTypeErr";
NSString * const ERR_CaculateIfOrderTradeFailed =@"ERR_CaculateIfOrderTradeFailed";
NSString * const ERR_MarginIsNotEnoughToTrade =@"ERR_MarginIsNotEnoughToTrade";
NSString * const ERR_PositionNotFound =@"ERR_PositionNotFound";
NSString * const ERR_GroupNotFound =@"ERR_GroupNotFound";

NSString * const ERR_OrderPriceNotReachYet =@"ERR_OrderPriceNotReachYet";
NSString * const ERR_OrderIsInMonitorMod =@"ERR_OrderIsInMonitorMod";
NSString * const ERR_OrderTradeTypeErr =@"ERR_OrderTradeTypeErr";
NSString * const ERR_MD5DigestDontMatch =@"ERR_MD5DigestDontMatch";

NSString * const ERR_CADTS_OTHER =@"ERR_CADTS_OTHER";
NSString * const ERR_CADTS_TIMEOUT =@"ERR_CADTS_TIMEOUT";
NSString * const ERR_CADTS_SERVNOTFIND =@"ERR_CADTS_SERVNOTFIND";
NSString * const ERR_CADTS_NETERR =@"ERR_CADTS_NETERR";
NSString * const ERR_CADTS_FORMATERR =@"ERR_CADTS_FORMATERR";
NSString * const ERR_CADTS_REMOTEERR =@"ERR_CADTS_REMOTEERR";
NSString * const ERR_CADTS_BACKDATA_REMOTEERR =@"ERR_CADTS_BACKDATA_REMOTEERR";
NSString * const ERR_CADTS_EXCEPTION =@"ERR_CADTS_EXCEPTION";

NSString * const TRADESERV_ERR_SUMBMITTRADETYPEERR =@"TRADESERV_ERR_SUMBMITTRADETYPEERR";
NSString * const TRADESERV_ERR_MarginIsStillEnough =@"TRADESERV_ERR_MarginIsStillEnough";
NSString * const ERR_MarketPriceChanged =@"ERR_MarketPriceChanged";
NSString * const ERR_LotsErr =@"ERR_LotsErr";
NSString * const ERR_UPTRADEFAILED =@"ERR_UPTRADEFAILED";
NSString * const ERR_ACCOUNTISBUSY =@"ERR_ACCOUNTISBUSY";
NSString * const ERR_OpenCloseTimeGapErr =@"ERR_OpenCloseTimeGapErr";
NSString * const ERR_WAITINGDEALERCONFIRMFAILED =@"ERR_WAITINGDEALERCONFIRMFAILED";
NSString * const ERR_DEALERSETTRADEFAILED =@"ERR_DEALERSETTRADEFAILED";
NSString * const ERR_PRICECANNOTBEACCEPTED =@"ERR_PRICECANNOTBEACCEPTED";

NSString * const ERR_SIGNATURE_CHECK_FAILURE = @"ERR_SIGNATURE_CHECK_FAILURE";

@implementation IPOPErrCodeTable

@end
