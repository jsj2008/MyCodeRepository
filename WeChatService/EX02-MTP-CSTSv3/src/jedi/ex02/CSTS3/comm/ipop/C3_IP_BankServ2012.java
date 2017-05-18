package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.IP_BankServ2012;

/**
 * 银行出入金相关,17:55:15
 * 
 * @author ALLONE
 * 
 */
public class C3_IP_BankServ2012 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_BankServ2012";

	public static final String amount = "1";
	public static final String comment = "2";
	public static final String bankId = "3";

	public static final String streamID = "4";
	public static final String aeid = "5";
	public static final String password = "6";
	public static final String account = "7";

	public C3_IP_BankServ2012() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_BankServ2012 formatIP() {
		IP_BankServ2012 ip = new IP_BankServ2012();
		ip.setAmount(getAmount());
		ip.setComment(getComment());
		ip.setBankID(getBankId());

		ip.setStreamID(getStreamID());
		ip.setAeid(getAeid());
		ip.setPassword(getPassword());
		ip.setAccount(getAccount());

		return ip;
	}

	public double getAmount() {
		try {
			double data = getEntryDouble(C3_IP_BankServ2012.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_IP_BankServ2012.amount, amount);
	}

	public String getComment() {
		try {
			String data = getEntryString(C3_IP_BankServ2012.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String comment) {
		setEntry(C3_IP_BankServ2012.comment, comment);
	}

	public String getBankId() {
		try {
			return getEntryString(C3_IP_BankServ2012.bankId);
		} catch (Exception e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		this.setEntry(C3_IP_BankServ2012.bankId, bankID);
	}

	public long getStreamID() {
		try {
			long data = getEntryLong(C3_IP_BankServ2012.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(C3_IP_BankServ2012.streamID, streamID);
	}

	public String getAeid() {
		try {
			String data = getEntryString(C3_IP_BankServ2012.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_IP_BankServ2012.aeid, aeid);
	}

	public String getPassword() {
		try {
			String data = getEntryString(C3_IP_BankServ2012.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(C3_IP_BankServ2012.password, password);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_IP_BankServ2012.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_BankServ2012.account, account);
	}

}