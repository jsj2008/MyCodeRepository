package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_MessageToAccount;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5062;


public class C3_OP_TRADESERV5062 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5062";

	public static final String message = "1";

	public C3_OP_TRADESERV5062(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5062 data) throws Exception {
		super.parseFromSysData(data);
		C3_MessageToAccount message = new C3_MessageToAccount();
		message.parseFromSysData(data.getMessage());
		setMessage(message);
	}


	public C3_MessageToAccount getMessage() {
		try {
			C3_MessageToAccount data=getEntryObject(C3_OP_TRADESERV5062.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(C3_MessageToAccount message) {
		setEntry(C3_OP_TRADESERV5062.message, message);
	}


}