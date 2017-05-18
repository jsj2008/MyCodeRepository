package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.quote.common.QuoteSizeData;


public class C3_QuoteSizeData extends allone.json.AbstractJsonData {

	public static final String jsonId = "19";

	public static final String instrument = "1";
	public static final String priceType = "2";
	public static final String ammount = "3";

	public C3_QuoteSizeData(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(QuoteSizeData data) throws Exception {
		setInstrument(data.getInstrument());
		setPriceType(data.getPriceType());
		setAmmount(data.getAmmount());
	}

	public QuoteSizeData format(){
		QuoteSizeData data=new QuoteSizeData();
		data.setInstrument(getInstrument());
		data.setPriceType(getPriceType());
		data.setAmmount(getAmmount());
		return data;
	}


	public String getInstrument() {
		try {
			String data=getEntryString(C3_QuoteSizeData.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_QuoteSizeData.instrument, instrument);
	}

	public int getPriceType() {
		try {
			int data=getEntryInt(C3_QuoteSizeData.priceType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceType(int priceType) {
		setEntry(C3_QuoteSizeData.priceType, priceType);
	}

	public double getAmmount() {
		try {
			double data=getEntryDouble(C3_QuoteSizeData.ammount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmmount(double ammount) {
		setEntry(C3_QuoteSizeData.ammount, ammount);
	}


}