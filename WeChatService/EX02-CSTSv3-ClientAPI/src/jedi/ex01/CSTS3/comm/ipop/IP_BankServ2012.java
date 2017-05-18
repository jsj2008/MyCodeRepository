package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.client.station.api.bankserver.BankServClientIPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;

/**
 * 银行出入金相关,2016年8月8日17:55:15
 * 
 * @author ALLONE
 * 
 */
public class IP_BankServ2012 extends BankServClientIPFather {

	public static final String jsonId = "IP_BankServ2012";
	
	public static final String amount = "1";
	public static final String comment = "2";
	public static final String bankID = "3";

	public static final String streamID = "4";
	public static final String aeid = "5";
	public static final String password = "6";
	public static final String account = "7";

	public IP_BankServ2012() {
		super();
		setEntry("jsonId", jsonId);
	}

	public double getAmount() {
		try {
			double data = getEntryInt(IP_BankServ2012.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(IP_BankServ2012.amount, amount);
	}

	public String getComment() {
		try {
			String data = getEntryString(IP_BankServ2012.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String comment) {
		setEntry(IP_BankServ2012.comment, comment);
	}

	public String getBankID() {
		try {
			String data = getEntryString(IP_BankServ2012.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(IP_BankServ2012.bankID, bankID);
	}

	public long getStreamID() {
		try {
			long data = getEntryLong(IP_BankServ2012.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(IP_BankServ2012.streamID, streamID);
	}

	public String getaeid() {
		try {
			String data = getEntryString(IP_BankServ2012.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(IP_BankServ2012.aeid, aeid);
	}

	public String getPassword() {
		try {
			String data = getEntryString(IP_BankServ2012.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(IP_BankServ2012.password, password);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(IP_BankServ2012.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_BankServ2012.account, account);
	}

}