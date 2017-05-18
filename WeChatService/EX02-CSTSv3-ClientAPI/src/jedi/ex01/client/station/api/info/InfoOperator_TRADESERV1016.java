package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1016;
import jedi.ex01.client.station.api.doc.util.DocUtil;

public class InfoOperator_TRADESERV1016 extends InfoOperator {

	@Override
	public void onInfo(InfoFather _info) {
		 Info_TRADESERV1016 info = (Info_TRADESERV1016) _info;
		 DocUtil.setClosedInstruments(info.getClosedInstruments());
//		 APIDocCaptain.setTimedoutQuote(info.getTimedoutInstruments());
	}
}
