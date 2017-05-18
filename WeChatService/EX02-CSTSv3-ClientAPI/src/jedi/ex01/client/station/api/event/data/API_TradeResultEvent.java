package jedi.ex01.client.station.api.event.data;

import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.client.station.api.event.API_IDEvent;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class API_TradeResultEvent extends API_IDEvent {
	private String tradeID;
	private boolean tradeResult;
	private String errorCode;

	private OPFather opFather;
	private IPFather ipFather;

	public API_TradeResultEvent(IPFather ipFather, OPFather opFather) {
		super(API_IDEvent_NameInterface.NAME_TRADERETURN);
		this.ipFather = ipFather;
		this.opFather = opFather;
		this.tradeID = ipFather.getID();
		this.tradeResult = opFather.isSucceed();
		errorCode = opFather.getErrCode();
	}

	public String getTradeID() {
		return tradeID;
	}

	public boolean isTradeResult() {
		return tradeResult;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public OPFather getOpFather() {
		return opFather;
	}

	public IPFather getIpFather() {
		return ipFather;
	}
}
