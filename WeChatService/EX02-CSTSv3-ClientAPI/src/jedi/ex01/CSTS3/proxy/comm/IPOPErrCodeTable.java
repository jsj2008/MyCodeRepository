package jedi.ex01.CSTS3.proxy.comm;

public interface IPOPErrCodeTable {
	String ERR_TradeIDNotFind = "ERR_TradeIDNotFind";// TradeId不存在
	String ERR_Unknown = "ERR_Unknown";
	String ERR_Timeout = "ERR_Timeout";
	String ERR_NetErr = "ERR_NetErr";
	String ERR_ServerNotFind = "ERR_ServerNotFind";
	String ERR_HighFrequency = "ERR_HighFrequency";

	String ERR_HaveNullValue = "ERR_HaveNullValue";// 空值错误
	String ERR_Parameter_Error = "ERR_Parameter_Error";// 参数错误
	String ERR_DateError = "ERR_DateError";// 日期错误
	String ERR_NumberError = "ERR_NumberError";// 错误的数字
	String ERR_TypeError = "ERR_TypeError";// 类型错误

	String ERR_System_is_Open = "ERR_System_is_Open";// 系统已经开盘
	String ERR_System_is_Close = "ERR_System_is_Close";// 系统已经收盘
	String ERR_CloseOpen_StateErr = "ERR_CloseOpen_StateErr";
	String ERR_CloseOpen_TradeDayErr = "ERR_CloseOpen_TradeDayErr";

	String ERR_TradeDisabled = "ERR_TradeDisabled";
	String ERR_PriceErr = "ERR_PriceErr";
	String ERR_QueryNewIDFailed = "ERR_QueryNewIDFailed";
	String ERR_TooManyOrders = "ERR_TooManyOrders";
	String ERR_TooManyPositions = "ERR_TooManyPositions";
	String ERR_OutofNOPL = "ERR_OutofNOPL";
	String ERR_PreSellErr = "ERR_PreSellErr";

	String ERR_PasswordStore_Error = "ERR_PasswordStore_Error";// 找不到对应的储备密码
	String ERR_Password_is_Used = "ERR_Password_is_Used";// 储备密码已经使用
	String ERR_Password_Locked = "ERR_Password_Locked";// 电话密码已锁
	String ERR_Password_Disabled = "ERR_Password_Disabled";// 电话密码已失效
	String ERR_PasswordErr = "ERR_PasswordErr";
	String ERR_DealerPasswordErr = "ERR_DealerPasswordErr";
	String ERR_CA_Password_Err = "ERR_CA_Password_Err";

	String ERR_Groups_Error = "ERR_Groups_Error";// group错误
	String ERR_FunctionId_or_Level_Error = "ERR_FunctionId_or_Level_Error";// functionId或者level错误
	String ERR_ReplaceGroupName_Error = "ERR_ReplaceGroupName_Error";// 转移的group不存在
	String ERR_GroupName_equals_ReplaceGroupName = "ERR_GroupName_equals_ReplaceGroupName";// 删除的目标group和转移的group相同

	String ERR_UserDisabled = "ERR_UserDisabled";
	String ERR_UserNotFound = "ERR_UserNotFound";// 用户不存在
	String ERR_DealerNotFound = "ERR_DealerNotFound";
	String ERR_OrderNotFound = "ERR_OrderNotFound";
	String ERR_AccountNotFound = "ERR_AccountNotFound";
	String ERR_UserNameNotMatch = "ERR_UserNameNotMatch";

	String ERR_InstrumentNotValid = "ERR_InstrumentNotValid";

	String ERR_FixOrderCheckErr = "ERR_FixOrderCheckErr";

	String ERR_TradeFailed = "ERR_TradeFailed";
	String ERR_SendInfoToClientFailed = "ERR_SendInfoToClientFailed";

	String ERR_FixAccountFailed = "ERR_FixAccountFailed";
	String ERR_OrderTypeErr = "ERR_OrderTypeErr";
	String ERR_CaculateIfOrderTradeFailed = "ERR_CaculateIfOrderTradeFailed";
	String ERR_MarginIsNotEnoughToTrade = "ERR_MarginIsNotEnoughToTrade";
	String ERR_PositionNotFound = "ERR_PositionNotFound";
	String ERR_GroupNotFound = "ERR_GroupNotFound";

	String ERR_OrderPriceNotReachYet = "ERR_OrderPriceNotReachYet";
	String ERR_OrderIsInMonitorMod = "ERR_OrderIsInMonitorMod";
	String ERR_OrderTradeTypeErr = "ERR_OrderTradeTypeErr";
	String ERR_MD5DigestDontMatch = "ERR_MD5DigestDontMatch";

	String ERR_CADTS_OTHER = "ERR_CADTS_OTHER";
	String ERR_CADTS_TIMEOUT = "ERR_CADTS_TIMEOUT";
	String ERR_CADTS_SERVNOTFIND = "ERR_CADTS_SERVNOTFIND";
	String ERR_CADTS_NETERR = "ERR_CADTS_NETERR";
	String ERR_CADTS_FORMATERR = "ERR_CADTS_FORMATERR";
	String ERR_CADTS_REMOTEERR = "ERR_CADTS_REMOTEERR";
	String ERR_CADTS_BACKDATA_REMOTEERR = "ERR_CADTS_BACKDATA_REMOTEERR";
	String ERR_CADTS_EXCEPTION = "ERR_CADTS_EXCEPTION";
	
	public static final String TRADESERV_ERR_SUMBMITTRADETYPEERR = "TRADESERV_ERR_SUMBMITTRADETYPEERR";
	public static final String TRADESERV_ERR_MarginIsStillEnough = "TRADESERV_ERR_MarginIsStillEnough";
	public static final String ERR_MarketPriceChanged = "ERR_MarketPriceChanged";
	public static final String ERR_LotsErr = "ERR_LotsErr";
	public static final String ERR_UPTRADEFAILED = "ERR_UPTRADEFAILED";
	public static final String ERR_ACCOUNTISBUSY = "ERR_ACCOUNTISBUSY";
	public static final String ERR_OpenCloseTimeGapErr = "ERR_OpenCloseTimeGapErr";
	public static final String ERR_WAITINGDEALERCONFIRMFAILED = "ERR_WAITINGDEALERCONFIRMFAILED";
	public static final String ERR_DEALERSETTRADEFAILED = "ERR_DEALERSETTRADEFAILED";
	public static final String ERR_PRICECANNOTBEACCEPTED = "ERR_PRICECANNOTBEACCEPTED";
	
}
