package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5015;


public class C3_IP_TRADESERV5015 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5015";

	public static final String instrumentName = "1";

	public C3_IP_TRADESERV5015(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5015 formatIP() {
		IP_TRADESERV5015 ip=new IP_TRADESERV5015();
		ip.setInstrumentName(getInstrumentName());
		return ip;
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5015.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(C3_IP_TRADESERV5015.instrumentName, instrumentName);
	}


}