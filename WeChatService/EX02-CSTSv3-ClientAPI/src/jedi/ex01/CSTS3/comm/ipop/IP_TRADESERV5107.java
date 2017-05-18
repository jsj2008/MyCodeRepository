package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5107 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5107";

	public static final String uptradeOperatorID = "1";

	public IP_TRADESERV5107(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getUptradeOperatorID() {
		try {
			String data=getEntryString(IP_TRADESERV5107.uptradeOperatorID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUptradeOperatorID(String uptradeOperatorID) {
		setEntry(IP_TRADESERV5107.uptradeOperatorID, uptradeOperatorID);
	}


}