package jedi.ex01.CSTS3.comm.struct;


public class BalanceRate extends allone.json.AbstractJsonData {

	public static final String jsonId = "3";

	public static final String instrument = "1";
	public static final String cur1 = "2";
	public static final String cur2 = "3";
	public static final String bid = "4";
	public static final String ask = "5";
	public static final String tradeDay = "6";

	public BalanceRate(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(BalanceRate.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(BalanceRate.instrument, instrument);
	}

	public String getCur1() {
		try {
			String data=getEntryString(BalanceRate.cur1);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCur1(String cur1) {
		setEntry(BalanceRate.cur1, cur1);
	}

	public String getCur2() {
		try {
			String data=getEntryString(BalanceRate.cur2);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCur2(String cur2) {
		setEntry(BalanceRate.cur2, cur2);
	}

	public double getBid() {
		try {
			double data=getEntryDouble(BalanceRate.bid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBid(double bid) {
		setEntry(BalanceRate.bid, bid);
	}

	public double getAsk() {
		try {
			double data=getEntryDouble(BalanceRate.ask);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAsk(double ask) {
		setEntry(BalanceRate.ask, ask);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(BalanceRate.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(BalanceRate.tradeDay, tradeDay);
	}


}