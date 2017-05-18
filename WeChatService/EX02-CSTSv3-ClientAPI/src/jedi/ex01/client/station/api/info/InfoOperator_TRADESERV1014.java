package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1014;
import jedi.ex01.CSTS3.comm.struct.MessageToAccount;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1014 extends InfoOperator {

	@Override
	public void onInfo(InfoFather _info) {
		Info_TRADESERV1014 info = (Info_TRADESERV1014) _info;
		MessageToAccount message = info.getMessage();
		message.setIsRead(MTP4CommDataInterface.FALSE);
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MessageReceive, info
				.getMessage());
	}

}
