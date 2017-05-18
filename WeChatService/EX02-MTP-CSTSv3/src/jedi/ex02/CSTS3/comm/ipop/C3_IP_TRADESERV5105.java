package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5105;


public class C3_IP_TRADESERV5105 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5105";

	public static final String account = "1";
	public static final String orderID = "2";
	public static final String accountDigist = "3";

	public C3_IP_TRADESERV5105(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5105 formatIP() {
		IP_TRADESERV5105 ip=new IP_TRADESERV5105();
		ip.setAccount(getAccount());
		ip.setOrderID(getOrderID());
		ip.setAccountDigist(getAccountDigist());
		return ip;
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5105.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_TRADESERV5105.account, account);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5105.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_IP_TRADESERV5105.orderID, orderID);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5105.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(C3_IP_TRADESERV5105.accountDigist, accountDigist);
	}


}