package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.OP_TRADESERV5046;


public class C3_OP_TRADESERV5046 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5046";

	public static final String result = "1";

	public C3_OP_TRADESERV5046(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5046 data) throws Exception {
		super.parseFromSysData(data);
		setResult(data.isResult());
	}


	public boolean isResult() {
		try {
			boolean data=getEntryBoolean(C3_OP_TRADESERV5046.result);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setResult(boolean result) {
		setEntry(C3_OP_TRADESERV5046.result, result);
	}


}