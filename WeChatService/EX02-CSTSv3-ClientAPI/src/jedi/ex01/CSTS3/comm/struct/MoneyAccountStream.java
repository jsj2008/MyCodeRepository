package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class MoneyAccountStream extends allone.json.AbstractJsonData {

	public static final String jsonId = "32";

	public static final String guid = "1";
	public static final String account = "2";
	public static final String instrument = "3";
	public static final String ticket = "4";
	public static final String splitno = "5";
	public static final String currencyName = "6";
	public static final String type = "7";
	public static final String amount = "8";
	public static final String ttype = "9";
	public static final String tradeDay = "10";
	public static final String streamTime = "11";
	public static final String comments = "12";
	public static final String username = "13";
	public static final String userType = "14";
	public static final String ipAddress = "15";
	public static final String operateStreamGUID = "16";

	public MoneyAccountStream(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getGuid() {
		try {
			long data=getEntryLong(MoneyAccountStream.guid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuid(long guid) {
		setEntry(MoneyAccountStream.guid, guid);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(MoneyAccountStream.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(MoneyAccountStream.account, account);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(MoneyAccountStream.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(MoneyAccountStream.instrument, instrument);
	}

	public long getTicket() {
		try {
			long data=getEntryLong(MoneyAccountStream.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(MoneyAccountStream.ticket, ticket);
	}

	public int getSplitno() {
		try {
			int data=getEntryInt(MoneyAccountStream.splitno);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitno(int splitno) {
		setEntry(MoneyAccountStream.splitno, splitno);
	}

	public String getCurrencyName() {
		try {
			String data=getEntryString(MoneyAccountStream.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(MoneyAccountStream.currencyName, currencyName);
	}

	public int getType() {
		try {
			int data=getEntryInt(MoneyAccountStream.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(MoneyAccountStream.type, type);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(MoneyAccountStream.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(MoneyAccountStream.amount, amount);
	}

	public int getTtype() {
		try {
			int data=getEntryInt(MoneyAccountStream.ttype);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTtype(int ttype) {
		setEntry(MoneyAccountStream.ttype, ttype);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(MoneyAccountStream.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(MoneyAccountStream.tradeDay, tradeDay);
	}

	public Date getStreamTime() {
		try {
			Date data=getEntryDate(MoneyAccountStream.streamTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStreamTime(Date streamTime) {
		setEntry(MoneyAccountStream.streamTime, streamTime);
	}

	public String getComments() {
		try {
			String data=getEntryString(MoneyAccountStream.comments);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComments(String comments) {
		setEntry(MoneyAccountStream.comments, comments);
	}

	public String getUsername() {
		try {
			String data=getEntryString(MoneyAccountStream.username);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUsername(String username) {
		setEntry(MoneyAccountStream.username, username);
	}

	public int getUserType() {
		try {
			int data=getEntryInt(MoneyAccountStream.userType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUserType(int userType) {
		setEntry(MoneyAccountStream.userType, userType);
	}

	public String getIpAddress() {
		try {
			String data=getEntryString(MoneyAccountStream.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(MoneyAccountStream.ipAddress, ipAddress);
	}

	public String getOperateStreamGUID() {
		try {
			String data=getEntryString(MoneyAccountStream.operateStreamGUID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOperateStreamGUID(String operateStreamGUID) {
		setEntry(MoneyAccountStream.operateStreamGUID, operateStreamGUID);
	}


}