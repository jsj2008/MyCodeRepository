package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.PriceWarning;


public class OP_TRADESERV5106 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5106";

	public static final String addedPriceWarning = "1";

	public OP_TRADESERV5106(){
		super();
		setEntry("jsonId", jsonId);
	}

	public PriceWarning getAddedPriceWarning() {
		try {
			PriceWarning data=getEntryObject(OP_TRADESERV5106.addedPriceWarning);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAddedPriceWarning(PriceWarning addedPriceWarning) {
		setEntry(OP_TRADESERV5106.addedPriceWarning, addedPriceWarning);
	}


}