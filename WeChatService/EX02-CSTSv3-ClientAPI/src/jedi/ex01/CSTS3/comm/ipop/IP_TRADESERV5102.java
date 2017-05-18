package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5102 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5102";

	public static final String accountID = "1";
	public static final String instrument = "2";
	public static final String stickets = "3";
	public static final String antiTickets = "4";
	public static final String accountDigist = "5";

	public IP_TRADESERV5102(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(IP_TRADESERV5102.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(IP_TRADESERV5102.accountID, accountID);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(IP_TRADESERV5102.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(IP_TRADESERV5102.instrument, instrument);
	}

	public String getStickets() {
		try {
			String data=getEntryString(IP_TRADESERV5102.stickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStickets(String stickets) {
		setEntry(IP_TRADESERV5102.stickets, stickets);
	}

	public String getAntiTickets() {
		try {
			String data=getEntryString(IP_TRADESERV5102.antiTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAntiTickets(String antiTickets) {
		setEntry(IP_TRADESERV5102.antiTickets, antiTickets);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(IP_TRADESERV5102.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(IP_TRADESERV5102.accountDigist, accountDigist);
	}


}