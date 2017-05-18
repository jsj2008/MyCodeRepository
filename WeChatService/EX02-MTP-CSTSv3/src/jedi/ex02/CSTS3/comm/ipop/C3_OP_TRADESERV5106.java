package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_PriceWarning;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5106;


public class C3_OP_TRADESERV5106 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5106";

	public static final String addedPriceWarning = "1";

	public C3_OP_TRADESERV5106(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5106 data) throws Exception {
		super.parseFromSysData(data);
		C3_PriceWarning addedPriceWarning = new C3_PriceWarning();
		addedPriceWarning.parseFromSysData(data.getAddedPriceWarning());
		setAddedPriceWarning(addedPriceWarning);
	}


	public C3_PriceWarning getAddedPriceWarning() {
		try {
			C3_PriceWarning data=getEntryObject(C3_OP_TRADESERV5106.addedPriceWarning);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAddedPriceWarning(C3_PriceWarning addedPriceWarning) {
		setEntry(C3_OP_TRADESERV5106.addedPriceWarning, addedPriceWarning);
	}


}