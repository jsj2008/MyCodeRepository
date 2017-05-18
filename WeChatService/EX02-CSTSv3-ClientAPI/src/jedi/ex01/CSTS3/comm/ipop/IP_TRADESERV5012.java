package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5012 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5012";

	public static final String instrumentTypeName = "1";

	public IP_TRADESERV5012(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrumentTypeName() {
		try {
			String data=getEntryString(IP_TRADESERV5012.instrumentTypeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentTypeName(String instrumentTypeName) {
		setEntry(IP_TRADESERV5012.instrumentTypeName, instrumentTypeName);
	}


}