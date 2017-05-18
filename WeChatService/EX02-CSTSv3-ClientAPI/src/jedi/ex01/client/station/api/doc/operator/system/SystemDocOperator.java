package jedi.ex01.client.station.api.doc.operator.system;

import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5010;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5011;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5016;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5010;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5011;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5016;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class SystemDocOperator {
	private static SystemDocOperator systemDocOperator=new SystemDocOperator();
	private SystemDocOperator(){
	}
	
	public boolean loadBasicCurrency(){
		IP_TRADESERV5010 ip = new IP_TRADESERV5010();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5010 op = (OP_TRADESERV5010) opfather;
		DataDoc.getInstance().resetBasicCurrencys(op.getBasicCurrencyVec());
		return true;
	}
	
	public boolean loadSystemConfig(){
		IP_TRADESERV5011 ip = new IP_TRADESERV5011();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5011 op = (OP_TRADESERV5011) opfather;
		DataDoc.getInstance().setSystemConfig(op.getSystemConfig());
		return true;
	}
	
//	public boolean loadTradeTypeConfigs(){
//		IP_TRADESERV5016 ip = new IP_TRADESERV5016();
//		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
//		if (!opfather.isSucceed()) {
//			return false;
//		}
//		OP_TRADESERV5016 op = (OP_TRADESERV5016) opfather;
//		DataDoc.getInstance().setCfdTradeTypeConfig(op.getTradeTypeConfigVec()[0]);
//		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_TradeType_Changed);
//		return true;
//	}
	
	public static SystemDocOperator getSystemDocOperator() {
		return systemDocOperator;
	}
}
