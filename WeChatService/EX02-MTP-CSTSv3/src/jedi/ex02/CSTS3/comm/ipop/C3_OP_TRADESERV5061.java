package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_MessageToAccount;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5061;


public class C3_OP_TRADESERV5061 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5061";

	public static final String messages = "1";

	public C3_OP_TRADESERV5061(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5061 data) throws Exception {
		super.parseFromSysData(data);
		C3_MessageToAccount[] messages = new C3_MessageToAccount[data.getMessages().length];
		for (int i = 0; i < data.getMessages().length; i++) {
			messages[i]=new C3_MessageToAccount();
			messages[i].parseFromSysData(data.getMessages()[i]);
		}
		setMessages(messages);
	}


	public C3_MessageToAccount[] getMessages() {
		try {
			C3_MessageToAccount[] data=getEntryObjectVec(C3_OP_TRADESERV5061.messages,new C3_MessageToAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessages(C3_MessageToAccount[] messages) {
		setEntry(C3_OP_TRADESERV5061.messages, messages);
	}


}