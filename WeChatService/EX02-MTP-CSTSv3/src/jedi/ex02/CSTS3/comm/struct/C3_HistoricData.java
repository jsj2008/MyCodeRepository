package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.quote.common.HistoricData;


public class C3_HistoricData extends allone.json.AbstractJsonData {

	public static final String jsonId = "30";

	public static final String dataTime = "1";
	public static final String quoteDay = "2";
	public static final String openPrice = "3";
	public static final String highPrice = "4";
	public static final String lowPrice = "5";
	public static final String closePrice = "6";
	public static final String volume = "7";
	public static final String amount = "8";
	
	public static final String isNew = "9";

	public C3_HistoricData(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(HistoricData data) throws Exception {
		setDataTime(data.getDataTime());
		setQuoteDay(data.getQuoteDay());
		setOpenPrice(data.getOpenPrice());
		setHighPrice(data.getHighPrice());
		setLowPrice(data.getLowPrice());
		setClosePrice(data.getClosePrice());
		setVolume(data.getVolume());
		setAmount(data.getAmount());
		
		setIsNew(data.isNew());
	}

	public HistoricData format(){
		HistoricData data=new HistoricData();
		data.setDataTime(getDataTime());
		data.setQuoteDay(getQuoteDay());
		data.setOpenPrice(getOpenPrice());
		data.setHighPrice(getHighPrice());
		data.setLowPrice(getLowPrice());
		data.setClosePrice(getClosePrice());
		data.setVolume(getVolume());
		data.setAmount(getAmount());
		return data;
	}


	public long getDataTime() {
		try {
			long data=getEntryLong(C3_HistoricData.dataTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDataTime(long dataTime) {
		setEntry(C3_HistoricData.dataTime, dataTime);
	}

	public String getQuoteDay() {
		try {
			String data=getEntryString(C3_HistoricData.quoteDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteDay(String quoteDay) {
		setEntry(C3_HistoricData.quoteDay, quoteDay);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(C3_HistoricData.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(C3_HistoricData.openPrice, openPrice);
	}

	public double getHighPrice() {
		try {
			double data=getEntryDouble(C3_HistoricData.highPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setHighPrice(double highPrice) {
		setEntry(C3_HistoricData.highPrice, highPrice);
	}

	public double getLowPrice() {
		try {
			double data=getEntryDouble(C3_HistoricData.lowPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLowPrice(double lowPrice) {
		setEntry(C3_HistoricData.lowPrice, lowPrice);
	}

	public double getClosePrice() {
		try {
			double data=getEntryDouble(C3_HistoricData.closePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setClosePrice(double closePrice) {
		setEntry(C3_HistoricData.closePrice, closePrice);
	}

	public double getVolume() {
		try {
			double data=getEntryDouble(C3_HistoricData.volume);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setVolume(double volume) {
		setEntry(C3_HistoricData.volume, volume);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(C3_HistoricData.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_HistoricData.amount, amount);
	}
	
	public boolean getIsNew() {
		try {
			boolean data=getEntryBoolean(C3_HistoricData.amount);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIsNew(Boolean isNew) {
		setEntry(C3_HistoricData.isNew, isNew);
	}


}