package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.BasicCurrency;


public class C3_BasicCurrency extends allone.json.AbstractJsonData {

	public static final String jsonId = "4";

	public static final String currencyName = "1";
	public static final String shortName = "2";
	public static final String canBeAccountCurrency = "3";
	public static final String digit = "4";
	public static final String interestRate = "5";

	public C3_BasicCurrency(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(BasicCurrency data) throws Exception {
		setCurrencyName(data.getCurrencyName());
		setShortName(data.getShortName());
		setCanBeAccountCurrency(data.getCanBeAccountCurrency());
		setDigit(data.getDigit());
		setInterestRate(data.getInterestRate());
	}

	public BasicCurrency format(){
		BasicCurrency data=new BasicCurrency();
		data.setCurrencyName(getCurrencyName());
		data.setShortName(getShortName());
		data.setCanBeAccountCurrency(getCanBeAccountCurrency());
		data.setDigit(getDigit());
		data.setInterestRate(getInterestRate());
		return data;
	}


	public String getCurrencyName() {
		try {
			String data=getEntryString(C3_BasicCurrency.currencyName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencyName(String currencyName) {
		setEntry(C3_BasicCurrency.currencyName, currencyName);
	}

	public String getShortName() {
		try {
			String data=getEntryString(C3_BasicCurrency.shortName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShortName(String shortName) {
		setEntry(C3_BasicCurrency.shortName, shortName);
	}

	public int getCanBeAccountCurrency() {
		try {
			int data=getEntryInt(C3_BasicCurrency.canBeAccountCurrency);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanBeAccountCurrency(int canBeAccountCurrency) {
		setEntry(C3_BasicCurrency.canBeAccountCurrency, canBeAccountCurrency);
	}

	public int getDigit() {
		try {
			int data=getEntryInt(C3_BasicCurrency.digit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDigit(int digit) {
		setEntry(C3_BasicCurrency.digit, digit);
	}

	public double getInterestRate() {
		try {
			double data=getEntryDouble(C3_BasicCurrency.interestRate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setInterestRate(double interestRate) {
		setEntry(C3_BasicCurrency.interestRate, interestRate);
	}


}