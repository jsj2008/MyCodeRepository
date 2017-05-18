package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5013;


public class C3_IP_TRADESERV5013 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5013";

	public static final String instrumentName = "1";
	public static final String accountId = "2";
	public static final String groupName = "3";

	public C3_IP_TRADESERV5013(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5013 formatIP() {
		IP_TRADESERV5013 ip=new IP_TRADESERV5013();
		ip.setInstrumentName(getInstrumentName());
		return ip;
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5013.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(C3_IP_TRADESERV5013.instrumentName, instrumentName);
	}

	public long getAccountId() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5013.accountId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountId(long accountId) {
		setEntry(C3_IP_TRADESERV5013.accountId, accountId);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5013.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_IP_TRADESERV5013.groupName, groupName);
	}


}