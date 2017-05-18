package jedi.ex01.CSTS3.comm.ipop;

import allone.crypto.Crypt;
import jedi.ex01.client.station.api.bankserver.BankServClientIPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;

/**
 * 银行出入金相关,2016年8月8日17:55:08
 * 
 * @author ALLONE
 * 
 */
public class IP_BankServ2011 extends BankServClientIPFather {

	public static final String jsonId = "IP_BankServ2011";
	// private double amount;
	// private String comment;

	public static final String amount = "1";
	public static final String comment = "2";
	public static final String bankID = "3";

	public static final String streamID = "4";
	public static final String aeid = "5";
	public static final String password = "6";
	public static final String account = "7";

	public IP_BankServ2011() {
		super();
		setEntry("jsonId", jsonId);
	}

	public double getAmount() {
		try {
			double data = getEntryDouble(IP_BankServ2011.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(IP_BankServ2011.amount, amount);
	}

	public String getComment() {
		try {
			String data = getEntryString(IP_BankServ2011.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String comment) {
		setEntry(IP_BankServ2011.comment, comment);
	}

	public String getBankID() {
		try {
			String data = getEntryString(IP_BankServ2011.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(IP_BankServ2011.bankID, bankID);
	}

	// private long streamID;
	// private String aeid;
	// private String password;
	// private long account;

	public long getStreamID() {
		try {
			long data = getEntryLong(IP_BankServ2011.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(IP_BankServ2011.streamID, streamID);
	}

	public String getAeid() {
		try {
			String data = getEntryString(IP_BankServ2011.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(IP_BankServ2011.aeid, aeid);
	}

	public String getPassword() {
		try {
			String data = getEntryString(IP_BankServ2011.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(IP_BankServ2011.password, password);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(IP_BankServ2011.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_BankServ2011.account, account);
	}

}