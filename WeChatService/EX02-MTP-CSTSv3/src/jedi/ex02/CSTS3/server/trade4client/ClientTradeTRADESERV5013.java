package jedi.ex02.CSTS3.server.trade4client;

import java.util.HashMap;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_TRADESERV5013;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5013;
import jedi.ex02.CSTS3.comm.struct.C3_Instrument;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.DB.InstrumentsAccountCfg;
import jedi.v7.comm.datastruct.DB.InstrumentsGroupCfg;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5020;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5021;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5013;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5020;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5021;

public class ClientTradeTRADESERV5013 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid,
			String ipaddress) {
		C3_IP_TRADESERV5013 ip = (C3_IP_TRADESERV5013) _ip;
		C3_OP_TRADESERV5013 op = new C3_OP_TRADESERV5013(ip);
		HashMap<String, C3_Instrument> instMap=new HashMap<String, C3_Instrument>();
		IPFather fip = ip.formatIP();
		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip,
				aeid, ipaddress);
		try {
			op.parseFromSysData(fop);
			if (fop.isSucceed()) {
				OP_TRADESERV5013 op5013 = (OP_TRADESERV5013) fop;
				op.parseFromSysData(op5013);
				C3_Instrument[] insts=op.getInstrumentVec();
				for (C3_Instrument inst : insts) {
					instMap.put(inst.getInstrument(), inst);
				}
				////////////////////
				IP_TRADESERV5020 ip5020 = new IP_TRADESERV5020();
//				ip5020.setAeid(ip.getUserName());
				ip5020.setGroupName(ip.getGroupName());
				if(ip.getInstrumentName()==null){
					ip5020.setToQueryAll(true);
				}else{
					ip5020.setInstrumentName(ip.getInstrumentName());
				}
				fop=StaticContext.getClientTradeCaptain().doSysTrade(ip5020, aeid, ipaddress);
				if(fop.isSucceed()){
					OP_TRADESERV5020 op5020 = (OP_TRADESERV5020) fop;
					for (InstrumentsGroupCfg igc : op5020.getInstrumentGroupCfgVec()) {
						C3_Instrument inst=instMap.get(igc.getInstrument());
						inst.parseFromSysData(igc);
					}
					//////////////////////////
					IP_TRADESERV5021 ip5021 = new IP_TRADESERV5021();
//					ip5021.setAeid(ip.getUserName());
					ip5021.setAccountID(ip.getAccountId());
					if(ip.getInstrumentName()==null){
						ip5021.setToQueryAll(true);
					}else{
						ip5021.setInstrumentName(ip.getInstrumentName());
					}
					fop=StaticContext.getClientTradeCaptain().doSysTrade(ip5021, aeid, ipaddress);
					if(fop.isSucceed()){
						OP_TRADESERV5021 op5021 = (OP_TRADESERV5021) fop;
						for (InstrumentsAccountCfg iac : op5021.getInstrumentAccountCfgVec()) {
							C3_Instrument inst=instMap.get(iac.getInstrument());
							inst.parseFromSysData(iac);
						}
						op.setInstrumentVec(instMap.values().toArray(new C3_Instrument[0]));
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		op.setSucceed(fop.isSucceed());
		op.setErrCode(fop.getErrCode());
		op.setErrMessage(fop.getErrMessage());
		return op;
	}

}
