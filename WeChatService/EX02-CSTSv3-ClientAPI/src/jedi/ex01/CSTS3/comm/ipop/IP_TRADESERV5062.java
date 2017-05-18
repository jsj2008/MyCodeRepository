package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5062 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5062";

	public static final String messageGuid = "1";

	public IP_TRADESERV5062(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getMessageGuid() {
		try {
			String data=getEntryString(IP_TRADESERV5062.messageGuid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessageGuid(String messageGuid) {
		setEntry(IP_TRADESERV5062.messageGuid, messageGuid);
	}


}