package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5062;


public class C3_IP_TRADESERV5062 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5062";

	public static final String messageGuid = "1";

	public C3_IP_TRADESERV5062(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5062 formatIP() {
		IP_TRADESERV5062 ip=new IP_TRADESERV5062();
		ip.setMessageGuid(getMessageGuid());
		return ip;
	}

	public String getMessageGuid() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5062.messageGuid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessageGuid(String messageGuid) {
		setEntry(C3_IP_TRADESERV5062.messageGuid, messageGuid);
	}


}