package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_PriceWarning;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5026;


public class C3_OP_TRADESERV5026 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5026";

	public static final String priceWarningVec = "1";

	public C3_OP_TRADESERV5026(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5026 data) throws Exception {
		super.parseFromSysData(data);
		C3_PriceWarning[] priceWarningVec = new C3_PriceWarning[data.getPriceWarningVec().length];
		for (int i = 0; i < data.getPriceWarningVec().length; i++) {
			priceWarningVec[i]=new C3_PriceWarning();
			priceWarningVec[i].parseFromSysData(data.getPriceWarningVec()[i]);
		}
		setPriceWarningVec(priceWarningVec);
	}


	public C3_PriceWarning[] getPriceWarningVec() {
		try {
			C3_PriceWarning[] data=getEntryObjectVec(C3_OP_TRADESERV5026.priceWarningVec,new C3_PriceWarning[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceWarningVec(C3_PriceWarning[] priceWarningVec) {
		setEntry(C3_OP_TRADESERV5026.priceWarningVec, priceWarningVec);
	}


}