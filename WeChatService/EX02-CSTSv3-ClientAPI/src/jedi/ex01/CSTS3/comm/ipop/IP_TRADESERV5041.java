package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5041 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5041";

	public static final String accountID = "1";

	public IP_TRADESERV5041(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(IP_TRADESERV5041.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(IP_TRADESERV5041.accountID, accountID);
	}


}