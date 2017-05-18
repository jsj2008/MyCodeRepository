package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.v7.trade.comm.infor.Info_TRADESERV1012;


public class C3_Info_TRADESERV1012 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1012";

	public static final String accountID = "1";
	public static final String tradeOperateID = "2";
	public static final String toRemoveOrderID = "3";
	public static final String order4CFD = "4";

	public C3_Info_TRADESERV1012(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1012 data) throws Exception {
		super.parseFromSysData(data);
		setAccountID(data.getAccountID());
		setTradeOperateID(data.getTradeOperateID());
		setToRemoveOrderID(data.getToRemoveOrderID());
		C3_TOrders4CFD order4CFD = new C3_TOrders4CFD();
		order4CFD.parseFromSysData(data.getOrder4CFD());
		setOrder4CFD(order4CFD);
	}


	public long getAccountID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1012.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_Info_TRADESERV1012.accountID, accountID);
	}

	public String getTradeOperateID() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1012.tradeOperateID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeOperateID(String tradeOperateID) {
		setEntry(C3_Info_TRADESERV1012.tradeOperateID, tradeOperateID);
	}

	public long getToRemoveOrderID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1012.toRemoveOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setToRemoveOrderID(long toRemoveOrderID) {
		setEntry(C3_Info_TRADESERV1012.toRemoveOrderID, toRemoveOrderID);
	}

	public C3_TOrders4CFD getOrder4CFD() {
		try {
			C3_TOrders4CFD data=getEntryObject(C3_Info_TRADESERV1012.order4CFD);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder4CFD(C3_TOrders4CFD order4CFD) {
		setEntry(C3_Info_TRADESERV1012.order4CFD, order4CFD);
	}


}