package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.client.station.api.bankserver.BankServIPFather;

/**
 * 银行出入金相关,2016年8月8日17:55:02
 * 
 * @author ALLONE
 * 
 */
public class IP_BankServ1001 extends BankServIPFather {

	public static final String jsonId = "IP_BankServ1001";
	// private long account;
	// private boolean needNotice;
	public static final String account = "1";
	public static final String needNotice = "2";
	public static final String bankID = "3";
	public static final String marketId = "4";

	public IP_BankServ1001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public boolean isNeedNotice() {
		try {
			boolean data = getEntryBoolean(IP_BankServ1001.needNotice);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNeedNotice(boolean needNotice) {
		setEntry(IP_BankServ1001.needNotice, needNotice);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(IP_BankServ1001.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_BankServ1001.account, account);
	}

	public String getBankID() {
		try {
			String data = getEntryString(IP_BankServ1001.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(IP_BankServ1001.bankID, bankID);
	}

	public int getMarketId() {
		try {
			int data = getEntryInt(IP_BankServ1001.marketId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketId(int marketId) {
		setEntry(IP_BankServ1001.marketId, marketId);
	}

}