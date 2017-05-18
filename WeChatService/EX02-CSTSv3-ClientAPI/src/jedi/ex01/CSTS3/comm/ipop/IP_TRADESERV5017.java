package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5017 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5017";

	public static final String groupName = "1";

	public IP_TRADESERV5017(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(IP_TRADESERV5017.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(IP_TRADESERV5017.groupName, groupName);
	}


}