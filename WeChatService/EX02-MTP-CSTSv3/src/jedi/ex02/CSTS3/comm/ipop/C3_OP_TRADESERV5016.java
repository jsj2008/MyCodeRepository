package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_TradeTypeConfig;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5016;


public class C3_OP_TRADESERV5016 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5016";

	public static final String tradeTypeConfigVec = "1";

	public C3_OP_TRADESERV5016(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5016 data) throws Exception {
		super.parseFromSysData(data);
		C3_TradeTypeConfig[] tradeTypeConfigVec = new C3_TradeTypeConfig[data.getTradeTypeConfigVec().length];
		for (int i = 0; i < data.getTradeTypeConfigVec().length; i++) {
			tradeTypeConfigVec[i]=new C3_TradeTypeConfig();
			tradeTypeConfigVec[i].parseFromSysData(data.getTradeTypeConfigVec()[i]);
		}
		setTradeTypeConfigVec(tradeTypeConfigVec);
	}


	public C3_TradeTypeConfig[] getTradeTypeConfigVec() {
		try {
			C3_TradeTypeConfig[] data=getEntryObjectVec(C3_OP_TRADESERV5016.tradeTypeConfigVec,new C3_TradeTypeConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeTypeConfigVec(C3_TradeTypeConfig[] tradeTypeConfigVec) {
		setEntry(C3_OP_TRADESERV5016.tradeTypeConfigVec, tradeTypeConfigVec);
	}


}