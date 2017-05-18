package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5108 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5108";

	public static final String account = "1";
	public static final String orderID = "2";
	public static final String stopMove = "3";

	public IP_TRADESERV5108(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(IP_TRADESERV5108.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_TRADESERV5108.account, account);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(IP_TRADESERV5108.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(IP_TRADESERV5108.orderID, orderID);
	}

	public int getStopMove() {
		try {
			int data=getEntryInt(IP_TRADESERV5108.stopMove);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMove(int stopMove) {
		setEntry(IP_TRADESERV5108.stopMove, stopMove);
	}


}