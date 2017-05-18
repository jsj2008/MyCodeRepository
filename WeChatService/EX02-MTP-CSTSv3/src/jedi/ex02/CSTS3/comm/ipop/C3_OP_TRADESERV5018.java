package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_UserLogin;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5018;


public class C3_OP_TRADESERV5018 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5018";

	public static final String userLogin = "1";

	public C3_OP_TRADESERV5018(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5018 data) throws Exception {
		super.parseFromSysData(data);
		C3_UserLogin userLogin = new C3_UserLogin();
		userLogin.parseFromSysData(data.getUserLogin());
		setUserLogin(userLogin);
	}


	public C3_UserLogin getUserLogin() {
		try {
			C3_UserLogin data=getEntryObject(C3_OP_TRADESERV5018.userLogin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserLogin(C3_UserLogin userLogin) {
		setEntry(C3_OP_TRADESERV5018.userLogin, userLogin);
	}


}