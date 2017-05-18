package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.UserLogin;


public class OP_TRADESERV5018 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5018";

	public static final String userLogin = "1";

	public OP_TRADESERV5018(){
		super();
		setEntry("jsonId", jsonId);
	}

	public UserLogin getUserLogin() {
		try {
			UserLogin data=getEntryObject(OP_TRADESERV5018.userLogin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserLogin(UserLogin userLogin) {
		setEntry(OP_TRADESERV5018.userLogin, userLogin);
	}


}