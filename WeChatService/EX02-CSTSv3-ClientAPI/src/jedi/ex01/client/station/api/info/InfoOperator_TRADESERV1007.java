package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1007;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1007 extends InfoOperator {

	@Override
	public void onInfo(InfoFather _info) {
		Info_TRADESERV1007 info = (Info_TRADESERV1007) _info;
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MktOrderHasSendToMarket,
				info.getUptradeOperatorID());
	}

}
