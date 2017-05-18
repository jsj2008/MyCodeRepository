package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.MoneyAccount;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;


public class OP_TRADESERV5041 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5041";

	public static final String moneyAccountVec = "1";
	public static final String order4CFDVec = "2";
	public static final String trade4CFDVec = "3";

	public OP_TRADESERV5041(){
		super();
		setEntry("jsonId", jsonId);
	}

	public MoneyAccount[] getMoneyAccountVec() {
		try {
			MoneyAccount[] data=getEntryObjectVec(OP_TRADESERV5041.moneyAccountVec,new MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(MoneyAccount[] moneyAccountVec) {
		setEntry(OP_TRADESERV5041.moneyAccountVec, moneyAccountVec);
	}

	public TOrders4CFD[] getOrder4CFDVec() {
		try {
			TOrders4CFD[] data=getEntryObjectVec(OP_TRADESERV5041.order4CFDVec,new TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFDVec(TOrders4CFD[] order4CFDVec) {
		setEntry(OP_TRADESERV5041.order4CFDVec, order4CFDVec);
	}

	public TTrade4CFD[] getTrade4CFDVec() {
		try {
			TTrade4CFD[] data=getEntryObjectVec(OP_TRADESERV5041.trade4CFDVec,new TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(TTrade4CFD[] trade4CFDVec) {
		setEntry(OP_TRADESERV5041.trade4CFDVec, trade4CFDVec);
	}


}