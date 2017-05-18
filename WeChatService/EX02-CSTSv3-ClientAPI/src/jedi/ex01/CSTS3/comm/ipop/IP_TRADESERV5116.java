package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.WithdrawApplication;


public class IP_TRADESERV5116 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5116";

	public static final String withdrawApplication = "1";
	public static final String password = "2";

	public IP_TRADESERV5116(){
		super();
		setEntry("jsonId", jsonId);
	}

	public WithdrawApplication getWithdrawApplication() {
		try {
			WithdrawApplication data=getEntryObject(IP_TRADESERV5116.withdrawApplication);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setWithdrawApplication(WithdrawApplication withdrawApplication) {
		setEntry(IP_TRADESERV5116.withdrawApplication, withdrawApplication);
	}

	public String getPassword() {
		try {
			String data=getEntryString(IP_TRADESERV5116.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(IP_TRADESERV5116.password, password);
	}


}