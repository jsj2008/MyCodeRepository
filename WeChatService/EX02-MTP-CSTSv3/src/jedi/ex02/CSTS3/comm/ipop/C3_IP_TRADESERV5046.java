package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5046;


public class C3_IP_TRADESERV5046 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5046";

	public static final String account = "1";
	public static final String digist = "2";

	public C3_IP_TRADESERV5046(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5046 formatIP() {
		IP_TRADESERV5046 ip=new IP_TRADESERV5046();
		ip.setAccount(getAccount());
		ip.setDigist(getDigist());
		return ip;
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5046.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_TRADESERV5046.account, account);
	}

	public String getDigist() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5046.digist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDigist(String digist) {
		setEntry(C3_IP_TRADESERV5046.digist, digist);
	}


}