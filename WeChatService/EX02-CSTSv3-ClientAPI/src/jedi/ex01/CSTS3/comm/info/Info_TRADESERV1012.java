package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;


public class Info_TRADESERV1012 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1012";

	public static final String accountID = "1";
	public static final String tradeOperateID = "2";
	public static final String toRemoveOrderID = "3";
	public static final String order4CFD = "4";

	public Info_TRADESERV1012(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(Info_TRADESERV1012.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(Info_TRADESERV1012.accountID, accountID);
	}

	public String getTradeOperateID() {
		try {
			String data=getEntryString(Info_TRADESERV1012.tradeOperateID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeOperateID(String tradeOperateID) {
		setEntry(Info_TRADESERV1012.tradeOperateID, tradeOperateID);
	}

	public long getToRemoveOrderID() {
		try {
			long data=getEntryLong(Info_TRADESERV1012.toRemoveOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setToRemoveOrderID(long toRemoveOrderID) {
		setEntry(Info_TRADESERV1012.toRemoveOrderID, toRemoveOrderID);
	}

	public TOrders4CFD getOrder4CFD() {
		try {
			TOrders4CFD data=getEntryObject(Info_TRADESERV1012.order4CFD);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFD(TOrders4CFD order4CFD) {
		setEntry(Info_TRADESERV1012.order4CFD, order4CFD);
	}


}