package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccount;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5022;


public class C3_OP_TRADESERV5022 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5022";

	public static final String moneyAccountVec = "1";

	public C3_OP_TRADESERV5022(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5022 data) throws Exception {
		super.parseFromSysData(data);
		C3_MoneyAccount[] moneyAccountVec = new C3_MoneyAccount[data.getMoneyAccountVec().length];
		for (int i = 0; i < data.getMoneyAccountVec().length; i++) {
			moneyAccountVec[i]=new C3_MoneyAccount();
			moneyAccountVec[i].parseFromSysData(data.getMoneyAccountVec()[i]);
		}
		setMoneyAccountVec(moneyAccountVec);
	}


	public C3_MoneyAccount[] getMoneyAccountVec() {
		try {
			C3_MoneyAccount[] data=getEntryObjectVec(C3_OP_TRADESERV5022.moneyAccountVec,new C3_MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(C3_MoneyAccount[] moneyAccountVec) {
		setEntry(C3_OP_TRADESERV5022.moneyAccountVec, moneyAccountVec);
	}


}