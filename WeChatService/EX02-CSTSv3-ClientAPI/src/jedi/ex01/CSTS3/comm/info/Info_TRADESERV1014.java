package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.MessageToAccount;


public class Info_TRADESERV1014 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1014";

	public static final String message = "1";

	public Info_TRADESERV1014(){
		super();
		setEntry("jsonId", jsonId);
	}

	public MessageToAccount getMessage() {
		try {
			MessageToAccount data=getEntryObject(Info_TRADESERV1014.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(MessageToAccount message) {
		setEntry(Info_TRADESERV1014.message, message);
	}


}