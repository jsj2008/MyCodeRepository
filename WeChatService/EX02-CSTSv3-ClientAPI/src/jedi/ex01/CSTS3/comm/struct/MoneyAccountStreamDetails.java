package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class MoneyAccountStreamDetails extends allone.json.AbstractJsonData {

	public static final String jsonId = "34";

	public static final String guid = "1";
	public static final String account = "2";
	public static final String aeid = "3";
	public static final String instrument = "4";
	public static final String ticket = "5";
	public static final String splitNo = "6";
	public static final String type = "7";
	public static final String amount = "8";
	public static final String ttype = "9";
	public static final String tradeDay = "10";
	public static final String streamTime = "11";
	public static final String comments = "12";
	public static final String currency = "13";
	public static final String buysell = "14";
	public static final String lots = "15";
	public static final String openprice = "16";
	public static final String closeprice = "17";
	public static final String beginBalance = "18";
	public static final String endBalance = "19";
	public static final String userName = "20";
	public static final String userType = "21";
	public static final String ipAddress = "22";
	public static final String operateStreamGUID = "23";

	public MoneyAccountStreamDetails(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getGuid() {
		try {
			long data=getEntryLong(MoneyAccountStreamDetails.guid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuid(long guid) {
		setEntry(MoneyAccountStreamDetails.guid, guid);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(MoneyAccountStreamDetails.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(MoneyAccountStreamDetails.account, account);
	}

	public String getAeid() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(MoneyAccountStreamDetails.aeid, aeid);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(MoneyAccountStreamDetails.instrument, instrument);
	}

	public long getTicket() {
		try {
			long data=getEntryLong(MoneyAccountStreamDetails.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(MoneyAccountStreamDetails.ticket, ticket);
	}

	public int getSplitNo() {
		try {
			int data=getEntryInt(MoneyAccountStreamDetails.splitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitNo(int splitNo) {
		setEntry(MoneyAccountStreamDetails.splitNo, splitNo);
	}

	public int getType() {
		try {
			int data=getEntryInt(MoneyAccountStreamDetails.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(MoneyAccountStreamDetails.type, type);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(MoneyAccountStreamDetails.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(MoneyAccountStreamDetails.amount, amount);
	}

	public int getTtype() {
		try {
			int data=getEntryInt(MoneyAccountStreamDetails.ttype);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTtype(int ttype) {
		setEntry(MoneyAccountStreamDetails.ttype, ttype);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(MoneyAccountStreamDetails.tradeDay, tradeDay);
	}

	public Date getStreamTime() {
		try {
			Date data=getEntryDate(MoneyAccountStreamDetails.streamTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStreamTime(Date streamTime) {
		setEntry(MoneyAccountStreamDetails.streamTime, streamTime);
	}

	public String getComments() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.comments);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComments(String comments) {
		setEntry(MoneyAccountStreamDetails.comments, comments);
	}

	public String getCurrency() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(MoneyAccountStreamDetails.currency, currency);
	}

	public int getBuysell() {
		try {
			int data=getEntryInt(MoneyAccountStreamDetails.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(MoneyAccountStreamDetails.buysell, buysell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(MoneyAccountStreamDetails.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(MoneyAccountStreamDetails.lots, lots);
	}

	public double getOpenprice() {
		try {
			double data=getEntryDouble(MoneyAccountStreamDetails.openprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenprice(double openprice) {
		setEntry(MoneyAccountStreamDetails.openprice, openprice);
	}

	public double getCloseprice() {
		try {
			double data=getEntryDouble(MoneyAccountStreamDetails.closeprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseprice(double closeprice) {
		setEntry(MoneyAccountStreamDetails.closeprice, closeprice);
	}

	public double getBeginBalance() {
		try {
			double data=getEntryDouble(MoneyAccountStreamDetails.beginBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBeginBalance(double beginBalance) {
		setEntry(MoneyAccountStreamDetails.beginBalance, beginBalance);
	}

	public double getEndBalance() {
		try {
			double data=getEntryDouble(MoneyAccountStreamDetails.endBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setEndBalance(double endBalance) {
		setEntry(MoneyAccountStreamDetails.endBalance, endBalance);
	}

	public String getUserName() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(MoneyAccountStreamDetails.userName, userName);
	}

	public int getUserType() {
		try {
			int data=getEntryInt(MoneyAccountStreamDetails.userType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUserType(int userType) {
		setEntry(MoneyAccountStreamDetails.userType, userType);
	}

	public String getIpAddress() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(MoneyAccountStreamDetails.ipAddress, ipAddress);
	}

	public String getOperateStreamGUID() {
		try {
			String data=getEntryString(MoneyAccountStreamDetails.operateStreamGUID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOperateStreamGUID(String operateStreamGUID) {
		setEntry(MoneyAccountStreamDetails.operateStreamGUID, operateStreamGUID);
	}


}