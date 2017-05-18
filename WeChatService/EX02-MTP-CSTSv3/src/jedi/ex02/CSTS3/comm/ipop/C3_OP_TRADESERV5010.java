package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_BasicCurrency;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5010;


public class C3_OP_TRADESERV5010 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5010";

	public static final String basicCurrencyVec = "1";

	public C3_OP_TRADESERV5010(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5010 data) throws Exception {
		super.parseFromSysData(data);
		C3_BasicCurrency[] basicCurrencyVec = new C3_BasicCurrency[data.getBasicCurrencyVec().length];
		for (int i = 0; i < data.getBasicCurrencyVec().length; i++) {
			basicCurrencyVec[i]=new C3_BasicCurrency();
			basicCurrencyVec[i].parseFromSysData(data.getBasicCurrencyVec()[i]);
		}
		setBasicCurrencyVec(basicCurrencyVec);
	}


	public C3_BasicCurrency[] getBasicCurrencyVec() {
		try {
			C3_BasicCurrency[] data=getEntryObjectVec(C3_OP_TRADESERV5010.basicCurrencyVec,new C3_BasicCurrency[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBasicCurrencyVec(C3_BasicCurrency[] basicCurrencyVec) {
		setEntry(C3_OP_TRADESERV5010.basicCurrencyVec, basicCurrencyVec);
	}


}