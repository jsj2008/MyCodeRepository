package jedi.ex01.client.station.api.trade;

import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.proxy.comm.IPOPErrCodeTable;

public class TradeResult_orderCFD {
	public final static int RESULT_SUCCEED = 0;
	public final static int RESULT_MD5DigestDontMatch = -1;
	public final static int RESULT_TradeDisabled = -2;
	public final static int RESULT_PriceErr = -3;
	public final static int RESULT_LotsErr = -4;
	public final static int RESULT_PreSellErr = -7;
	public final static int RESULT_System_is_Close = -10;
	public final static int RESULT_TooManyOrders=-11;
	public final static int RESULT_Parameter_Error=-12;
	public final static int RESULT_otherErr = -100;

	private int result;
	private String _errCode = "";
	private String _errMessage = "";
	private TOrders4CFD order;
	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public String get_errCode() {
		return _errCode;
	}

	public String get_errMessage() {
		return _errMessage;
	}

	public void set_errMessage(String message) {
		_errMessage = message;
	}

	public void setErrCodeAndCreateResult(String code) {
		_errCode = code;
		if (code == null) {
			return;
		} else if (code.equals(IPOPErrCodeTable.ERR_MD5DigestDontMatch)) {
			result = RESULT_MD5DigestDontMatch;
		} else if (code.equals(IPOPErrCodeTable.ERR_TradeDisabled)) {
			result = RESULT_TradeDisabled;
		} else if (code.equals(IPOPErrCodeTable.ERR_System_is_Close)) {
			result = RESULT_System_is_Close;
		} else if (code.equals(IPOPErrCodeTable.ERR_PriceErr)) {
			result = RESULT_PriceErr;
		} else if (code.equals(IPOPErrCodeTable.ERR_LotsErr)) {
			result = RESULT_LotsErr;
		} else if (code.equals(IPOPErrCodeTable.ERR_TooManyOrders)) {
			result = RESULT_TooManyOrders;
		} else if (code.equals(IPOPErrCodeTable.ERR_PreSellErr)) {
			result = RESULT_PreSellErr;
		} else if(code.equals(IPOPErrCodeTable.ERR_Parameter_Error)){
			result=RESULT_Parameter_Error;
		}else {
			result = RESULT_otherErr;
		}
	}

	public TOrders4CFD getOrder() {
		return order;
	}

	public void setOrder(TOrders4CFD order) {
		this.order = order;
	}
}