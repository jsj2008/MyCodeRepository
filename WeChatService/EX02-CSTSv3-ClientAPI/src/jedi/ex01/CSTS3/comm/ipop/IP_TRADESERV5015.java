package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5015 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5015";

	public static final String instrumentName = "1";

	public IP_TRADESERV5015(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(IP_TRADESERV5015.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(IP_TRADESERV5015.instrumentName, instrumentName);
	}


}