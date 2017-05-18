package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.BalanceRate;


public class C3_BalanceRate extends allone.json.AbstractJsonData {

	public static final String jsonId = "3";

	public static final String instrument = "1";
	public static final String cur1 = "2";
	public static final String cur2 = "3";
	public static final String bid = "4";
	public static final String ask = "5";
	public static final String tradeDay = "6";

	public C3_BalanceRate(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(BalanceRate data) throws Exception {
		setInstrument(data.getInstrument());
		setCur1(data.getCur1());
		setCur2(data.getCur2());
		setBid(data.getBid());
		setAsk(data.getAsk());
		setTradeDay(data.getTradeDay());
	}

	public BalanceRate format(){
		BalanceRate data=new BalanceRate();
		data.setInstrument(getInstrument());
		data.setCur1(getCur1());
		data.setCur2(getCur2());
		data.setBid(getBid());
		data.setAsk(getAsk());
		data.setTradeDay(getTradeDay());
		return data;
	}


	public String getInstrument() {
		try {
			String data=getEntryString(C3_BalanceRate.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_BalanceRate.instrument, instrument);
	}

	public String getCur1() {
		try {
			String data=getEntryString(C3_BalanceRate.cur1);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCur1(String cur1) {
		setEntry(C3_BalanceRate.cur1, cur1);
	}

	public String getCur2() {
		try {
			String data=getEntryString(C3_BalanceRate.cur2);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCur2(String cur2) {
		setEntry(C3_BalanceRate.cur2, cur2);
	}

	public double getBid() {
		try {
			double data=getEntryDouble(C3_BalanceRate.bid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBid(double bid) {
		setEntry(C3_BalanceRate.bid, bid);
	}

	public double getAsk() {
		try {
			double data=getEntryDouble(C3_BalanceRate.ask);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAsk(double ask) {
		setEntry(C3_BalanceRate.ask, ask);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(C3_BalanceRate.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_BalanceRate.tradeDay, tradeDay);
	}


}