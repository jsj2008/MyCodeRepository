package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1006;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.operator.DocOperator;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1006 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1006 info = (Info_TRADESERV1006) _info;
		DataDoc.getInstance().getSystemConfig().setTradeDay(info.getTradeDay());
		DataDoc.getInstance().getSystemConfig().setCloseStatus(info.getCloseState());
		
		if (info.getCloseState() == MTP4CommDataInterface.CLOSESTATUS_CLOSE) {
			API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.OTHER_ON_SYSTEMCLOSE);
			AccountStore accoutStore = DataDoc.getInstance().getAccountStore();
			DocOperator.getInstance().loadAccountData(accoutStore.getAccountID());
		} else {
			API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.OTHER_ON_SYSTEMOPEN);
			API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Rollover_Changed);
		}
	}

}
