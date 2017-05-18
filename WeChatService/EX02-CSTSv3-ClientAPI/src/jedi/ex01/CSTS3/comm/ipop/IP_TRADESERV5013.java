package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5013 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5013";

	public static final String instrumentName = "1";
	public static final String accountId = "2";
	public static final String groupName = "3";

	public IP_TRADESERV5013(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(IP_TRADESERV5013.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(IP_TRADESERV5013.instrumentName, instrumentName);
	}

	public long getAccountId() {
		try {
			long data=getEntryLong(IP_TRADESERV5013.accountId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountId(long accountId) {
		setEntry(IP_TRADESERV5013.accountId, accountId);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(IP_TRADESERV5013.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(IP_TRADESERV5013.groupName, groupName);
	}


}