package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.MoneyAccount;


public class OP_TRADESERV5022 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5022";

	public static final String moneyAccountVec = "1";

	public OP_TRADESERV5022(){
		super();
		setEntry("jsonId", jsonId);
	}

	public MoneyAccount[] getMoneyAccountVec() {
		try {
			MoneyAccount[] data=getEntryObjectVec(OP_TRADESERV5022.moneyAccountVec,new MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(MoneyAccount[] moneyAccountVec) {
		setEntry(OP_TRADESERV5022.moneyAccountVec, moneyAccountVec);
	}


}