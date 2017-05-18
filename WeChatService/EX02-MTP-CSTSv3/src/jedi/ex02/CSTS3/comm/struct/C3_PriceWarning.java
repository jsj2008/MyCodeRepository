package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.PriceWarning;

public class C3_PriceWarning extends allone.json.AbstractJsonData {

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

	public C3_PriceWarning(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(PriceWarning data) throws Exception {
		setGuid(data.getGuid());
		setAccount(data.getAccount());
		setTime(data.getTime());
		setInstrument(data.getInstrument());
		setPrice(data.getPrice());
		setCompareWay(data.getCompareWay());
		setPriceType(data.getPriceType());
		setIsPriceReach(data.getIsPriceReach());
		setReachPrice(data.getReachPrice());
		setReachTime(data.getReachTime());
	}

	public PriceWarning format(){
		PriceWarning data=new PriceWarning();
		data.setGuid(getGuid());
		data.setAccount(getAccount());
		data.setTime(getTime());
		data.setInstrument(getInstrument());
		data.setPrice(getPrice());
		data.setCompareWay(getCompareWay());
		data.setPriceType(getPriceType());
		data.setIsPriceReach(getIsPriceReach());
		data.setReachPrice(getReachPrice());
		data.setReachTime(getReachTime());
		return data;
	}


	public String getGuid() {
		try {
			String data=getEntryString(C3_PriceWarning.guid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuid(String guid) {
		setEntry(C3_PriceWarning.guid, guid);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_PriceWarning.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_PriceWarning.account, account);
	}

	public Date getTime() {
		try {
			Date data=getEntryDate(C3_PriceWarning.time);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTime(Date time) {
		setEntry(C3_PriceWarning.time, time);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_PriceWarning.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_PriceWarning.instrument, instrument);
	}

	public double getPrice() {
		try {
			double data=getEntryDouble(C3_PriceWarning.price);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPrice(double price) {
		setEntry(C3_PriceWarning.price, price);
	}

	public int getCompareWay() {
		try {
			int data=getEntryInt(C3_PriceWarning.compareWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCompareWay(int compareWay) {
		setEntry(C3_PriceWarning.compareWay, compareWay);
	}

	public int getPriceType() {
		try {
			int data=getEntryInt(C3_PriceWarning.priceType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceType(int priceType) {
		setEntry(C3_PriceWarning.priceType, priceType);
	}

	public int getIsPriceReach() {
		try {
			int data=getEntryInt(C3_PriceWarning.isPriceReach);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsPriceReach(int isPriceReach) {
		setEntry(C3_PriceWarning.isPriceReach, isPriceReach);
	}

	public double getReachPrice() {
		try {
			double data=getEntryDouble(C3_PriceWarning.reachPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReachPrice(double reachPrice) {
		setEntry(C3_PriceWarning.reachPrice, reachPrice);
	}

	public Date getReachTime() {
		try {
			Date data=getEntryDate(C3_PriceWarning.reachTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReachTime(Date reachTime) {
		setEntry(C3_PriceWarning.reachTime, reachTime);
	}


}