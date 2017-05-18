package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5108;


public class C3_IP_TRADESERV5108 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5108";

	public static final String account = "1";
	public static final String orderID = "2";
	public static final String stopMove = "3";

	public C3_IP_TRADESERV5108(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5108 formatIP() {
		IP_TRADESERV5108 ip=new IP_TRADESERV5108();
		ip.setAccount(getAccount());
		ip.setOrderID(getOrderID());
		ip.setStopMove(getStopMove());
		return ip;
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5108.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_TRADESERV5108.account, account);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5108.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_IP_TRADESERV5108.orderID, orderID);
	}

	public int getStopMove() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5108.stopMove);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMove(int stopMove) {
		setEntry(C3_IP_TRADESERV5108.stopMove, stopMove);
	}


}