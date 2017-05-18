package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1012;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class InfoOperator_TRADESERV1012 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1012 info = (Info_TRADESERV1012) _info;
		if (DataDoc.getInstance().getAccountStore().getAccountID() != info.getAccountID()) {
			return;
		}
		if (info.getToRemoveOrderID() > 0) {
			Long orderID = new Long(info.getToRemoveOrderID());
			TOrders4CFD temporder = DataDoc.getInstance().getOrder(orderID);
			if (temporder.getCorrespondingTicket() > 0) {
				TTrade4CFD temptrade = DataDoc.getInstance().getTrade(temporder.getCorrespondingTicket());
				if (temptrade != null) {
					temptrade.setCorOrderID(0);
				}
			}
			DataDoc.getInstance().removeOrder(orderID);
		}
		if (info.getOrder4CFD() != null) {
			DataDoc.getInstance().addOrder(info.getOrder4CFD());
			if (info.getOrder4CFD().getCorrespondingTicket() > 0) {
				TTrade4CFD temptrade = DataDoc.getInstance().getTrade(
						info.getOrder4CFD().getCorrespondingTicket());
				if (temptrade != null) {
					temptrade.setCorOrderID(info.getOrder4CFD().getOrderID());
				}
			}
		}
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Order_Changed);
		if (info.getOrder4CFD().getCorrespondingTicket() > 0) {
			API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Trade_Changed);
		}
	}

}
