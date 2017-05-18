package jedi.ex01.CSTS3.comm.struct;


public class HistoricData extends allone.json.AbstractJsonData {

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

	public HistoricData(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getDataTime() {
		try {
			long data=getEntryLong(HistoricData.dataTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDataTime(long dataTime) {
		setEntry(HistoricData.dataTime, dataTime);
	}

	public String getQuoteDay() {
		try {
			String data=getEntryString(HistoricData.quoteDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteDay(String quoteDay) {
		setEntry(HistoricData.quoteDay, quoteDay);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(HistoricData.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(HistoricData.openPrice, openPrice);
	}

	public double getHighPrice() {
		try {
			double data=getEntryDouble(HistoricData.highPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setHighPrice(double highPrice) {
		setEntry(HistoricData.highPrice, highPrice);
	}

	public double getLowPrice() {
		try {
			double data=getEntryDouble(HistoricData.lowPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLowPrice(double lowPrice) {
		setEntry(HistoricData.lowPrice, lowPrice);
	}

	public double getClosePrice() {
		try {
			double data=getEntryDouble(HistoricData.closePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setClosePrice(double closePrice) {
		setEntry(HistoricData.closePrice, closePrice);
	}

	public double getVolume() {
		try {
			double data=getEntryDouble(HistoricData.volume);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setVolume(double volume) {
		setEntry(HistoricData.volume, volume);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(HistoricData.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(HistoricData.amount, amount);
	}

	
	public boolean getIsNew() {
		try {
			boolean data=getEntryBoolean(HistoricData.amount);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIsNew(Boolean isNew) {
		setEntry(HistoricData.isNew, isNew);
	}

}