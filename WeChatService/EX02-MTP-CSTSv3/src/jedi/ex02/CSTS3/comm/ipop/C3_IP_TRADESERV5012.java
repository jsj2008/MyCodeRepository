package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5012;


public class C3_IP_TRADESERV5012 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5012";

	public static final String instrumentTypeName = "1";

	public C3_IP_TRADESERV5012(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5012 formatIP() {
		IP_TRADESERV5012 ip=new IP_TRADESERV5012();
		ip.setInstrumentTypeName(getInstrumentTypeName());
		return ip;
	}

	public String getInstrumentTypeName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5012.instrumentTypeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentTypeName(String instrumentTypeName) {
		setEntry(C3_IP_TRADESERV5012.instrumentTypeName, instrumentTypeName);
	}


}