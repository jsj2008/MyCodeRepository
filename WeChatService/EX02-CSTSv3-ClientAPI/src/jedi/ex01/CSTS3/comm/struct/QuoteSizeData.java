package jedi.ex01.CSTS3.comm.struct;


public class QuoteSizeData extends allone.json.AbstractJsonData {

	public static final String jsonId = "19";

	public static final String instrument = "1";
	public static final String priceType = "2";
	public static final String ammount = "3";

	public QuoteSizeData(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(QuoteSizeData.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(QuoteSizeData.instrument, instrument);
	}

	public int getPriceType() {
		try {
			int data=getEntryInt(QuoteSizeData.priceType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceType(int priceType) {
		setEntry(QuoteSizeData.priceType, priceType);
	}

	public double getAmmount() {
		try {
			double data=getEntryDouble(QuoteSizeData.ammount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmmount(double ammount) {
		setEntry(QuoteSizeData.ammount, ammount);
	}


}