package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.MoneyAccountStreamDetails;


public class OP_REPORT2902 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_REPORT2902";

	public static final String accountStreamVec = "1";

	public OP_REPORT2902(){
		super();
		setEntry("jsonId", jsonId);
	}

	public MoneyAccountStreamDetails[] getAccountStreamVec() {
		try {
			MoneyAccountStreamDetails[] data=getEntryObjectVec(OP_REPORT2902.accountStreamVec,new MoneyAccountStreamDetails[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountStreamVec(MoneyAccountStreamDetails[] accountStreamVec) {
		setEntry(OP_REPORT2902.accountStreamVec, accountStreamVec);
	}


}