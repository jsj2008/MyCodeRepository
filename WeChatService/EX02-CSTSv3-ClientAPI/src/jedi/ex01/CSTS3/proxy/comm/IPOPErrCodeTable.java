package jedi.ex01.CSTS3.proxy.comm;

public interface IPOPErrCodeTable {
	String ERR_TradeIDNotFind = "ERR_TradeIDNotFind";// TradeId������
	String ERR_Unknown = "ERR_Unknown";
	String ERR_Timeout = "ERR_Timeout";
	String ERR_NetErr = "ERR_NetErr";
	String ERR_ServerNotFind = "ERR_ServerNotFind";
	String ERR_HighFrequency = "ERR_HighFrequency";

	String ERR_HaveNullValue = "ERR_HaveNullValue";// ��ֵ����
	String ERR_Parameter_Error = "ERR_Parameter_Error";// ��������
	String ERR_DateError = "ERR_DateError";// ���ڴ���
	String ERR_NumberError = "ERR_NumberError";// ���������
	String ERR_TypeError = "ERR_TypeError";// ���ʹ���

	String ERR_System_is_Open = "ERR_System_is_Open";// ϵͳ�Ѿ�����
	String ERR_System_is_Close = "ERR_System_is_Close";// ϵͳ�Ѿ�����
	String ERR_CloseOpen_StateErr = "ERR_CloseOpen_StateErr";
	String ERR_CloseOpen_TradeDayErr = "ERR_CloseOpen_TradeDayErr";

	String ERR_TradeDisabled = "ERR_TradeDisabled";
	String ERR_PriceErr = "ERR_PriceErr";
	String ERR_QueryNewIDFailed = "ERR_QueryNewIDFailed";
	String ERR_TooManyOrders = "ERR_TooManyOrders";
	String ERR_TooManyPositions = "ERR_TooManyPositions";
	String ERR_OutofNOPL = "ERR_OutofNOPL";
	String ERR_PreSellErr = "ERR_PreSellErr";

	String ERR_PasswordStore_Error = "ERR_PasswordStore_Error";// �Ҳ�����Ӧ�Ĵ�������
	String ERR_Password_is_Used = "ERR_Password_is_Used";// ���������Ѿ�ʹ��
	String ERR_Password_Locked = "ERR_Password_Locked";// �绰��������
	String ERR_Password_Disabled = "ERR_Password_Disabled";// �绰������ʧЧ
	String ERR_PasswordErr = "ERR_PasswordErr";
	String ERR_DealerPasswordErr = "ERR_DealerPasswordErr";
	String ERR_CA_Password_Err = "ERR_CA_Password_Err";

	String ERR_Groups_Error = "ERR_Groups_Error";// group����
	String ERR_FunctionId_or_Level_Error = "ERR_FunctionId_or_Level_Error";// functionId����level����
	String ERR_ReplaceGroupName_Error = "ERR_ReplaceGroupName_Error";// ת�Ƶ�group������
	String ERR_GroupName_equals_ReplaceGroupName = "ERR_GroupName_equals_ReplaceGroupName";// ɾ����Ŀ��group��ת�Ƶ�group��ͬ

	String ERR_UserDisabled = "ERR_UserDisabled";
	String ERR_UserNotFound = "ERR_UserNotFound";// �û�������
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
