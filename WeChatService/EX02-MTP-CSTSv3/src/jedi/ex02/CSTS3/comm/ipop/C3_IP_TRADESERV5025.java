package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5025;


public class C3_IP_TRADESERV5025 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5025";

	public static final String accountID = "1";

	public C3_IP_TRADESERV5025(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5025 formatIP() {
		IP_TRADESERV5025 ip=new IP_TRADESERV5025();
		ip.setAccountID(getAccountID());
		return ip;
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5025.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5025.accountID, accountID);
	}


}