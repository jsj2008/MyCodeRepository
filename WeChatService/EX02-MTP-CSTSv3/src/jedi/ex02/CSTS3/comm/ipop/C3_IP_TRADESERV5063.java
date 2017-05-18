package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5063;


public class C3_IP_TRADESERV5063 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5063";

	public static final String account = "1";
	public static final String password = "2";

	public C3_IP_TRADESERV5063(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5063 formatIP() {
		IP_TRADESERV5063 ip=new IP_TRADESERV5063();
		ip.setAccount(getAccount());
		ip.setPassword(getPassword());
		return ip;
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5063.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_TRADESERV5063.account, account);
	}

	public String getPassword() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5063.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(C3_IP_TRADESERV5063.password, password);
	}


}