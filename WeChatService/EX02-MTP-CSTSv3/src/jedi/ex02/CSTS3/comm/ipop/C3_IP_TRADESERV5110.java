package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5110;


public class C3_IP_TRADESERV5110 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5110";

	public static final String oldPasswordDig = "1";
	public static final String newPassword = "2";

	public C3_IP_TRADESERV5110(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5110 formatIP() {
		IP_TRADESERV5110 ip=new IP_TRADESERV5110();
		ip.setOldPasswordDig(getOldPasswordDig());
		ip.setNewPassword(getNewPassword());
		return ip;
	}

	public String getOldPasswordDig() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5110.oldPasswordDig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOldPasswordDig(String oldPasswordDig) {
		setEntry(C3_IP_TRADESERV5110.oldPasswordDig, oldPasswordDig);
	}

	public String getNewPassword() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5110.newPassword);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setNewPassword(String newPassword) {
		setEntry(C3_IP_TRADESERV5110.newPassword, newPassword);
	}


}