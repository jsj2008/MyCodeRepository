package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1003;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;
import jedi.ex01.client.station.api.doc.util.AccountScanUtil;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1003 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1003 info = (Info_TRADESERV1003) _info;
		if (DataDoc.getInstance().getAccountStore().getAccountID() != info.getAccountID()) {
			return;
		}
		DataDoc.getInstance().getAccountStore().resetMoneyAccounts(info.getMoneyAccountVec());
		if (DocCaptain.isInited()) {
			try {
				AccountScanUtil.fixAccount(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MoneyAccount_Changed);
	}
}
