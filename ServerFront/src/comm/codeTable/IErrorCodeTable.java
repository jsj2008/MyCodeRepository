package comm.codeTable;

public interface IErrorCodeTable {
	
	public static final String errNoMacketFundRelationInDatabase = "ErrNoMacketFundRelationInDatabase";
	public static final String errLoadNormalAccountData="errLoadNormalAccountData";
	
	public static final String errHedgeFundReportInDatabase = "ErrNoHedgeFundReportInDatabase";

	public static final String errNetError = "ERR_NetError";
	public static final String errTimeout = "ERR_Timeout";
	public static final String errUnknown = "ERR_Unknown";
	public static final String errDbOperate = "ERR_DbOperate";
	public static final String errException = "ERR_Exception";

	public static final String errTradeDisabled = "ERR_TradeDisabled";
	public static final String errTradeIdInvalid = "ERR_TradeIDInvalid";
	public static final String errUserTransaction = "ERR_UserTransactionInvalid";

	public static final String errDealerNotFound = "ERR_DealerNotFound";
	public static final String errInvalidPassword = "ERR_InvalidPassword";
	public static final String errInvalidRoleInfo = "ERR_InvalidRoleInfo";

	public static final String errPartnerIdExist = "ERR_PartnerIdExist";
	public static final String errPartnerNotFound = "ERR_PartnerNotFound";
	public static final String errPartnerInvalid = "ERR_PartnerInvalid";
	public static final String errEixstPartnerModifyNotAudit = "ERR_EixstPartnerModifyNotAudit"; // 合伙人存在修改申请未审核，不能提交新的修改申请

	public static final String errUptradeGroupIsNull = "ERR_UptradeGroupIsNull";
	public static final String errUptradeGroupsExist = "ERR_UptradeGroupIsExist";

	public static final String errInvalidOptType = "errInvalidOptType";
	public static final String errAbsentFundID = "ErrAbsentFundID";
	public static final String errFundProfileNotFound = "ErrFundProfileNotFound";
	public static final String errHaveNullValue = "Err_HaveNullValue";
	public static final String errDealerNameIsExist = "Err_DealerNameIsExist";
	public static final String errDealerNameIsNotExist = "Err_DealerNameIsNotExist";
	public static final String errTradeFailed = "Err_TradeFailed";

	public static final String errTradeFundSysNotFound = "ErrTradeFundSysNotFound";
	public static final String errNoInstrumentInDatabase = "ErrNoInstrumentInDatabase";
	public static final String errFundSystemNotInited = "ErrFundSystemNotInited";
	public static final String errFundRiskDataNotFound = "ErrFundRiskDataNotFound";

	public static final String errDealerRoleIsExist = "ErrDealerRoleIsExist";
	public static final String errDealerRoleIsNotExist = "ErrDealerRoleIsNotExist";

	public static final String errInvalidInputData = "ErrInvalidInputData";
	public static final String errInvalidQueryPosition = "ErrInvalidQueryPosition";

	public static final String errUptradeFailed = "Err_UptradeFailed";
	public static final String errInvalidMarketClientId = "Err_InvalidMarketClientId";
	
	public static final String errOutOfRange = "Err_OutOfRange";
}
