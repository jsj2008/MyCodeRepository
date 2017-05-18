package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.BatchRateGap;

public class C3_BatchRateGap extends allone.json.AbstractJsonData {

	public static final String jsonId = "5";

	public static final String tradeDay = "1";
	public static final String instrument = "2";
	public static final String time = "3";
	public static final String bidPriceGap = "4";
	public static final String askPriceGap = "5";

	public C3_BatchRateGap(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(BatchRateGap data) throws Exception {
		setTradeDay(data.getTradeDay());
		setInstrument(data.getInstrument());
		setTime(data.getTime());
		setBidPriceGap(data.getBidPriceGap());
		setAskPriceGap(data.getAskPriceGap());
	}

	public BatchRateGap format(){
		BatchRateGap data=new BatchRateGap();
		data.setTradeDay(getTradeDay());
		data.setInstrument(getInstrument());
		data.setTime(getTime());
		data.setBidPriceGap(getBidPriceGap());
		data.setAskPriceGap(getAskPriceGap());
		return data;
	}


	public String getTradeDay() {
		try {
			String data=getEntryString(C3_BatchRateGap.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_BatchRateGap.tradeDay, tradeDay);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_BatchRateGap.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_BatchRateGap.instrument, instrument);
	}

	public Date getTime() {
		try {
			Date data=getEntryDate(C3_BatchRateGap.time);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTime(Date time) {
		setEntry(C3_BatchRateGap.time, time);
	}

	public int getBidPriceGap() {
		try {
			int data=getEntryInt(C3_BatchRateGap.bidPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBidPriceGap(int bidPriceGap) {
		setEntry(C3_BatchRateGap.bidPriceGap, bidPriceGap);
	}

	public int getAskPriceGap() {
		try {
			int data=getEntryInt(C3_BatchRateGap.askPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAskPriceGap(int askPriceGap) {
		setEntry(C3_BatchRateGap.askPriceGap, askPriceGap);
	}


}