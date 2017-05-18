package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5115 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5115";

	public static final String title = "1";
	public static final String context = "2";

	public IP_TRADESERV5115(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getTitle() {
		try {
			String data=getEntryString(IP_TRADESERV5115.title);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTitle(String title) {
		setEntry(IP_TRADESERV5115.title, title);
	}

	public String getContext() {
		try {
			String data=getEntryString(IP_TRADESERV5115.context);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setContext(String context) {
		setEntry(IP_TRADESERV5115.context, context);
	}


}