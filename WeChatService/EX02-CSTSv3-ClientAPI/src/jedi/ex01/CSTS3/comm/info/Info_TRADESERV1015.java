package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.PriceWarning;


public class Info_TRADESERV1015 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1015";

	public static final String priceWarning = "1";

	public Info_TRADESERV1015(){
		super();
		setEntry("jsonId", jsonId);
	}

	public PriceWarning getPriceWarning() {
		try {
			PriceWarning data=getEntryObject(Info_TRADESERV1015.priceWarning);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceWarning(PriceWarning priceWarning) {
		setEntry(Info_TRADESERV1015.priceWarning, priceWarning);
	}


}