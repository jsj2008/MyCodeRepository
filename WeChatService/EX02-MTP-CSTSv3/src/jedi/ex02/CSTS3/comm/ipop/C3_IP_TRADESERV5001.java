package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5001;

public class C3_IP_TRADESERV5001 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5001";

	public static final String password = "1";
	public static final String firstLogin = "2";
	public static final String firstLoginTime = "3";
	public static final String iPAddress = "4";
	public static final String type = "5";

	public C3_IP_TRADESERV5001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5001 formatIP() {
		IP_TRADESERV5001 ip = new IP_TRADESERV5001();
		ip.setPassword(getPassword());
		ip.setFirstLogin(isFirstLogin());
		ip.setFirstLoginTime(getFirstLoginTime());
		ip.setIPAddress(getIPAddress());
		ip.setAeid(getUserName());
		ip.setType(getType());
		return ip;
	}

	public String getPassword() {
		try {
			String data = getEntryString(C3_IP_TRADESERV5001.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(C3_IP_TRADESERV5001.password, password);
	}

	public boolean isFirstLogin() {
		try {
			boolean data = getEntryBoolean(C3_IP_TRADESERV5001.firstLogin);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setFirstLogin(boolean firstLogin) {
		setEntry(C3_IP_TRADESERV5001.firstLogin, firstLogin);
	}

	public long getFirstLoginTime() {
		try {
			long data = getEntryLong(C3_IP_TRADESERV5001.firstLoginTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFirstLoginTime(long firstLoginTime) {
		setEntry(C3_IP_TRADESERV5001.firstLoginTime, firstLoginTime);
	}

	public String getIPAddress() {
		try {
			String data = getEntryString(C3_IP_TRADESERV5001.iPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIPAddress(String iPAddress) {
		setEntry(C3_IP_TRADESERV5001.iPAddress, iPAddress);
	}

	public int getType() {
		try {
			return getEntryInt(C3_IP_TRADESERV5001.type);
		} catch (Exception ex) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_IP_TRADESERV5001.type, type);
	}

}