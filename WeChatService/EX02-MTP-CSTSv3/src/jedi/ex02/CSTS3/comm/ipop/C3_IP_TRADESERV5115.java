package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5115;


public class C3_IP_TRADESERV5115 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5115";

	public static final String title = "1";
	public static final String context = "2";

	public C3_IP_TRADESERV5115(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5115 formatIP() {
		IP_TRADESERV5115 ip=new IP_TRADESERV5115();
		ip.setTitle(getTitle());
		ip.setContext(getContext());
		return ip;
	}

	public String getTitle() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5115.title);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTitle(String title) {
		setEntry(C3_IP_TRADESERV5115.title, title);
	}

	public String getContext() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5115.context);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setContext(String context) {
		setEntry(C3_IP_TRADESERV5115.context, context);
	}


}