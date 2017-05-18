package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.MarginCall;


public class Info_TRADESERV1013 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1013";

	public static final String accountID = "1";
	public static final String marginCall = "2";

	public Info_TRADESERV1013(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(Info_TRADESERV1013.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(Info_TRADESERV1013.accountID, accountID);
	}

	public MarginCall getMarginCall() {
		try {
			MarginCall data=getEntryObject(Info_TRADESERV1013.marginCall);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMarginCall(MarginCall marginCall) {
		setEntry(Info_TRADESERV1013.marginCall, marginCall);
	}


}