package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.MoneyAccount;
import jedi.ex01.CSTS3.comm.struct.TOrderHis4CFD;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TSettled4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;


public class Info_TRADESERV1010 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1010";

	public static final String accountID = "1";
	public static final String tradeOperateID = "2";
	public static final String moneyAccountVec = "3";
	public static final String trade4CFDVec = "4";
	public static final String order4CFDVec = "5";
	public static final String orderHis = "6";
	public static final String description = "7";
	public static final String lastTradeTime = "8";
	public static final String tsettledVec = "9";

	public Info_TRADESERV1010(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(Info_TRADESERV1010.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(Info_TRADESERV1010.accountID, accountID);
	}

	public String getTradeOperateID() {
		try {
			String data=getEntryString(Info_TRADESERV1010.tradeOperateID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeOperateID(String tradeOperateID) {
		setEntry(Info_TRADESERV1010.tradeOperateID, tradeOperateID);
	}

	public MoneyAccount[] getMoneyAccountVec() {
		try {
			MoneyAccount[] data=getEntryObjectVec(Info_TRADESERV1010.moneyAccountVec,new MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(MoneyAccount[] moneyAccountVec) {
		setEntry(Info_TRADESERV1010.moneyAccountVec, moneyAccountVec);
	}

	public TTrade4CFD[] getTrade4CFDVec() {
		try {
			TTrade4CFD[] data=getEntryObjectVec(Info_TRADESERV1010.trade4CFDVec,new TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(TTrade4CFD[] trade4CFDVec) {
		setEntry(Info_TRADESERV1010.trade4CFDVec, trade4CFDVec);
	}

	public TOrders4CFD[] getOrder4CFDVec() {
		try {
			TOrders4CFD[] data=getEntryObjectVec(Info_TRADESERV1010.order4CFDVec,new TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFDVec(TOrders4CFD[] order4CFDVec) {
		setEntry(Info_TRADESERV1010.order4CFDVec, order4CFDVec);
	}

	public TOrderHis4CFD getOrderHis() {
		try {
			TOrderHis4CFD data=getEntryObject(Info_TRADESERV1010.orderHis);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderHis(TOrderHis4CFD orderHis) {
		setEntry(Info_TRADESERV1010.orderHis, orderHis);
	}

	public String getDescription() {
		try {
			String data=getEntryString(Info_TRADESERV1010.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(Info_TRADESERV1010.description, description);
	}

	public long getLastTradeTime() {
		try {
			long data=getEntryLong(Info_TRADESERV1010.lastTradeTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLastTradeTime(long lastTradeTime) {
		setEntry(Info_TRADESERV1010.lastTradeTime, lastTradeTime);
	}

	public TSettled4CFD[] getTsettledVec() {
		try {
			TSettled4CFD[] data=getEntryObjectVec(Info_TRADESERV1010.tsettledVec,new TSettled4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTsettledVec(TSettled4CFD[] tsettledVec) {
		setEntry(Info_TRADESERV1010.tsettledVec, tsettledVec);
	}


}