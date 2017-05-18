package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.MessageToAccount;


public class OP_TRADESERV5062 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5062";

	public static final String message = "1";

	public OP_TRADESERV5062(){
		super();
		setEntry("jsonId", jsonId);
	}

	public MessageToAccount getMessage() {
		try {
			MessageToAccount data=getEntryObject(OP_TRADESERV5062.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(MessageToAccount message) {
		setEntry(OP_TRADESERV5062.message, message);
	}


}