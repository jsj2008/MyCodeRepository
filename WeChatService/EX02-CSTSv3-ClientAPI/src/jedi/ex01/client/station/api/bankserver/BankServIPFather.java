package jedi.ex01.client.station.api.bankserver;

import jedi.ex01.CSTS3.comm.ipop.IPFather;

public class BankServIPFather extends IPFather implements Cloneable {
	private static final long serialVersionUID = -8627772006313723920L;
	// private String bankID;
	private String ipAddr;
	// private int marketId;
	private int vipMktId;

	// public int getMarketId() {
	// return marketId;
	// }
	//
	// public void setMarketId(int marketId) {
	// this.marketId = marketId;
	// }

	public int getVipMktId() {
		return vipMktId;
	}

	public void setVipMktId(int vipMktId) {
		this.vipMktId = vipMktId;
	}

	// public String getBankID() {
	// return bankID;
	// }
	//
	// public void setBankID(String bankID) {
	// this.bankID = bankID;
	// }

	public String getIpAddr() {
		return ipAddr;
	}

	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}

	@Override
	public BankServIPFather clone() {
		try {
			return (BankServIPFather) super.clone();
		} catch (CloneNotSupportedException e) {
			return this;
		}

	}

}
