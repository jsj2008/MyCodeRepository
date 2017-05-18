package jedi.ex01.CSTS3.comm.jsondata;

import jedi.ex01.CSTS3.comm.struct.QuoteData;


public class QuoteList extends allone.json.AbstractJsonData {

	public static final String jsonId = "QuoteList";

	public static final String quotes = "1";

	public QuoteList(){
		super();
		setEntry("jsonId", jsonId);
	}

	public QuoteData[] getQuotes() {
		try {
			QuoteData[] data=getEntryObjectVec(QuoteList.quotes,new QuoteData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuotes(QuoteData[] quotes) {
		setEntry(QuoteList.quotes, quotes);
	}


}