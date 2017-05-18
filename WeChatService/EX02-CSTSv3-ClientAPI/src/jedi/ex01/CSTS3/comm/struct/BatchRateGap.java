package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class BatchRateGap extends allone.json.AbstractJsonData {

	public static final String jsonId = "5";

	public static final String tradeDay = "1";
	public static final String instrument = "2";
	public static final String time = "3";
	public static final String bidPriceGap = "4";
	public static final String askPriceGap = "5";

	public BatchRateGap(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(BatchRateGap.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(BatchRateGap.tradeDay, tradeDay);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(BatchRateGap.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(BatchRateGap.instrument, instrument);
	}

	public Date getTime() {
		try {
			Date data=getEntryDate(BatchRateGap.time);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTime(Date time) {
		setEntry(BatchRateGap.time, time);
	}

	public int getBidPriceGap() {
		try {
			int data=getEntryInt(BatchRateGap.bidPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBidPriceGap(int bidPriceGap) {
		setEntry(BatchRateGap.bidPriceGap, bidPriceGap);
	}

	public int getAskPriceGap() {
		try {
			int data=getEntryInt(BatchRateGap.askPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAskPriceGap(int askPriceGap) {
		setEntry(BatchRateGap.askPriceGap, askPriceGap);
	}


}