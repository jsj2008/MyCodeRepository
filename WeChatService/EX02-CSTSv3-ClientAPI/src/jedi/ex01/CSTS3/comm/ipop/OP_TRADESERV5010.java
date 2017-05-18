package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.BasicCurrency;


public class OP_TRADESERV5010 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5010";

	public static final String basicCurrencyVec = "1";

	public OP_TRADESERV5010(){
		super();
		setEntry("jsonId", jsonId);
	}

	public BasicCurrency[] getBasicCurrencyVec() {
		try {
			BasicCurrency[] data=getEntryObjectVec(OP_TRADESERV5010.basicCurrencyVec,new BasicCurrency[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBasicCurrencyVec(BasicCurrency[] basicCurrencyVec) {
		setEntry(OP_TRADESERV5010.basicCurrencyVec, basicCurrencyVec);
	}


}