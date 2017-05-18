package jedi.ex01.CSTS3.comm.struct;


public class TikValue extends allone.json.AbstractJsonData {

	public static final String jsonId = "31";

	public static final String tikTime = "1";
	public static final String bid = "2";
	public static final String ask = "3";
	public static final String volume = "4";
	public static final String amount = "5";

	public TikValue(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getTikTime() {
		try {
			long data=getEntryLong(TikValue.tikTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTikTime(long tikTime) {
		setEntry(TikValue.tikTime, tikTime);
	}

	public double getBid() {
		try {
			double data=getEntryDouble(TikValue.bid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBid(double bid) {
		setEntry(TikValue.bid, bid);
	}

	public double getAsk() {
		try {
			double data=getEntryDouble(TikValue.ask);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAsk(double ask) {
		setEntry(TikValue.ask, ask);
	}

	public double getVolume() {
		try {
			double data=getEntryDouble(TikValue.volume);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setVolume(double volume) {
		setEntry(TikValue.volume, volume);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(TikValue.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(TikValue.amount, amount);
	}


}