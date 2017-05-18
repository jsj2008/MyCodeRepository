package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccountStreamDetails;


public class C3_OP_REPORT2902 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_REPORT2902";

	public static final String accountStreamVec = "1";

	public C3_OP_REPORT2902(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public C3_MoneyAccountStreamDetails[] getAccountStreamVec() {
		try {
			C3_MoneyAccountStreamDetails[] data=getEntryObjectVec(C3_OP_REPORT2902.accountStreamVec,new C3_MoneyAccountStreamDetails[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountStreamVec(C3_MoneyAccountStreamDetails[] accountStreamVec) {
		setEntry(C3_OP_REPORT2902.accountStreamVec, accountStreamVec);
	}


}