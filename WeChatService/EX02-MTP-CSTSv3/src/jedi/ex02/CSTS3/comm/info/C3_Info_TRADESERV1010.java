package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccount;
import jedi.ex02.CSTS3.comm.struct.C3_TOrderHis4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TSettled4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TTrade4CFD;
import jedi.v7.trade.comm.infor.Info_TRADESERV1010;


public class C3_Info_TRADESERV1010 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

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

	public C3_Info_TRADESERV1010(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1010 data) throws Exception {
		super.parseFromSysData(data);
		setAccountID(data.getAccountID());
		setTradeOperateID(data.getTradeOperateID());
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
		if(data.getOrderHis()!=null) {
			C3_TOrderHis4CFD orderHis = new C3_TOrderHis4CFD();
			orderHis.parseFromSysData(data.getOrderHis());
			setOrderHis(orderHis);
		}
		setDescription(data.getDescription());
		setLastTradeTime(data.getLastTradeTime());
		C3_TSettled4CFD[] tsettledVec = new C3_TSettled4CFD[data.getTsettledVec().length];
		for (int i = 0; i < data.getTsettledVec().length; i++) {
			tsettledVec[i]=new C3_TSettled4CFD();
			tsettledVec[i].parseFromSysData(data.getTsettledVec()[i]);
		}
		setTsettledVec(tsettledVec);
	}


	public long getAccountID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1010.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_Info_TRADESERV1010.accountID, accountID);
	}

	public String getTradeOperateID() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1010.tradeOperateID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeOperateID(String tradeOperateID) {
		setEntry(C3_Info_TRADESERV1010.tradeOperateID, tradeOperateID);
	}

	public C3_MoneyAccount[] getMoneyAccountVec() {
		try {
			C3_MoneyAccount[] data=getEntryObjectVec(C3_Info_TRADESERV1010.moneyAccountVec,new C3_MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(C3_MoneyAccount[] moneyAccountVec) {
		setEntry(C3_Info_TRADESERV1010.moneyAccountVec, moneyAccountVec);
	}

	public C3_TTrade4CFD[] getTrade4CFDVec() {
		try {
			C3_TTrade4CFD[] data=getEntryObjectVec(C3_Info_TRADESERV1010.trade4CFDVec,new C3_TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(C3_TTrade4CFD[] trade4CFDVec) {
		setEntry(C3_Info_TRADESERV1010.trade4CFDVec, trade4CFDVec);
	}

	public C3_TOrders4CFD[] getOrder4CFDVec() {
		try {
			C3_TOrders4CFD[] data=getEntryObjectVec(C3_Info_TRADESERV1010.order4CFDVec,new C3_TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFDVec(C3_TOrders4CFD[] order4CFDVec) {
		setEntry(C3_Info_TRADESERV1010.order4CFDVec, order4CFDVec);
	}

	public C3_TOrderHis4CFD getOrderHis() {
		try {
			C3_TOrderHis4CFD data=getEntryObject(C3_Info_TRADESERV1010.orderHis);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderHis(C3_TOrderHis4CFD orderHis) {
		setEntry(C3_Info_TRADESERV1010.orderHis, orderHis);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1010.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_Info_TRADESERV1010.description, description);
	}

	public long getLastTradeTime() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1010.lastTradeTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLastTradeTime(long lastTradeTime) {
		setEntry(C3_Info_TRADESERV1010.lastTradeTime, lastTradeTime);
	}

	public C3_TSettled4CFD[] getTsettledVec() {
		try {
			C3_TSettled4CFD[] data=getEntryObjectVec(C3_Info_TRADESERV1010.tsettledVec,new C3_TSettled4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTsettledVec(C3_TSettled4CFD[] tsettledVec) {
		setEntry(C3_Info_TRADESERV1010.tsettledVec, tsettledVec);
	}


}