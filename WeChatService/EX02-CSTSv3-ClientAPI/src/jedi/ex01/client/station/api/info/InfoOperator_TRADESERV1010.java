package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1010;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;
import jedi.ex01.client.station.api.doc.util.AccountScanUtil;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1010 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1010 info = (Info_TRADESERV1010) _info;
		Long accountID = new Long(info.getAccountID());
		if (DataDoc.getInstance().getAccountStore().getAccountID() != accountID) {
			return;
		}
		if (info.getMoneyAccountVec() != null) {
			DataDoc.getInstance().getAccountStore().resetMoneyAccounts(info.getMoneyAccountVec());
		}
		if (info.getOrder4CFDVec() != null) {
			DataDoc.getInstance().resetOrders(info.getOrder4CFDVec());
		}
		if (info.getTrade4CFDVec() != null) {
			DataDoc.getInstance().resetTrades(info.getTrade4CFDVec());
		}
		if (DocCaptain.isInited()) {
			try {
				AccountScanUtil.fixAccount(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (info.getTsettledVec() != null && info.getTsettledVec().length > 0) {
			DataDoc.getInstance().addSettle(info.getTsettledVec());
			API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_TSETTLED4CFD_CHANGED);
		}
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MoneyAccount_Changed);
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Trade_Changed);
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Order_Changed);
		if (info.getTradeOperateID().equalsIgnoreCase("TRADESERV5202") && info.getOrderHis() != null) {
			API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Order_Trade, info
					.getOrderHis().getOrderID());
		}
	}

}
