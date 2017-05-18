package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1005;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;
import jedi.ex01.client.station.api.doc.operator.DocOperator;
import jedi.ex01.client.station.api.doc.operator.instrument.InstrumentDocOperator;
import jedi.ex01.client.station.api.doc.operator.user.UserDocOperator;

public class InfoOperator_TRADESERV1005 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1005 info = (Info_TRADESERV1005) _info;
		switch (info.getChangedAttrID()) {
			case Info_TRADESERV1005.ATTRID_ACCOUNTSTRATEGY:
				DocOperator.getInstance().resetUserDoc();
				DocCaptain.setInited(true);
				break;
			case Info_TRADESERV1005.ATTRID_INSTRUMENTCFG4ACCOUNT:
				if (DataDoc.getInstance().getAccountStore().getAccountID() != info.getAccountID()) {
					return;
				}
				if (info.getInstrumentName() == null) {
					InstrumentDocOperator.getInstrumentDocOperator().loadInstruments();
				} else {
					InstrumentDocOperator.getInstrumentDocOperator().loadInstruments(
							info.getInstrumentName());
				}
				break;
			case Info_TRADESERV1005.ATTRID_INSTRUMENTCFG4GROUP:
				if (!DataDoc.getInstance().getGroup().getGroupName().equals(info.getGroupName())) {
					return;
				}
				if (info.getInstrumentName() == null) {
					InstrumentDocOperator.getInstrumentDocOperator().loadInstruments();
				} else {
					InstrumentDocOperator.getInstrumentDocOperator().loadInstruments(
							info.getInstrumentName());
				}
				break;
			case Info_TRADESERV1005.ATTRID_USERLOGIN:
				if (!DataDoc.getInstance().getUserLogin().getAeid().equals(info.getAeid())) {
					return;
				}
				UserDocOperator.getUserDocOperator().loadUserLogin(info.getAeid());
				break;
			case Info_TRADESERV1005.ATTRID_ACCOUNT_DELETE:
				// DataDoc.getInstance().killUserAccount(new Long(tinfo.getAccountID()));
				break;
		}
	}
}
