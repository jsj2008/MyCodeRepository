package jedi.ex01.client.station.api.trade;

import jedi.ex01.CSTS3.comm.struct.TOrderHis4CFD;
import jedi.ex01.CSTS3.proxy.comm.IPOPErrCodeTable;

public class TradeResult_HedgeCFD {
	public final static int RESULT_SUCCEED = 0;	
	public final static int RESULT_MD5DigestDontMatch = -1;
	public final static int RESULT_TradeDisabled = -2;
	public final static int RESULT_PriceErr = -3;
	public final static int RESULT_System_is_Close = -10;
	public final static int RESULT_otherErr = -100;
	
	private int result;
	private String _errCode = "";
	private String _errMessage = "";
	private TOrderHis4CFD orderHis;
	public TOrderHis4CFD getOrderHis() {
		return orderHis;
	}

	public void setOrderHis(TOrderHis4CFD orderHis) {
		this.orderHis = orderHis;
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
		} else {
			result = RESULT_otherErr;
		}
	}

	public int getResult() {
		return result;
	}
}
