package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.InstrumentType;


public class C3_InstrumentType extends allone.json.AbstractJsonData {

	public static final String jsonId = "9";

	public static final String instrumentType = "1";
	public static final String shortName = "2";
	public static final String subTypes = "3";
	public static final String idx = "4";
	public static final String openTimeInMil = "5";
	public static final String closeTimeInMil = "6";
	public static final String isClosed = "7";
	public static final String autoClose = "8";
	public static final String quoteDay = "9";
	public static final String isStickedWithSystem = "10";

	public C3_InstrumentType(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(InstrumentType data) throws Exception {
		setInstrumentType(data.getInstrumentType());
		setShortName(data.getShortName());
		setSubTypes(data.getSubTypes());
		setIdx(data.getIdx());
		setOpenTimeInMil(data.getOpenTimeInMil());
		setCloseTimeInMil(data.getCloseTimeInMil());
		setIsClosed(data.getIsClosed());
		setAutoClose(data.getAutoClose());
		setQuoteDay(data.getQuoteDay());
		setIsStickedWithSystem(data.getIsStickedWithSystem());
	}

	public InstrumentType format(){
		InstrumentType data=new InstrumentType();
		data.setInstrumentType(getInstrumentType());
		data.setShortName(getShortName());
		data.setSubTypes(getSubTypes());
		data.setIdx(getIdx());
		data.setOpenTimeInMil(getOpenTimeInMil());
		data.setCloseTimeInMil(getCloseTimeInMil());
		data.setIsClosed(getIsClosed());
		data.setAutoClose(getAutoClose());
		data.setQuoteDay(getQuoteDay());
		data.setIsStickedWithSystem(getIsStickedWithSystem());
		return data;
	}


	public String getInstrumentType() {
		try {
			String data=getEntryString(C3_InstrumentType.instrumentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentType(String instrumentType) {
		setEntry(C3_InstrumentType.instrumentType, instrumentType);
	}

	public String getShortName() {
		try {
			String data=getEntryString(C3_InstrumentType.shortName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShortName(String shortName) {
		setEntry(C3_InstrumentType.shortName, shortName);
	}

	public String getSubTypes() {
		try {
			String data=getEntryString(C3_InstrumentType.subTypes);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSubTypes(String subTypes) {
		setEntry(C3_InstrumentType.subTypes, subTypes);
	}

	public int getIdx() {
		try {
			int data=getEntryInt(C3_InstrumentType.idx);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIdx(int idx) {
		setEntry(C3_InstrumentType.idx, idx);
	}

	public int getOpenTimeInMil() {
		try {
			int data=getEntryInt(C3_InstrumentType.openTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenTimeInMil(int openTimeInMil) {
		setEntry(C3_InstrumentType.openTimeInMil, openTimeInMil);
	}

	public int getCloseTimeInMil() {
		try {
			int data=getEntryInt(C3_InstrumentType.closeTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseTimeInMil(int closeTimeInMil) {
		setEntry(C3_InstrumentType.closeTimeInMil, closeTimeInMil);
	}

	public int getIsClosed() {
		try {
			int data=getEntryInt(C3_InstrumentType.isClosed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsClosed(int isClosed) {
		setEntry(C3_InstrumentType.isClosed, isClosed);
	}

	public int getAutoClose() {
		try {
			int data=getEntryInt(C3_InstrumentType.autoClose);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoClose(int autoClose) {
		setEntry(C3_InstrumentType.autoClose, autoClose);
	}

	public String getQuoteDay() {
		try {
			String data=getEntryString(C3_InstrumentType.quoteDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteDay(String quoteDay) {
		setEntry(C3_InstrumentType.quoteDay, quoteDay);
	}

	public int getIsStickedWithSystem() {
		try {
			int data=getEntryInt(C3_InstrumentType.isStickedWithSystem);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsStickedWithSystem(int isStickedWithSystem) {
		setEntry(C3_InstrumentType.isStickedWithSystem, isStickedWithSystem);
	}


}