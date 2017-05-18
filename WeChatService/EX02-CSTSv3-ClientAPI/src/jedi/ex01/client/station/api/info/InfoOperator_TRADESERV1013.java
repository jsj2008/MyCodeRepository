package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1013;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1013 extends InfoOperator {

	@Override
	public void onInfo(InfoFather _info) {
		Info_TRADESERV1013 info=(Info_TRADESERV1013)_info;
		if(DataDoc.getInstance().getAccountStore().getAccountID()!=info.getAccountID()){
			return;
		}
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.OTHER_ON_MARGINCALL,info.getMarginCall());
	}

}
