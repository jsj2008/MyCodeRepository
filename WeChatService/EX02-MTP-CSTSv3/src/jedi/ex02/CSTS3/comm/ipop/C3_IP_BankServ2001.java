package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.IP_BankServ2001;

/**
 * 银行出入金17:55:02
 * 
 * @author ALLONE
 * 
 */
public class C3_IP_BankServ2001 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_BankServ2001";

	public static final String orderType = "1";
	public static final String streamID = "2";
	public static final String aeid = "3";
	public static final String password = "4";
	public static final String account = "5";
	public static final String bankID = "6";

	public C3_IP_BankServ2001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_BankServ2001 formatIP() {
		IP_BankServ2001 ip = new IP_BankServ2001();
		ip.setOrderType(getOrderType());
		ip.setStreamID(getStreamID());
		ip.setAeid(getAeid());
		ip.setPassword(getPassword());
		ip.setAccount(getAccount());
		ip.setBankID(getBankID());
		return ip;
	}

	public String getOrderType() {
		try {
			String data = getEntryString(C3_IP_BankServ2001.orderType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderType(String orderType) {
		setEntry(C3_IP_BankServ2001.orderType, orderType);
	}

	public long getStreamID() {
		try {
			long data = getEntryLong(C3_IP_BankServ2001.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(C3_IP_BankServ2001.streamID, streamID);
	}

	// private String orderType;
	// private long streamID;

	// private String aeid;
	// private String password;
	// private long account;

	public String getAeid() {
		try {
			String data = getEntryString(C3_IP_BankServ2001.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_IP_BankServ2001.aeid, aeid);
	}

	public String getPassword() {
		try {
			String data = getEntryString(C3_IP_BankServ2001.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(C3_IP_BankServ2001.password, password);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_IP_BankServ2001.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_BankServ2001.account, account);
	}

	public String getBankID() {
		try {
			String data = getEntryString(C3_IP_BankServ2001.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(C3_IP_BankServ2001.bankID, bankID);
	}

}