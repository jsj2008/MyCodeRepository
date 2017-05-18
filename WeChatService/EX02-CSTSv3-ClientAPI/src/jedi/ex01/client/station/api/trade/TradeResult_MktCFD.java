package jedi.ex01.client.station.api.trade;

import jedi.ex01.CSTS3.comm.struct.TOrderHis4CFD;
import jedi.ex01.CSTS3.proxy.comm.IPOPErrCodeTable;

public class TradeResult_MktCFD {
	public final static int RESULT_SUCCEED = 0;
	public final static int RESULT_PRICECHANGED = 1;
	public final static int RESULT_MD5DigestDontMatch = -1;
	public final static int RESULT_TradeDisabled = -2;
	public final static int RESULT_PriceErr = -3;
	public final static int RESULT_LotsErr = -4;
	public final static int RESULT_OutofNOPL = -5;
	public final static int RESULT_TooManyPositions = -6;
	public final static int RESULT_PreSellErr = -7;
	public final static int RESULT_MarginIsNotEnoughToTrade = -8;
	public final static int RESULT_UPTradeFailed = -9;
	public final static int RESULT_System_is_Close = -10;
	public final static int RESULT_otherErr = -100;

	private int result;
	private String _errCode = "";
	private String _errMessage = "";
	private double newMktPrice;
	private TOrderHis4CFD orderHis;

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

	public double getNewMktPrice() {
		return newMktPrice;
	}

	public void setNewMktPrice(double newMktPrice) {
		this.newMktPrice = newMktPrice;
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
		} else if (code.equals(IPOPErrCodeTable.ERR_OutofNOPL)) {
			result = RESULT_OutofNOPL;
		} else if (code.equals(IPOPErrCodeTable.ERR_TooManyPositions)) {
			result = RESULT_TooManyPositions;
		} else if (code.equals(IPOPErrCodeTable.ERR_PreSellErr)) {
			result = RESULT_PreSellErr;
		} else if (code
				.equals(IPOPErrCodeTable.ERR_MarginIsNotEnoughToTrade)) {
			result = RESULT_MarginIsNotEnoughToTrade;
		} else if (code.equals(IPOPErrCodeTable.ERR_UPTRADEFAILED)) {
			result = RESULT_UPTradeFailed;
		} else {
			result = RESULT_otherErr;
		}
	}

	public TOrderHis4CFD getOrderHis() {
		return orderHis;
	}

	public void setOrderHis(TOrderHis4CFD orderHis) {
		this.orderHis = orderHis;
	}
}
