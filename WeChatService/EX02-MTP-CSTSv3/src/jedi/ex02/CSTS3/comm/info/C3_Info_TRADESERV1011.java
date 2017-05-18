package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccount;
import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TSettled4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TTrade4CFD;
import jedi.v7.trade.comm.infor.Info_TRADESERV1011;


public class C3_Info_TRADESERV1011 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1011";

	public static final String accountID = "1";
	public static final String moneyAccountVec = "2";
	public static final String trade4CFDVec = "3";
	public static final String order4CFDVec = "4";
	public static final String tsettledVec = "5";

	public C3_Info_TRADESERV1011(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1011 data) throws Exception {
		super.parseFromSysData(data);
		setAccountID(data.getAccountID());
		C3_MoneyAccount[] moneyAccountVec = new C3_MoneyAccount[data.getMoneyAccountVec().length];
		for (int i = 0; i < data.getMoneyAccountVec().length; i++) {
			moneyAccountVec[i]=new C3_MoneyAccount();
			moneyAccountVec[i].parseFromSysData(data.getMoneyAccountVec()[i]);
		}
		setMoneyAccountVec(moneyAccountVec);
		C3_TTrade4CFD[] trade4CFDVec = new C3_TTrade4CFD[data.getTrade4CFDVec().length];
		for (int i = 0; i < data.getTrade4CFDVec().length; i++) {
			trade4CFDVec[i]=new C3_TTrade4CFD();
			trade4CFDVec[i].parseFromSysData(data.getTrade4CFDVec()[i]);
		}
		setTrade4CFDVec(trade4CFDVec);
		C3_TOrders4CFD[] order4CFDVec = new C3_TOrders4CFD[data.getOrder4CFDVec().length];
		for (int i = 0; i < data.getOrder4CFDVec().length; i++) {
			order4CFDVec[i]=new C3_TOrders4CFD();
			order4CFDVec[i].parseFromSysData(data.getOrder4CFDVec()[i]);
		}
		setOrder4CFDVec(order4CFDVec);
		C3_TSettled4CFD[] tsettledVec = new C3_TSettled4CFD[data.getSettledVec().length];
		for (int i = 0; i < data.getSettledVec().length; i++) {
			tsettledVec[i]=new C3_TSettled4CFD();
			tsettledVec[i].parseFromSysData(data.getSettledVec()[i]);
		}
		setTsettledVec(tsettledVec);
	}


	public long getAccountID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1011.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_Info_TRADESERV1011.accountID, accountID);
	}

	public C3_MoneyAccount[] getMoneyAccountVec() {
		try {
			C3_MoneyAccount[] data=getEntryObjectVec(C3_Info_TRADESERV1011.moneyAccountVec,new C3_MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(C3_MoneyAccount[] moneyAccountVec) {
		setEntry(C3_Info_TRADESERV1011.moneyAccountVec, moneyAccountVec);
	}

	public C3_TTrade4CFD[] getTrade4CFDVec() {
		try {
			C3_TTrade4CFD[] data=getEntryObjectVec(C3_Info_TRADESERV1011.trade4CFDVec,new C3_TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(C3_TTrade4CFD[] trade4CFDVec) {
		setEntry(C3_Info_TRADESERV1011.trade4CFDVec, trade4CFDVec);
	}

	public C3_TOrders4CFD[] getOrder4CFDVec() {
		try {
			C3_TOrders4CFD[] data=getEntryObjectVec(C3_Info_TRADESERV1011.order4CFDVec,new C3_TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFDVec(C3_TOrders4CFD[] order4CFDVec) {
		setEntry(C3_Info_TRADESERV1011.order4CFDVec, order4CFDVec);
	}

	public C3_TSettled4CFD[] getTsettledVec() {
		try {
			C3_TSettled4CFD[] data=getEntryObjectVec(C3_Info_TRADESERV1011.tsettledVec,new C3_TSettled4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTsettledVec(C3_TSettled4CFD[] tsettledVec) {
		setEntry(C3_Info_TRADESERV1011.tsettledVec, tsettledVec);
	}


}