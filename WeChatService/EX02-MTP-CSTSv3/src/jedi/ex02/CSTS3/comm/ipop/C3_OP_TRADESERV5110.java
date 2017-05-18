package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.OP_TRADESERV5110;


public class C3_OP_TRADESERV5110 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5110";

	public static final String result = "1";

	public C3_OP_TRADESERV5110(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5110 data) throws Exception {
		super.parseFromSysData(data);
		setResult(data.getResult());
	}


	public int getResult() {
		try {
			int data=getEntryInt(C3_OP_TRADESERV5110.result);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setResult(int result) {
		setEntry(C3_OP_TRADESERV5110.result, result);
	}


}