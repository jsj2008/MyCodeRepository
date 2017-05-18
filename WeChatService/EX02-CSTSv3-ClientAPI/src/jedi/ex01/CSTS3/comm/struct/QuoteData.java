package jedi.ex01.CSTS3.comm.struct;
import allone.json.*;


public class QuoteData extends allone.json.AbstractJsonData {

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

	public QuoteData(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(QuoteData.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(QuoteData.instrument, instrument);
	}

	public double getBid() {
		try {
			double data=getEntryDouble(QuoteData.bid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBid(double bid) {
		setEntry(QuoteData.bid, bid);
	}

	public double getAsk() {
		try {
			double data=getEntryDouble(QuoteData.ask);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAsk(double ask) {
		setEntry(QuoteData.ask, ask);
	}

	public String getQuoteDay() {
		try {
			String data=getEntryString(QuoteData.quoteDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteDay(String quoteDay) {
		setEntry(QuoteData.quoteDay, quoteDay);
	}

	public long getQuoteTime() {
		try {
			long data=getEntryLong(QuoteData.quoteTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setQuoteTime(long quoteTime) {
		setEntry(QuoteData.quoteTime, quoteTime);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(QuoteData.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(QuoteData.openPrice, openPrice);
	}

	public double getHighPrice() {
		try {
			double data=getEntryDouble(QuoteData.highPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setHighPrice(double highPrice) {
		setEntry(QuoteData.highPrice, highPrice);
	}

	public double getLowPrice() {
		try {
			double data=getEntryDouble(QuoteData.lowPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLowPrice(double lowPrice) {
		setEntry(QuoteData.lowPrice, lowPrice);
	}

	public double getYclosePrice() {
		try {
			double data=getEntryDouble(QuoteData.yclosePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setYclosePrice(double yclosePrice) {
		setEntry(QuoteData.yclosePrice, yclosePrice);
	}

	public double getLastBid() {
		try {
			double data=getEntryDouble(QuoteData.lastBid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLastBid(double lastBid) {
		setEntry(QuoteData.lastBid, lastBid);
	}

	public boolean isTradeable() {
		try {
			boolean data=getEntryBoolean(QuoteData.tradeable);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setTradeable(boolean tradeable) {
		setEntry(QuoteData.tradeable, tradeable);
	}

	public boolean isClose() {
		try {
			boolean data=getEntryBoolean(QuoteData.close);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setClose(boolean close) {
		setEntry(QuoteData.close, close);
	}

	public long getTradeVolume() {
		try {
			long data=getEntryLong(QuoteData.tradeVolume);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradeVolume(long tradeVolume) {
		setEntry(QuoteData.tradeVolume, tradeVolume);
	}

	public long getLots() {
		try {
			long data=getEntryLong(QuoteData.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(long lots) {
		setEntry(QuoteData.lots, lots);
	}


}