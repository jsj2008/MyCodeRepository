package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.PriceWarning;


public class OP_TRADESERV5026 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5026";

	public static final String priceWarningVec = "1";

	public OP_TRADESERV5026(){
		super();
		setEntry("jsonId", jsonId);
	}

	public PriceWarning[] getPriceWarningVec() {
		try {
			PriceWarning[] data=getEntryObjectVec(OP_TRADESERV5026.priceWarningVec,new PriceWarning[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceWarningVec(PriceWarning[] priceWarningVec) {
		setEntry(OP_TRADESERV5026.priceWarningVec, priceWarningVec);
	}


}