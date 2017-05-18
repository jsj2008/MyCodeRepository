package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.OP_BankServ1004;

public class C3_OP_BankServ1004 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ1004";

	public static final String state = "1";

	public C3_OP_BankServ1004(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ1004 data) throws Exception {
		super.parseFromSysData(data);
		setState(data.getState());
	}

	public int getState() {
		try {
			return getEntryInt(C3_OP_BankServ1004.state);
		} catch (Exception e) {
			return 0;
		}
	}

	public void setState(int state) {
		this.setEntry(C3_OP_BankServ1004.state, state);
	}

}