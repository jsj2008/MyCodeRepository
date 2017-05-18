package jedi.ex01.CSTS3.comm.jsondata;


public class VolumnRequest extends allone.json.AbstractJsonData {

	public static final String jsonId = "VolumnRequest";

	public static final String instruments = "1";

	public VolumnRequest(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String[] getInstruments() {
		try {
			String[] data=getEntryObjectVec(VolumnRequest.instruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstruments(String[] instruments) {
		setEntry(VolumnRequest.instruments, instruments);
	}


}