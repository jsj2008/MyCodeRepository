package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.AccountShortInfo;

public class C3_AccountShortInfo extends allone.json.AbstractJsonData {

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

	public C3_AccountShortInfo(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(AccountShortInfo data) throws Exception {
		setAccount(data.getAccount());
		setAeid(data.getAeid());
		setAcname(data.getAcname());
		setGroupName(data.getGroupName());
		setIbac(data.getIbac());
		setRealName(data.getRealName());
		setBalanceCurrency(data.getBalanceCurrency());
		setCashBalance(data.getCashBalance());
		setEquity(data.getEquity());
		setUsedMargin(data.getUsedMargin());
		setFirstTradeTime(data.getFirstTradeTime());
		setLastTradeTime(data.getLastTradeTime());
	}

	public AccountShortInfo format(){
		AccountShortInfo data=new AccountShortInfo();
		data.setAccount(getAccount());
		data.setAeid(getAeid());
		data.setAcname(getAcname());
		data.setGroupName(getGroupName());
		data.setIbac(getIbac());
		data.setRealName(getRealName());
		data.setBalanceCurrency(getBalanceCurrency());
		data.setCashBalance(getCashBalance());
		data.setEquity(getEquity());
		data.setUsedMargin(getUsedMargin());
		data.setFirstTradeTime(getFirstTradeTime());
		data.setLastTradeTime(getLastTradeTime());
		return data;
	}


	public long getAccount() {
		try {
			long data=getEntryLong(C3_AccountShortInfo.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_AccountShortInfo.account, account);
	}

	public String getAeid() {
		try {
			String data=getEntryString(C3_AccountShortInfo.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_AccountShortInfo.aeid, aeid);
	}

	public String getAcname() {
		try {
			String data=getEntryString(C3_AccountShortInfo.acname);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAcname(String acname) {
		setEntry(C3_AccountShortInfo.acname, acname);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(C3_AccountShortInfo.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_AccountShortInfo.groupName, groupName);
	}

	public long getIbac() {
		try {
			long data=getEntryLong(C3_AccountShortInfo.ibac);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIbac(long ibac) {
		setEntry(C3_AccountShortInfo.ibac, ibac);
	}

	public String getRealName() {
		try {
			String data=getEntryString(C3_AccountShortInfo.realName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRealName(String realName) {
		setEntry(C3_AccountShortInfo.realName, realName);
	}

	public String getBalanceCurrency() {
		try {
			String data=getEntryString(C3_AccountShortInfo.balanceCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBalanceCurrency(String balanceCurrency) {
		setEntry(C3_AccountShortInfo.balanceCurrency, balanceCurrency);
	}

	public double getCashBalance() {
		try {
			double data=getEntryDouble(C3_AccountShortInfo.cashBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCashBalance(double cashBalance) {
		setEntry(C3_AccountShortInfo.cashBalance, cashBalance);
	}

	public double getEquity() {
		try {
			double data=getEntryDouble(C3_AccountShortInfo.equity);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setEquity(double equity) {
		setEntry(C3_AccountShortInfo.equity, equity);
	}

	public double getUsedMargin() {
		try {
			double data=getEntryDouble(C3_AccountShortInfo.usedMargin);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUsedMargin(double usedMargin) {
		setEntry(C3_AccountShortInfo.usedMargin, usedMargin);
	}

	public Date getFirstTradeTime() {
		try {
			Date data=getEntryDate(C3_AccountShortInfo.firstTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		setEntry(C3_AccountShortInfo.firstTradeTime, firstTradeTime);
	}

	public Date getLastTradeTime() {
		try {
			Date data=getEntryDate(C3_AccountShortInfo.lastTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastTradeTime(Date lastTradeTime) {
		setEntry(C3_AccountShortInfo.lastTradeTime, lastTradeTime);
	}


}