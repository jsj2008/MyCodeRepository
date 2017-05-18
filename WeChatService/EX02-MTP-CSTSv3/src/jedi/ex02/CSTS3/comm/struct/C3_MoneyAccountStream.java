package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.MoneyAccountStream;

public class C3_MoneyAccountStream extends allone.json.AbstractJsonData {

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

	public C3_MoneyAccountStream(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(MoneyAccountStream data) throws Exception {
		setGuid(data.getGuid());
		setAccount(data.getAccount());
		setInstrument(data.getInstrument());
		setTicket(data.getTicket());
		setSplitno(data.getSplitNo());
		setCurrencyName(data.getCurrencyName());
		setType(data.getType());
		setAmount(data.getAmount());
		setTtype(data.getTtype());
		setTradeDay(data.getTradeDay());
		setStreamTime(data.getStreamTime());
		setComments(data.getComments());
		setUsername(data.getUserName());
		setUserType(data.getUserType());
		setIpAddress(data.getIPAddress());
		setOperateStreamGUID(data.getOperateStreamGUID());
	}

	public MoneyAccountStream format(){
		MoneyAccountStream data=new MoneyAccountStream();
		data.setGuid(getGuid());
		data.setAccount(getAccount());
		data.setInstrument(getInstrument());
		data.setTicket(getTicket());
		data.setSplitNo(getSplitno());
		data.setCurrencyName(getCurrencyName());
		data.setType(getType());
		data.setAmount(getAmount());
		data.setTtype(getTtype());
		data.setTradeDay(getTradeDay());
		data.setStreamTime(getStreamTime());
		data.setComments(getComments());
		data.setUserName(getUsername());
		data.setUserType(getUserType());
		data.setIPAddress(getIpAddress());
		data.setOperateStreamGUID(getOperateStreamGUID());
		return data;
	}


	public long getGuid() {
		try {
			long data=getEntryLong(C3_MoneyAccountStream.guid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuid(long guid) {
		setEntry(C3_MoneyAccountStream.guid, guid);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_MoneyAccountStream.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_MoneyAccountStream.account, account);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_MoneyAccountStream.instrument, instrument);
	}

	public long getTicket() {
		try {
			long data=getEntryLong(C3_MoneyAccountStream.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(C3_MoneyAccountStream.ticket, ticket);
	}

	public int getSplitno() {
		try {
			int data=getEntryInt(C3_MoneyAccountStream.splitno);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitno(int splitno) {
		setEntry(C3_MoneyAccountStream.splitno, splitno);
	}

	public String getCurrencyName() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(C3_MoneyAccountStream.currencyName, currencyName);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_MoneyAccountStream.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_MoneyAccountStream.type, type);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStream.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_MoneyAccountStream.amount, amount);
	}

	public int getTtype() {
		try {
			int data=getEntryInt(C3_MoneyAccountStream.ttype);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTtype(int ttype) {
		setEntry(C3_MoneyAccountStream.ttype, ttype);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_MoneyAccountStream.tradeDay, tradeDay);
	}

	public Date getStreamTime() {
		try {
			Date data=getEntryDate(C3_MoneyAccountStream.streamTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStreamTime(Date streamTime) {
		setEntry(C3_MoneyAccountStream.streamTime, streamTime);
	}

	public String getComments() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.comments);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComments(String comments) {
		setEntry(C3_MoneyAccountStream.comments, comments);
	}

	public String getUsername() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.username);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUsername(String username) {
		setEntry(C3_MoneyAccountStream.username, username);
	}

	public int getUserType() {
		try {
			int data=getEntryInt(C3_MoneyAccountStream.userType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUserType(int userType) {
		setEntry(C3_MoneyAccountStream.userType, userType);
	}

	public String getIpAddress() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(C3_MoneyAccountStream.ipAddress, ipAddress);
	}

	public String getOperateStreamGUID() {
		try {
			String data=getEntryString(C3_MoneyAccountStream.operateStreamGUID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOperateStreamGUID(String operateStreamGUID) {
		setEntry(C3_MoneyAccountStream.operateStreamGUID, operateStreamGUID);
	}


}