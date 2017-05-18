package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class PriceWarning extends allone.json.AbstractJsonData {

	public static final String jsonId = "17";

	public static final String guid = "1";
	public static final String account = "2";
	public static final String time = "3";
	public static final String instrument = "4";
	public static final String price = "5";
	public static final String compareWay = "6";
	public static final String priceType = "7";
	public static final String isPriceReach = "8";
	public static final String reachPrice = "9";
	public static final String reachTime = "10";

	public PriceWarning(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getGuid() {
		try {
			String data=getEntryString(PriceWarning.guid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuid(String guid) {
		setEntry(PriceWarning.guid, guid);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(PriceWarning.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(PriceWarning.account, account);
	}

	public Date getTime() {
		try {
			Date data=getEntryDate(PriceWarning.time);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTime(Date time) {
		setEntry(PriceWarning.time, time);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(PriceWarning.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(PriceWarning.instrument, instrument);
	}

	public double getPrice() {
		try {
			double data=getEntryDouble(PriceWarning.price);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPrice(double price) {
		setEntry(PriceWarning.price, price);
	}

	public int getCompareWay() {
		try {
			int data=getEntryInt(PriceWarning.compareWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCompareWay(int compareWay) {
		setEntry(PriceWarning.compareWay, compareWay);
	}

	public int getPriceType() {
		try {
			int data=getEntryInt(PriceWarning.priceType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceType(int priceType) {
		setEntry(PriceWarning.priceType, priceType);
	}

	public int getIsPriceReach() {
		try {
			int data=getEntryInt(PriceWarning.isPriceReach);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsPriceReach(int isPriceReach) {
		setEntry(PriceWarning.isPriceReach, isPriceReach);
	}

	public double getReachPrice() {
		try {
			double data=getEntryDouble(PriceWarning.reachPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReachPrice(double reachPrice) {
		setEntry(PriceWarning.reachPrice, reachPrice);
	}

	public Date getReachTime() {
		try {
			Date data=getEntryDate(PriceWarning.reachTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReachTime(Date reachTime) {
		setEntry(PriceWarning.reachTime, reachTime);
	}


}