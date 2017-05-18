package jedi.ex01.client.station.api.bankserver;

import jedi.ex01.CSTS3.comm.ipop.IPFather;

public class TradeServIPFather extends IPFather {
	private static final long serialVersionUID = -3790182855666819902L;
	int submitTradeType = 0;
	String IPAddress;
	// String dealerName;
	// String aeid;
	String submitOperatorName = "SYSTEM";

	public String getSubmitOperatorName() {
		return submitOperatorName;
	}

	public void setSubmitOperatorName(String submitOperatorName) {
		this.submitOperatorName = submitOperatorName;
	}

	public String getIPAddress() {
		return IPAddress;
	}

	public void setIPAddress(String address) {
		IPAddress = address;
	}

	// public String getDealerName() {
	// return dealerName;
	// }
	//
	// public void setDealerName(String dealerName) {
	// this.dealerName = dealerName;
	// }
	//
	// public String getAeid() {
	// return aeid;
	// }
	//
	// public void setAeid(String aeid) {
	// this.aeid = aeid;
	// }

	public int getSubmitTradeType() {
		return submitTradeType;
	}

	public void setSubmitTradeType(int submitTradeType) {
		this.submitTradeType = submitTradeType;
	}
}
