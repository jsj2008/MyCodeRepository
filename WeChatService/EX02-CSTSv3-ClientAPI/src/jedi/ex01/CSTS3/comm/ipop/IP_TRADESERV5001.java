package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5001 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5001";

	public static final String password = "1";
	public static final String firstLogin = "2";
	public static final String firstLoginTime = "3";
	public static final String iPAddress = "4";

	public IP_TRADESERV5001(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getPassword() {
		try {
			String data=getEntryString(IP_TRADESERV5001.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(IP_TRADESERV5001.password, password);
	}

	public boolean isFirstLogin() {
		try {
			boolean data=getEntryBoolean(IP_TRADESERV5001.firstLogin);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setFirstLogin(boolean firstLogin) {
		setEntry(IP_TRADESERV5001.firstLogin, firstLogin);
	}

	public long getFirstLoginTime() {
		try {
			long data=getEntryLong(IP_TRADESERV5001.firstLoginTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFirstLoginTime(long firstLoginTime) {
		setEntry(IP_TRADESERV5001.firstLoginTime, firstLoginTime);
	}

	public String getIPAddress() {
		try {
			String data=getEntryString(IP_TRADESERV5001.iPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIPAddress(String iPAddress) {
		setEntry(IP_TRADESERV5001.iPAddress, iPAddress);
	}


}