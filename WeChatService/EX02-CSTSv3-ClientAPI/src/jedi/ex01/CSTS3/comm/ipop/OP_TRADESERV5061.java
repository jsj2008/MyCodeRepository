package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.MessageToAccount;


public class OP_TRADESERV5061 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5061";

	public static final String messages = "1";

	public OP_TRADESERV5061(){
		super();
		setEntry("jsonId", jsonId);
	}

	public MessageToAccount[] getMessages() {
		try {
			MessageToAccount[] data=getEntryObjectVec(OP_TRADESERV5061.messages,new MessageToAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessages(MessageToAccount[] messages) {
		setEntry(OP_TRADESERV5061.messages, messages);
	}


}