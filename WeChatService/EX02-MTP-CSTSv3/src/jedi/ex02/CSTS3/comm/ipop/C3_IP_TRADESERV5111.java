package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5111;


public class C3_IP_TRADESERV5111 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5111";

	public static final String accountID = "1";
	public static final String balanceWay = "2";

	public C3_IP_TRADESERV5111(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5111 formatIP() {
		IP_TRADESERV5111 ip=new IP_TRADESERV5111();
		ip.setAccountID(getAccountID());
		ip.setBalanceWay(getBalanceWay());
		return ip;
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5111.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5111.accountID, accountID);
	}

	public int getBalanceWay() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5111.balanceWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBalanceWay(int balanceWay) {
		setEntry(C3_IP_TRADESERV5111.balanceWay, balanceWay);
	}


}