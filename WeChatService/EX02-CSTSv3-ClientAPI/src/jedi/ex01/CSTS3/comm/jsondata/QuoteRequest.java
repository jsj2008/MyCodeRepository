package jedi.ex01.CSTS3.comm.jsondata;


public class QuoteRequest extends allone.json.AbstractJsonData {

	public static final String jsonId = "QuoteRequest";

	public static final String instruments = "1";

	public QuoteRequest(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String[] getInstruments() {
		try {
			String[] data=getEntryObjectVec(QuoteRequest.instruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstruments(String[] instruments) {
		setEntry(QuoteRequest.instruments, instruments);
	}


}