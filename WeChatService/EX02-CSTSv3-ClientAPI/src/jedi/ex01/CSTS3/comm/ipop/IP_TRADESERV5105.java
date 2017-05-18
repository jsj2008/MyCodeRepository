package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5105 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5105";

	public static final String account = "1";
	public static final String orderID = "2";
	public static final String accountDigist = "3";

	public IP_TRADESERV5105(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(IP_TRADESERV5105.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_TRADESERV5105.account, account);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(IP_TRADESERV5105.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(IP_TRADESERV5105.orderID, orderID);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(IP_TRADESERV5105.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(IP_TRADESERV5105.accountDigist, accountDigist);
	}


}