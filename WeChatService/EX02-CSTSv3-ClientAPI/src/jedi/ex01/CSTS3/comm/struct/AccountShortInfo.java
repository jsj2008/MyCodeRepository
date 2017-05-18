package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class AccountShortInfo extends allone.json.AbstractJsonData {

	public static final String jsonId = "1";

	public static final String account = "1";
	public static final String aeid = "2";
	public static final String acname = "3";
	public static final String groupName = "4";
	public static final String ibac = "5";
	public static final String realName = "6";
	public static final String balanceCurrency = "7";
	public static final String cashBalance = "8";
	public static final String equity = "9";
	public static final String usedMargin = "10";
	public static final String firstTradeTime = "11";
	public static final String lastTradeTime = "12";

	public AccountShortInfo(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(AccountShortInfo.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(AccountShortInfo.account, account);
	}

	public String getAeid() {
		try {
			String data=getEntryString(AccountShortInfo.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(AccountShortInfo.aeid, aeid);
	}

	public String getAcname() {
		try {
			String data=getEntryString(AccountShortInfo.acname);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAcname(String acname) {
		setEntry(AccountShortInfo.acname, acname);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(AccountShortInfo.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(AccountShortInfo.groupName, groupName);
	}

	public long getIbac() {
		try {
			long data=getEntryLong(AccountShortInfo.ibac);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIbac(long ibac) {
		setEntry(AccountShortInfo.ibac, ibac);
	}

	public String getRealName() {
		try {
			String data=getEntryString(AccountShortInfo.realName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRealName(String realName) {
		setEntry(AccountShortInfo.realName, realName);
	}

	public String getBalanceCurrency() {
		try {
			String data=getEntryString(AccountShortInfo.balanceCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBalanceCurrency(String balanceCurrency) {
		setEntry(AccountShortInfo.balanceCurrency, balanceCurrency);
	}

	public double getCashBalance() {
		try {
			double data=getEntryDouble(AccountShortInfo.cashBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCashBalance(double cashBalance) {
		setEntry(AccountShortInfo.cashBalance, cashBalance);
	}

	public double getEquity() {
		try {
			double data=getEntryDouble(AccountShortInfo.equity);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setEquity(double equity) {
		setEntry(AccountShortInfo.equity, equity);
	}

	public double getUsedMargin() {
		try {
			double data=getEntryDouble(AccountShortInfo.usedMargin);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUsedMargin(double usedMargin) {
		setEntry(AccountShortInfo.usedMargin, usedMargin);
	}

	public Date getFirstTradeTime() {
		try {
			Date data=getEntryDate(AccountShortInfo.firstTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		setEntry(AccountShortInfo.firstTradeTime, firstTradeTime);
	}

	public Date getLastTradeTime() {
		try {
			Date data=getEntryDate(AccountShortInfo.lastTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastTradeTime(Date lastTradeTime) {
		setEntry(AccountShortInfo.lastTradeTime, lastTradeTime);
	}


}