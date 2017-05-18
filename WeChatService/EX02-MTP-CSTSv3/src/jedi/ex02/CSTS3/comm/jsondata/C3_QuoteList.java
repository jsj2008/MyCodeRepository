package jedi.ex02.CSTS3.comm.jsondata;

import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;


public class C3_QuoteList extends allone.json.AbstractJsonData {

	public static final String jsonId = "QuoteList";

	public static final String quotes = "1";

	public C3_QuoteList(){
		super();
		setEntry("jsonId", jsonId);
	}

	public C3_QuoteData[] getQuotes() {
		try {
			C3_QuoteData[] data=getEntryObjectVec(C3_QuoteList.quotes,new C3_QuoteData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuotes(C3_QuoteData[] quotes) {
		setEntry(C3_QuoteList.quotes, quotes);
	}


}