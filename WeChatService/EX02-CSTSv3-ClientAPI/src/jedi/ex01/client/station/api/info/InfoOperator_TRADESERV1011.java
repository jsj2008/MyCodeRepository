package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1011;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;
import jedi.ex01.client.station.api.doc.util.AccountScanUtil;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1011 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1011 info = (Info_TRADESERV1011) _info;
		DataDoc.getInstance().getAccountStore().resetMoneyAccounts(info.getMoneyAccountVec());
		DataDoc.getInstance().resetTrades(info.getTrade4CFDVec());
		DataDoc.getInstance().resetOrders(info.getOrder4CFDVec());
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MoneyAccount_Changed);
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
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Trade_Changed);
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Order_Changed);
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Liquidation);
	}
}
