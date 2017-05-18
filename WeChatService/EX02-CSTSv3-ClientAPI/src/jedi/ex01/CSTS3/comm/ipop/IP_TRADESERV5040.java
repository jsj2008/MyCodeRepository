package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5040 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5040";

	public static final String userName = "1";
	public static final String accountID = "2";

	public IP_TRADESERV5040(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getUserName() {
		try {
			String data=getEntryString(IP_TRADESERV5040.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(IP_TRADESERV5040.userName, userName);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(IP_TRADESERV5040.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(IP_TRADESERV5040.accountID, accountID);
	}


}