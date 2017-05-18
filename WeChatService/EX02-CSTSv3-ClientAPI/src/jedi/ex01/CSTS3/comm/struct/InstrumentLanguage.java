package jedi.ex01.CSTS3.comm.struct;


public class InstrumentLanguage extends allone.json.AbstractJsonData {

	public static final String jsonId = "8";

	public static final String instrument = "1";
	public static final String local = "2";
	public static final String showName = "3";
	public static final String description = "4";

	public InstrumentLanguage(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(InstrumentLanguage.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(InstrumentLanguage.instrument, instrument);
	}

	public String getLocal() {
		try {
			String data=getEntryString(InstrumentLanguage.local);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocal(String local) {
		setEntry(InstrumentLanguage.local, local);
	}

	public String getShowName() {
		try {
			String data=getEntryString(InstrumentLanguage.showName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShowName(String showName) {
		setEntry(InstrumentLanguage.showName, showName);
	}

	public String getDescription() {
		try {
			String data=getEntryString(InstrumentLanguage.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(InstrumentLanguage.description, description);
	}


}