package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.MoneyAccount;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TSettled4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;


public class Info_TRADESERV1011 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1011";

	public static final String accountID = "1";
	public static final String moneyAccountVec = "2";
	public static final String trade4CFDVec = "3";
	public static final String order4CFDVec = "4";
	public static final String tsettledVec = "5";

	public Info_TRADESERV1011(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(Info_TRADESERV1011.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(Info_TRADESERV1011.accountID, accountID);
	}

	public MoneyAccount[] getMoneyAccountVec() {
		try {
			MoneyAccount[] data=getEntryObjectVec(Info_TRADESERV1011.moneyAccountVec,new MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(MoneyAccount[] moneyAccountVec) {
		setEntry(Info_TRADESERV1011.moneyAccountVec, moneyAccountVec);
	}

	public TTrade4CFD[] getTrade4CFDVec() {
		try {
			TTrade4CFD[] data=getEntryObjectVec(Info_TRADESERV1011.trade4CFDVec,new TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(TTrade4CFD[] trade4CFDVec) {
		setEntry(Info_TRADESERV1011.trade4CFDVec, trade4CFDVec);
	}

	public TOrders4CFD[] getOrder4CFDVec() {
		try {
			TOrders4CFD[] data=getEntryObjectVec(Info_TRADESERV1011.order4CFDVec,new TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFDVec(TOrders4CFD[] order4CFDVec) {
		setEntry(Info_TRADESERV1011.order4CFDVec, order4CFDVec);
	}

	public TSettled4CFD[] getTsettledVec() {
		try {
			TSettled4CFD[] data=getEntryObjectVec(Info_TRADESERV1011.tsettledVec,new TSettled4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTsettledVec(TSettled4CFD[] tsettledVec) {
		setEntry(Info_TRADESERV1011.tsettledVec, tsettledVec);
	}


}