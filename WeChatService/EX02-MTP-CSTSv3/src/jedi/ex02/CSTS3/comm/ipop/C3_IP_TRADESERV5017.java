package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5017;


public class C3_IP_TRADESERV5017 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5017";

	public static final String groupName = "1";

	public C3_IP_TRADESERV5017(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5017 formatIP() {
		IP_TRADESERV5017 ip=new IP_TRADESERV5017();
		ip.setGroupName(getGroupName());
		return ip;
	}

	public String getGroupName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5017.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_IP_TRADESERV5017.groupName, groupName);
	}


}