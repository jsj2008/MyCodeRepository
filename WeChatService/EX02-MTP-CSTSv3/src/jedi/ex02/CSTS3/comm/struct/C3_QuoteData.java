package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.quote.common.QuoteData;


public class C3_QuoteData extends allone.json.AbstractJsonData {

	public static final String jsonId = "18";

	public static final String instrument = "1";
	public static final String bid = "2";
	public static final String ask = "3";
	public static final String quoteDay = "4";
	public static final String quoteTime = "5";
	public static final String openPrice = "6";
	public static final String highPrice = "7";
	public static final String lowPrice = "8";
	public static final String yclosePrice = "9";
	public static final String lastBid = "10";
	public static final String tradeable = "11";
	public static final String close = "12";
	public static final String tradeVolume = "13";
	public static final String lots = "14";

	public C3_QuoteData(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(QuoteData data) throws Exception {
		setInstrument(data.getInstrument());
		setBid(data.getBid());
		setAsk(data.getAsk());
		setQuoteDay(data.getQuoteDay());
		setQuoteTime(data.getQuoteTime());
		setOpenPrice(data.getOpenPrice());
		setHighPrice(data.getHighPrice());
		setLowPrice(data.getLowPrice());
		setYclosePrice(data.getYclosePrice());
		setLastBid(data.getLastBid());
		setTradeable(data.isTradeable());
		setClose(data.isClose());
		setTradeVolume(data.getTradeVolume());
		setLots(data.getLots());
	}

	public QuoteData format(){
		QuoteData data=new QuoteData();
		data.setInstrument(getInstrument());
		data.setBid(getBid());
		data.setAsk(getAsk());
		data.setQuoteDay(getQuoteDay());
		data.setQuoteTime(getQuoteTime());
		data.setOpenPrice(getOpenPrice());
		data.setHighPrice(getHighPrice());
		data.setLowPrice(getLowPrice());
		data.setYclosePrice(getYclosePrice());
		data.setLastBid(getLastBid());
		data.setTradeable(isTradeable());
		data.setClose(isClose());
		data.setTradeVolume(getTradeVolume());
		data.setLots(getLots());
		return data;
	}


	public String getInstrument() {
		try {
			String data=getEntryString(C3_QuoteData.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_QuoteData.instrument, instrument);
	}

	public double getBid() {
		try {
			double data=getEntryDouble(C3_QuoteData.bid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBid(double bid) {
		setEntry(C3_QuoteData.bid, bid);
	}

	public double getAsk() {
		try {
			double data=getEntryDouble(C3_QuoteData.ask);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAsk(double ask) {
		setEntry(C3_QuoteData.ask, ask);
	}

	public String getQuoteDay() {
		try {
			String data=getEntryString(C3_QuoteData.quoteDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteDay(String quoteDay) {
		setEntry(C3_QuoteData.quoteDay, quoteDay);
	}

	public long getQuoteTime() {
		try {
			long data=getEntryLong(C3_QuoteData.quoteTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setQuoteTime(long quoteTime) {
		setEntry(C3_QuoteData.quoteTime, quoteTime);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(C3_QuoteData.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(C3_QuoteData.openPrice, openPrice);
	}

	public double getHighPrice() {
		try {
			double data=getEntryDouble(C3_QuoteData.highPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setHighPrice(double highPrice) {
		setEntry(C3_QuoteData.highPrice, highPrice);
	}

	public double getLowPrice() {
		try {
			double data=getEntryDouble(C3_QuoteData.lowPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLowPrice(double lowPrice) {
		setEntry(C3_QuoteData.lowPrice, lowPrice);
	}

	public double getYclosePrice() {
		try {
			double data=getEntryDouble(C3_QuoteData.yclosePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setYclosePrice(double yclosePrice) {
		setEntry(C3_QuoteData.yclosePrice, yclosePrice);
	}

	public double getLastBid() {
		try {
			double data=getEntryDouble(C3_QuoteData.lastBid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLastBid(double lastBid) {
		setEntry(C3_QuoteData.lastBid, lastBid);
	}

	public boolean isTradeable() {
		try {
			boolean data=getEntryBoolean(C3_QuoteData.tradeable);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setTradeable(boolean tradeable) {
		setEntry(C3_QuoteData.tradeable, tradeable);
	}

	public boolean isClose() {
		try {
			boolean data=getEntryBoolean(C3_QuoteData.close);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setClose(boolean close) {
		setEntry(C3_QuoteData.close, close);
	}

	public long getTradeVolume() {
		try {
			long data=getEntryLong(C3_QuoteData.tradeVolume);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradeVolume(long tradeVolume) {
		setEntry(C3_QuoteData.tradeVolume, tradeVolume);
	}

	public long getLots() {
		try {
			long data=getEntryLong(C3_QuoteData.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(long lots) {
		setEntry(C3_QuoteData.lots, lots);
	}


}