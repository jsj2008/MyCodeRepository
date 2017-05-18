package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_WithdrawApplication;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5116;


public class C3_IP_TRADESERV5116 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5116";

	public static final String withdrawApplication = "1";
	public static final String password = "2";

	public C3_IP_TRADESERV5116(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5116 formatIP() {
		IP_TRADESERV5116 ip=new IP_TRADESERV5116();
		ip.setWithdrawApplication(getWithdrawApplication().format());
		ip.setPassword(getPassword());
		return ip;
	}

	public C3_WithdrawApplication getWithdrawApplication() {
		try {
			C3_WithdrawApplication data=getEntryObject(C3_IP_TRADESERV5116.withdrawApplication);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setWithdrawApplication(C3_WithdrawApplication withdrawApplication) {
		setEntry(C3_IP_TRADESERV5116.withdrawApplication, withdrawApplication);
	}

	public String getPassword() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5116.password);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(C3_IP_TRADESERV5116.password, password);
	}


}