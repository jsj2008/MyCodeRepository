package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccount;
import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TTrade4CFD;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5041;


public class C3_OP_TRADESERV5041 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5041";

	public static final String moneyAccountVec = "1";
	public static final String order4CFDVec = "2";
	public static final String trade4CFDVec = "3";

	public C3_OP_TRADESERV5041(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5041 data) throws Exception {
		super.parseFromSysData(data);
		C3_MoneyAccount[] moneyAccountVec = new C3_MoneyAccount[data.getMoneyAccountVec().length];
		for (int i = 0; i < data.getMoneyAccountVec().length; i++) {
			moneyAccountVec[i]=new C3_MoneyAccount();
			moneyAccountVec[i].parseFromSysData(data.getMoneyAccountVec()[i]);
		}
		setMoneyAccountVec(moneyAccountVec);
		C3_TOrders4CFD[] order4CFDVec = new C3_TOrders4CFD[data.getOrder4CFDVec().length];
		for (int i = 0; i < data.getOrder4CFDVec().length; i++) {
			order4CFDVec[i]=new C3_TOrders4CFD();
			order4CFDVec[i].parseFromSysData(data.getOrder4CFDVec()[i]);
		}
		setOrder4CFDVec(order4CFDVec);
		C3_TTrade4CFD[] trade4CFDVec = new C3_TTrade4CFD[data.getTrade4CFDVec().length];
		for (int i = 0; i < data.getTrade4CFDVec().length; i++) {
			trade4CFDVec[i]=new C3_TTrade4CFD();
			trade4CFDVec[i].parseFromSysData(data.getTrade4CFDVec()[i]);
		}
		setTrade4CFDVec(trade4CFDVec);
	}


	public C3_MoneyAccount[] getMoneyAccountVec() {
		try {
			C3_MoneyAccount[] data=getEntryObjectVec(C3_OP_TRADESERV5041.moneyAccountVec,new C3_MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(C3_MoneyAccount[] moneyAccountVec) {
		setEntry(C3_OP_TRADESERV5041.moneyAccountVec, moneyAccountVec);
	}

	public C3_TOrders4CFD[] getOrder4CFDVec() {
		try {
			C3_TOrders4CFD[] data=getEntryObjectVec(C3_OP_TRADESERV5041.order4CFDVec,new C3_TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFDVec(C3_TOrders4CFD[] order4CFDVec) {
		setEntry(C3_OP_TRADESERV5041.order4CFDVec, order4CFDVec);
	}

	public C3_TTrade4CFD[] getTrade4CFDVec() {
		try {
			C3_TTrade4CFD[] data=getEntryObjectVec(C3_OP_TRADESERV5041.trade4CFDVec,new C3_TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(C3_TTrade4CFD[] trade4CFDVec) {
		setEntry(C3_OP_TRADESERV5041.trade4CFDVec, trade4CFDVec);
	}


}