package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5110 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5110";

	public static final String oldPasswordDig = "1";
	public static final String newPassword = "2";

	public IP_TRADESERV5110(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getOldPasswordDig() {
		try {
			String data=getEntryString(IP_TRADESERV5110.oldPasswordDig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOldPasswordDig(String oldPasswordDig) {
		setEntry(IP_TRADESERV5110.oldPasswordDig, oldPasswordDig);
	}

	public String getNewPassword() {
		try {
			String data=getEntryString(IP_TRADESERV5110.newPassword);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setNewPassword(String newPassword) {
		setEntry(IP_TRADESERV5110.newPassword, newPassword);
	}


}