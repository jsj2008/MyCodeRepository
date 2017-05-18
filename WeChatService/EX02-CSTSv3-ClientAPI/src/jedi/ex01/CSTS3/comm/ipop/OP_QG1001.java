package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.QuoteData;


public class OP_QG1001 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_QG1001";

	public static final String quoteList = "1";

	public OP_QG1001(){
		super();
		setEntry("jsonId", jsonId);
	}

	public QuoteData[] getQuoteList() {
		try {
			QuoteData[] data=getEntryObjectVec(OP_QG1001.quoteList,new QuoteData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteList(QuoteData[] quoteList) {
		setEntry(OP_QG1001.quoteList, quoteList);
	}


}