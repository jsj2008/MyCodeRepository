package jedi.ex02.CSTS3.comm.jsondata;


public class C3_QuoteRequest extends allone.json.AbstractJsonData {

	public static final String jsonId = "QuoteRequest";

	public static final String instruments = "1";

	public C3_QuoteRequest(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String[] getInstruments() {
		try {
			String[] data=getEntryObjectVec(C3_QuoteRequest.instruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstruments(String[] instruments) {
		setEntry(C3_QuoteRequest.instruments, instruments);
	}


}