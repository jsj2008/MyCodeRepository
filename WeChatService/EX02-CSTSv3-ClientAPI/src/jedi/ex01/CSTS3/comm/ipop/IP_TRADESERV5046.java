package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5046 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5046";

	public static final String account = "1";
	public static final String digist = "2";

	public IP_TRADESERV5046(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(IP_TRADESERV5046.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(IP_TRADESERV5046.account, account);
	}

	public String getDigist() {
		try {
			String data=getEntryString(IP_TRADESERV5046.digist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDigist(String digist) {
		setEntry(IP_TRADESERV5046.digist, digist);
	}


}