package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5063 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5063";

	public static final String account = "1";
	public static final String password = "2";

	public IP_TRADESERV5063(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(IP_TRADESERV5063.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_TRADESERV5063.account, account);
	}

	public String getPassword() {
		try {
			String data=getEntryString(IP_TRADESERV5063.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(IP_TRADESERV5063.password, password);
	}


}