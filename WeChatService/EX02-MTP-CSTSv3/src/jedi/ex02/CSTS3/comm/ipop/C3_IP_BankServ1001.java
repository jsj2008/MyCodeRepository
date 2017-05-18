package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.IP_BankServ1001;

/**
 * 银行出入金17:55:02
 * 
 * @author ALLONE
 * 
 */
public class C3_IP_BankServ1001 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_BankServ1001";

	// private long account;
	// private boolean needNotice;
	public static final String account = "1";
	public static final String needNotice = "2";
	public static final String bankId = "3";
	public static final String marketId = "4";

	public C3_IP_BankServ1001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_BankServ1001 formatIP() {
		IP_BankServ1001 ip = new IP_BankServ1001();
		ip.setNeedNotice(isNeedNotice());
		ip.setAccount(getAccount());
		ip.setMarketId(getMarketId());
		ip.setBankID(getBankId());
		return ip;
	}

	public boolean isNeedNotice() {
		try {
			boolean data = getEntryBoolean(C3_IP_BankServ1001.needNotice);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNeedNotice(boolean needNotice) {
		setEntry(C3_IP_BankServ1001.needNotice, needNotice);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_IP_BankServ1001.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_BankServ1001.account, account);
	}

	public int getMarketId() {
		try {
			return getEntryInt(C3_IP_BankServ1001.marketId);
		} catch (Exception e) {
			return 0;
		}
	}

	public void setMarketId(int marketId) {
		this.setEntry(C3_IP_BankServ1001.marketId, marketId);
	}

	public String getBankId() {
		try {
			return getEntryString(C3_IP_BankServ1001.bankId);
		} catch (Exception e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		this.setEntry(C3_IP_BankServ1001.bankId, bankID);
	}
}