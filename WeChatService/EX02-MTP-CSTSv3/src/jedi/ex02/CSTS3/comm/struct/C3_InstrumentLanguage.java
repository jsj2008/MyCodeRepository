package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.InstrumentLanguage;


public class C3_InstrumentLanguage extends allone.json.AbstractJsonData {

	public static final String jsonId = "8";

	public static final String instrument = "1";
	public static final String local = "2";
	public static final String showName = "3";
	public static final String description = "4";

	public C3_InstrumentLanguage(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(InstrumentLanguage data) throws Exception {
		setInstrument(data.getInstrument());
		setLocal(data.getLocal());
		setShowName(data.getShowName());
		setDescription(data.getDescription());
	}

	public InstrumentLanguage format(){
		InstrumentLanguage data=new InstrumentLanguage();
		data.setInstrument(getInstrument());
		data.setLocal(getLocal());
		data.setShowName(getShowName());
		data.setDescription(getDescription());
		return data;
	}


	public String getInstrument() {
		try {
			String data=getEntryString(C3_InstrumentLanguage.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_InstrumentLanguage.instrument, instrument);
	}

	public String getLocal() {
		try {
			String data=getEntryString(C3_InstrumentLanguage.local);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocal(String local) {
		setEntry(C3_InstrumentLanguage.local, local);
	}

	public String getShowName() {
		try {
			String data=getEntryString(C3_InstrumentLanguage.showName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShowName(String showName) {
		setEntry(C3_InstrumentLanguage.showName, showName);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_InstrumentLanguage.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_InstrumentLanguage.description, description);
	}


}