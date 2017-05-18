package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class MarginCall extends allone.json.AbstractJsonData {

	public static final String jsonId = "13";

	public static final String account = "1";
	public static final String tradeDay = "2";
	public static final String marginCallLevel = "3";
	public static final String callTime = "4";
	public static final String marginPerc = "5";

	public MarginCall(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(MarginCall.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(MarginCall.account, account);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(MarginCall.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(MarginCall.tradeDay, tradeDay);
	}

	public int getMarginCallLevel() {
		try {
			int data=getEntryInt(MarginCall.marginCallLevel);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCallLevel(int marginCallLevel) {
		setEntry(MarginCall.marginCallLevel, marginCallLevel);
	}

	public Date getCallTime() {
		try {
			Date data=getEntryDate(MarginCall.callTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCallTime(Date callTime) {
		setEntry(MarginCall.callTime, callTime);
	}

	public double getMarginPerc() {
		try {
			double data=getEntryDouble(MarginCall.marginPerc);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc(double marginPerc) {
		setEntry(MarginCall.marginPerc, marginPerc);
	}


}