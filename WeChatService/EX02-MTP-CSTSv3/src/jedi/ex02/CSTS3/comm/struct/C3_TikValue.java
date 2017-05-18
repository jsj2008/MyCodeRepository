package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.quote.common.TikValue;


public class C3_TikValue extends allone.json.AbstractJsonData {

	public static final String jsonId = "31";

	public static final String tikTime = "1";
	public static final String bid = "2";
	public static final String ask = "3";
	public static final String volume = "4";
	public static final String amount = "5";

	public C3_TikValue(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(TikValue data) throws Exception {
		setTikTime(data.getTikTime());
		setBid(data.getBid());
		setAsk(data.getAsk());
		setVolume(data.getVolume());
		setAmount(data.getAmount());
	}

	public TikValue format(){
		TikValue data=new TikValue();
		data.setTikTime(getTikTime());
		data.setBid(getBid());
		data.setAsk(getAsk());
		data.setVolume(getVolume());
		data.setAmount(getAmount());
		return data;
	}


	public long getTikTime() {
		try {
			long data=getEntryLong(C3_TikValue.tikTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTikTime(long tikTime) {
		setEntry(C3_TikValue.tikTime, tikTime);
	}

	public double getBid() {
		try {
			double data=getEntryDouble(C3_TikValue.bid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBid(double bid) {
		setEntry(C3_TikValue.bid, bid);
	}

	public double getAsk() {
		try {
			double data=getEntryDouble(C3_TikValue.ask);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAsk(double ask) {
		setEntry(C3_TikValue.ask, ask);
	}

	public double getVolume() {
		try {
			double data=getEntryDouble(C3_TikValue.volume);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setVolume(double volume) {
		setEntry(C3_TikValue.volume, volume);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(C3_TikValue.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_TikValue.amount, amount);
	}


}