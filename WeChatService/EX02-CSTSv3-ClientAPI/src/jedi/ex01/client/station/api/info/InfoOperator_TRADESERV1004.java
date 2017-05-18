package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1004;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.operator.instrument.InstrumentDocOperator;
import jedi.ex01.client.station.api.doc.operator.system.SystemDocOperator;
import jedi.ex01.client.station.api.doc.operator.user.UserDocOperator;

public class InfoOperator_TRADESERV1004 extends InfoOperator {

	public void onInfo(InfoFather _info) {
		Info_TRADESERV1004 info = (Info_TRADESERV1004) _info;
		int attrID = info.getChangedAttrID();
		switch (attrID) {
			case Info_TRADESERV1004.ATTRID_BATCHRATEGAP:
				if (info.getAttriName() == null) {
					InstrumentDocOperator.getInstrumentDocOperator().loadBatchRateGap();
				} else {
					InstrumentDocOperator.getInstrumentDocOperator().loadBatchRateGap(info.getAttriName());
				}
				break;
			case Info_TRADESERV1004.ATTRID_GROUPCONFIG:
				if (DataDoc.getInstance().getGroup().getGroupName().equals(info.getAttriName())) {
					UserDocOperator.getUserDocOperator().loadGroupConfig(info.getAttriName());
				}
				break;
			case Info_TRADESERV1004.ATTRID_HOLIDAY:
				break;
			case Info_TRADESERV1004.ATTRID_INSTRUMENT:
				if (info.getAttriName() == null) {
					InstrumentDocOperator.getInstrumentDocOperator().loadInstruments();
				} else {
					InstrumentDocOperator.getInstrumentDocOperator().loadInstruments(info.getAttriName());
				}
				break;
			case Info_TRADESERV1004.ATTRID_SYSTEMCONFIG:
				SystemDocOperator.getSystemDocOperator().loadSystemConfig();
				break;
//			case Info_TRADESERV1004.ATTRID_TRADETYPE:
//				SystemDocOperator.getSystemDocOperator().loadTradeTypeConfigs();
//				break;
			case Info_TRADESERV1004.ATTRID_INSTRUMENTDEAD:
				Instrument ins = DataDoc.getInstance().getInstrument(info.getAttriName());
				if (ins != null) {
					ins.setIsDead(MTP4CommDataInterface.TRUE);
				}
				break;
		}
	}

}
