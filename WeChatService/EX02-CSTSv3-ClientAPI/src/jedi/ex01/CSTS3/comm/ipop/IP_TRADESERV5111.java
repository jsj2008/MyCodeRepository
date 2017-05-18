package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5111 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5111";

	public static final String accountID = "1";
	public static final String balanceWay = "2";

	public IP_TRADESERV5111(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(IP_TRADESERV5111.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(IP_TRADESERV5111.accountID, accountID);
	}

	public int getBalanceWay() {
		try {
			int data=getEntryInt(IP_TRADESERV5111.balanceWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBalanceWay(int balanceWay) {
		setEntry(IP_TRADESERV5111.balanceWay, balanceWay);
	}


}