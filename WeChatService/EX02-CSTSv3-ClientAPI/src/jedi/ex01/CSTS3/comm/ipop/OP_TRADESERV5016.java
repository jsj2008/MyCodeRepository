package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TradeTypeConfig;


public class OP_TRADESERV5016 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5016";

	public static final String tradeTypeConfigVec = "1";

	public OP_TRADESERV5016(){
		super();
		setEntry("jsonId", jsonId);
	}

	public TradeTypeConfig[] getTradeTypeConfigVec() {
		try {
			TradeTypeConfig[] data=getEntryObjectVec(OP_TRADESERV5016.tradeTypeConfigVec,new TradeTypeConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeTypeConfigVec(TradeTypeConfig[] tradeTypeConfigVec) {
		setEntry(OP_TRADESERV5016.tradeTypeConfigVec, tradeTypeConfigVec);
	}


}