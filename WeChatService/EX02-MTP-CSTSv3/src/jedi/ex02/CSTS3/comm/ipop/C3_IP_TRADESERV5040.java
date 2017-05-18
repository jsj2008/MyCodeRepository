package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5040;


public class C3_IP_TRADESERV5040 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5040";

	public static final String userName = "1";
	public static final String accountID = "2";

	public C3_IP_TRADESERV5040(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5040 formatIP() {
		IP_TRADESERV5040 ip=new IP_TRADESERV5040();
		ip.setUserName(getUserName());
		return ip;
	}

	public String getUserName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5040.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(C3_IP_TRADESERV5040.userName, userName);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5040.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5040.accountID, accountID);
	}


}