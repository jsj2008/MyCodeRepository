package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.MarginCall;

public class C3_MarginCall extends allone.json.AbstractJsonData {

	public static final String jsonId = "13";

	public static final String account = "1";
	public static final String tradeDay = "2";
	public static final String marginCallLevel = "3";
	public static final String callTime = "4";
	public static final String marginPerc = "5";

	public C3_MarginCall(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(MarginCall data) throws Exception {
		setAccount(data.getAccount());
		setTradeDay(data.getTradeDay());
		setMarginCallLevel(data.getMarginCallLevel());
		setCallTime(data.getCallTime());
		setMarginPerc(data.getMarginPerc());
	}

	public MarginCall format(){
		MarginCall data=new MarginCall();
		data.setAccount(getAccount());
		data.setTradeDay(getTradeDay());
		data.setMarginCallLevel(getMarginCallLevel());
		data.setCallTime(getCallTime());
		data.setMarginPerc(getMarginPerc());
		return data;
	}


	public long getAccount() {
		try {
			long data=getEntryLong(C3_MarginCall.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_MarginCall.account, account);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(C3_MarginCall.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_MarginCall.tradeDay, tradeDay);
	}

	public int getMarginCallLevel() {
		try {
			int data=getEntryInt(C3_MarginCall.marginCallLevel);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCallLevel(int marginCallLevel) {
		setEntry(C3_MarginCall.marginCallLevel, marginCallLevel);
	}

	public Date getCallTime() {
		try {
			Date data=getEntryDate(C3_MarginCall.callTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCallTime(Date callTime) {
		setEntry(C3_MarginCall.callTime, callTime);
	}

	public double getMarginPerc() {
		try {
			double data=getEntryDouble(C3_MarginCall.marginPerc);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc(double marginPerc) {
		setEntry(C3_MarginCall.marginPerc, marginPerc);
	}


}