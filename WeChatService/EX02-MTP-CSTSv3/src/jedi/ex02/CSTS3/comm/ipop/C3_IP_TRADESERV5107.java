package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5107;


public class C3_IP_TRADESERV5107 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5107";

	public static final String uptradeOperatorID = "1";

	public C3_IP_TRADESERV5107(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5107 formatIP() {
		IP_TRADESERV5107 ip=new IP_TRADESERV5107();
		ip.setUptradeOperatorID(getUptradeOperatorID());
		return ip;
	}

	public String getUptradeOperatorID() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5107.uptradeOperatorID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUptradeOperatorID(String uptradeOperatorID) {
		setEntry(C3_IP_TRADESERV5107.uptradeOperatorID, uptradeOperatorID);
	}


}