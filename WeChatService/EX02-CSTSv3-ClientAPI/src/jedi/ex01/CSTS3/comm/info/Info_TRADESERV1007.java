package jedi.ex01.CSTS3.comm.info;


public class Info_TRADESERV1007 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1007";

	public static final String userOperatorID = "1";
	public static final String uptradeOperatorID = "2";

	public Info_TRADESERV1007(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getUserOperatorID() {
		try {
			String data=getEntryString(Info_TRADESERV1007.userOperatorID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserOperatorID(String userOperatorID) {
		setEntry(Info_TRADESERV1007.userOperatorID, userOperatorID);
	}

	public String getUptradeOperatorID() {
		try {
			String data=getEntryString(Info_TRADESERV1007.uptradeOperatorID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUptradeOperatorID(String uptradeOperatorID) {
		setEntry(Info_TRADESERV1007.uptradeOperatorID, uptradeOperatorID);
	}


}