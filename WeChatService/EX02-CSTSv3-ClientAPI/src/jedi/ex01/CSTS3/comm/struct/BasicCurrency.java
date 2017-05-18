package jedi.ex01.CSTS3.comm.struct;


public class BasicCurrency extends allone.json.AbstractJsonData {

	public static final String jsonId = "4";

	public static final String currencyName = "1";
	public static final String shortName = "2";
	public static final String canBeAccountCurrency = "3";
	public static final String digit = "4";
	public static final String interestRate = "5";

	public BasicCurrency(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getCurrencyName() {
		try {
			String data=getEntryString(BasicCurrency.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(BasicCurrency.currencyName, currencyName);
	}

	public String getShortName() {
		try {
			String data=getEntryString(BasicCurrency.shortName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShortName(String shortName) {
		setEntry(BasicCurrency.shortName, shortName);
	}

	public int getCanBeAccountCurrency() {
		try {
			int data=getEntryInt(BasicCurrency.canBeAccountCurrency);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanBeAccountCurrency(int canBeAccountCurrency) {
		setEntry(BasicCurrency.canBeAccountCurrency, canBeAccountCurrency);
	}

	public int getDigit() {
		try {
			int data=getEntryInt(BasicCurrency.digit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDigit(int digit) {
		setEntry(BasicCurrency.digit, digit);
	}

	public double getInterestRate() {
		try {
			double data=getEntryDouble(BasicCurrency.interestRate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestRate(double interestRate) {
		setEntry(BasicCurrency.interestRate, interestRate);
	}


}