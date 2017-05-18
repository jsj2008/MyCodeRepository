package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.report.server.struct.MoneyAccountStreamDetails;

public class C3_MoneyAccountStreamDetails extends allone.json.AbstractJsonData {

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

	public C3_MoneyAccountStreamDetails(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(MoneyAccountStreamDetails data) throws Exception {
		setGuid(data.getGuid());
		setAccount(data.getAccount());
		setAeid(data.getAeid());
		setInstrument(data.getInstrument());
		setTicket(data.getTicket());
		setSplitNo(data.getSplitNo());
		setType(data.getType());
		setAmount(data.getAmount());
		setTtype(data.getTtype());
		setTradeDay(data.getTradeDay());
		setStreamTime(data.getStreamTime());
		setComments(data.getComments());
		setCurrency(data.getCurrency());
		setBuysell(data.getBuysell());
		setLots(data.getLots());
		setOpenprice(data.getOpenprice());
		setCloseprice(data.getCloseprice());
		setBeginBalance(data.getBeginBalance());
		setEndBalance(data.getEndBalance());
		setUserName(data.getUserName());
		setUserType(data.getUserType());
		setIpAddress(data.getIPAddress());
		setOperateStreamGUID(data.getOperateStreamGUID());
	}

	public MoneyAccountStreamDetails format(){
		MoneyAccountStreamDetails data=new MoneyAccountStreamDetails();
		
		return data;
	}


	public long getGuid() {
		try {
			long data=getEntryLong(C3_MoneyAccountStreamDetails.guid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuid(long guid) {
		setEntry(C3_MoneyAccountStreamDetails.guid, guid);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_MoneyAccountStreamDetails.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_MoneyAccountStreamDetails.account, account);
	}

	public String getAeid() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_MoneyAccountStreamDetails.aeid, aeid);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_MoneyAccountStreamDetails.instrument, instrument);
	}

	public long getTicket() {
		try {
			long data=getEntryLong(C3_MoneyAccountStreamDetails.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(C3_MoneyAccountStreamDetails.ticket, ticket);
	}

	public int getSplitNo() {
		try {
			int data=getEntryInt(C3_MoneyAccountStreamDetails.splitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitNo(int splitNo) {
		setEntry(C3_MoneyAccountStreamDetails.splitNo, splitNo);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_MoneyAccountStreamDetails.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_MoneyAccountStreamDetails.type, type);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStreamDetails.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_MoneyAccountStreamDetails.amount, amount);
	}

	public int getTtype() {
		try {
			int data=getEntryInt(C3_MoneyAccountStreamDetails.ttype);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTtype(int ttype) {
		setEntry(C3_MoneyAccountStreamDetails.ttype, ttype);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_MoneyAccountStreamDetails.tradeDay, tradeDay);
	}

	public Date getStreamTime() {
		try {
			Date data=getEntryDate(C3_MoneyAccountStreamDetails.streamTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStreamTime(Date streamTime) {
		setEntry(C3_MoneyAccountStreamDetails.streamTime, streamTime);
	}

	public String getComments() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.comments);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComments(String comments) {
		setEntry(C3_MoneyAccountStreamDetails.comments, comments);
	}

	public String getCurrency() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(C3_MoneyAccountStreamDetails.currency, currency);
	}

	public int getBuysell() {
		try {
			int data=getEntryInt(C3_MoneyAccountStreamDetails.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(C3_MoneyAccountStreamDetails.buysell, buysell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStreamDetails.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_MoneyAccountStreamDetails.lots, lots);
	}

	public double getOpenprice() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStreamDetails.openprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenprice(double openprice) {
		setEntry(C3_MoneyAccountStreamDetails.openprice, openprice);
	}

	public double getCloseprice() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStreamDetails.closeprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseprice(double closeprice) {
		setEntry(C3_MoneyAccountStreamDetails.closeprice, closeprice);
	}

	public double getBeginBalance() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStreamDetails.beginBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBeginBalance(double beginBalance) {
		setEntry(C3_MoneyAccountStreamDetails.beginBalance, beginBalance);
	}

	public double getEndBalance() {
		try {
			double data=getEntryDouble(C3_MoneyAccountStreamDetails.endBalance);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setEndBalance(double endBalance) {
		setEntry(C3_MoneyAccountStreamDetails.endBalance, endBalance);
	}

	public String getUserName() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(C3_MoneyAccountStreamDetails.userName, userName);
	}

	public int getUserType() {
		try {
			int data=getEntryInt(C3_MoneyAccountStreamDetails.userType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUserType(int userType) {
		setEntry(C3_MoneyAccountStreamDetails.userType, userType);
	}

	public String getIpAddress() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.ipAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddress(String ipAddress) {
		setEntry(C3_MoneyAccountStreamDetails.ipAddress, ipAddress);
	}

	public String getOperateStreamGUID() {
		try {
			String data=getEntryString(C3_MoneyAccountStreamDetails.operateStreamGUID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOperateStreamGUID(String operateStreamGUID) {
		setEntry(C3_MoneyAccountStreamDetails.operateStreamGUID, operateStreamGUID);
	}


}