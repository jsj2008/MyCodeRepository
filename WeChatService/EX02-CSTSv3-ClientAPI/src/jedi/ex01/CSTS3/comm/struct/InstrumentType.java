package jedi.ex01.CSTS3.comm.struct;


public class InstrumentType extends allone.json.AbstractJsonData {

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

	public InstrumentType(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrumentType() {
		try {
			String data=getEntryString(InstrumentType.instrumentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentType(String instrumentType) {
		setEntry(InstrumentType.instrumentType, instrumentType);
	}

	public String getShortName() {
		try {
			String data=getEntryString(InstrumentType.shortName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShortName(String shortName) {
		setEntry(InstrumentType.shortName, shortName);
	}

	public String getSubTypes() {
		try {
			String data=getEntryString(InstrumentType.subTypes);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSubTypes(String subTypes) {
		setEntry(InstrumentType.subTypes, subTypes);
	}

	public int getIdx() {
		try {
			int data=getEntryInt(InstrumentType.idx);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIdx(int idx) {
		setEntry(InstrumentType.idx, idx);
	}

	public int getOpenTimeInMil() {
		try {
			int data=getEntryInt(InstrumentType.openTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenTimeInMil(int openTimeInMil) {
		setEntry(InstrumentType.openTimeInMil, openTimeInMil);
	}

	public int getCloseTimeInMil() {
		try {
			int data=getEntryInt(InstrumentType.closeTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseTimeInMil(int closeTimeInMil) {
		setEntry(InstrumentType.closeTimeInMil, closeTimeInMil);
	}

	public int getIsClosed() {
		try {
			int data=getEntryInt(InstrumentType.isClosed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsClosed(int isClosed) {
		setEntry(InstrumentType.isClosed, isClosed);
	}

	public int getAutoClose() {
		try {
			int data=getEntryInt(InstrumentType.autoClose);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoClose(int autoClose) {
		setEntry(InstrumentType.autoClose, autoClose);
	}

	public String getQuoteDay() {
		try {
			String data=getEntryString(InstrumentType.quoteDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteDay(String quoteDay) {
		setEntry(InstrumentType.quoteDay, quoteDay);
	}

	public int getIsStickedWithSystem() {
		try {
			int data=getEntryInt(InstrumentType.isStickedWithSystem);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsStickedWithSystem(int isStickedWithSystem) {
		setEntry(InstrumentType.isStickedWithSystem, isStickedWithSystem);
	}


}