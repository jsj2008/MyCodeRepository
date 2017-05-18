package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.client.station.api.bankserver.BankServIPFather;

/**
 * 银行出入金相关,2016年8月8日17:55:02
 * 
 * @author ALLONE
 * 
 */
public class IP_BankServ2001 extends BankServIPFather {

	public static final String jsonId = "IP_BankServ2001";

	public static final String orderType = "1";
	public static final String streamID = "2";
	public static final String aeid = "3";
	public static final String password = "4";
	public static final String account = "5";
	public static final String bankID = "6";

	public IP_BankServ2001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public String getOrderType() {
		try {
			String data = getEntryString(IP_BankServ2001.orderType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderType(String orderType) {
		setEntry(IP_BankServ2001.orderType, orderType);
	}

	public long getStreamID() {
		try {
			long data = getEntryLong(IP_BankServ2001.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(IP_BankServ2001.streamID, streamID);
	}

	// private String orderType;
	// private long streamID;

	// private String aeid;
	// private String password;
	// private long account;

	public String getAeid() {
		try {
			String data = getEntryString(IP_BankServ2001.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(IP_BankServ2001.aeid, aeid);
	}

	public String getPassword() {
		try {
			String data = getEntryString(IP_BankServ2001.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(IP_BankServ2001.password, password);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(IP_BankServ2001.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_BankServ2001.account, account);
	}

	public String getBankID() {
		try {
			String data = getEntryString(IP_BankServ2001.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(IP_BankServ2001.bankID, bankID);
	}

}